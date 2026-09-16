#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; }

if [ ! -f /etc/arch-release ]; then
    error "This installer is for Arch-based distros only."
    exit 1
fi

setup_chaotic_aur() {
    if pacman -Qi chaotic-keyring &>/dev/null; then
        info "Chaotic-AUR already configured."
        return
    fi

    warn "Setting up Chaotic-AUR..."
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf 2>/dev/null; then
        echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
    fi

    sudo pacman -Sy
    info "Chaotic-AUR ready."
}

install_official() {
    info "Installing official packages..."

    local pkg_file="$REPO_DIR/install/packages.txt"
    if [ ! -f "$pkg_file" ]; then
        error "packages.txt not found at $pkg_file"
        exit 1
    fi

    mapfile -t packages < <(
        grep -v '^\s*#' "$pkg_file" | grep -v '^\s*$'
    )

    if [ ${#packages[@]} -gt 0 ]; then
        sudo pacman -S --needed --noconfirm "${packages[@]}"
        info "Official packages installed."
    fi
}

install_aur() {
    info "Installing AUR packages..."

    local aur_file="$REPO_DIR/install/aur-packages.txt"
    if [ ! -f "$aur_file" ]; then
        warn "aur-packages.txt not found. Skipping."
        return
    fi

    if ! command -v yay &>/dev/null; then
        error "yay not found. Install yay first."
        warn "AUR packages to install:"
        grep -v '^\s*#' "$aur_file" | grep -v '^\s*$'
        return
    fi

    mapfile -t packages < <(
        grep -v '^\s*#' "$aur_file" | grep -v '^\s*$'
    )

    if [ ${#packages[@]} -gt 0 ]; then
        yay -S --needed --noconfirm "${packages[@]}"
        info "AUR packages installed."
    fi
}

setup_symlinks() {
    info "Setting up config symlinks..."

    _symlink_config() {
        local name="$1"
        local target="$CONFIG_DIR/$name"
        local source="$REPO_DIR/config/$name"

        if [ ! -e "$source" ]; then
            return
        fi

        # clipcat configs have per-user paths (UID in /run/user/$UID/),
        # so copy instead of symlink to allow per-user patching.
        if [ "$name" = "clipcat" ]; then
            # Remove broken symlinks before copying
            if [ -L "$target" ] && [ ! -e "$target" ]; then
                rm "$target"
            fi
            if [ ! -e "$target" ]; then
                cp -r "$source" "$target"
                info "  ~/.config/$name copied (symlink not suitable)"
            else
                info "  ~/.config/$name already exists (skipping copy)"
            fi
            return
        fi

        if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$source")" ]; then
            info "  ~/.config/$name symlink already correct"
        elif [ -d "$target" ] && [ ! -L "$target" ]; then
            warn "  ~/.config/$name is a real directory. Backing up and replacing with symlink."
            mv "$target" "${target}.bak"
            ln -sf "$source" "$target"
        elif [ ! -e "$target" ]; then
            ln -sf "$source" "$target"
        else
            rm -f "$target"
            ln -sf "$source" "$target"
        fi
    }

    # Symlink all configs in the repo
    for cfg in "$REPO_DIR"/config/*/; do
        cfg_name=$(basename "$cfg")
        _symlink_config "$cfg_name"
    done

    # Create mpd runtime directories
    mkdir -p "$CONFIG_DIR/mpd/playlists"

    # Create ~/.themes symlink for GTK theme
    if [ ! -e "$HOME/.themes" ]; then
        ln -sf "$REPO_DIR/themes" "$HOME/.themes"
        info "  ~/.themes → MochaLand/themes"
    fi

    # Symlink $HOME files (home/.zshrc → ~/.zshrc, etc.)
    while IFS= read -r -d '' file; do
        rel="${file#$REPO_DIR/home/}"
        target="$HOME/$rel"
        mkdir -p "$(dirname "$target")"
        if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$file")" ]; then
            info "  ~/$rel symlink already correct"
        elif [ -f "$target" ] && [ ! -L "$target" ]; then
            warn "  ~/$rel is a real file. Backing up."
            mv "$target" "${target}.bak"
            ln -sf "$file" "$target"
        elif [ ! -e "$target" ]; then
            ln -sf "$file" "$target"
        else
            rm -f "$target"
            ln -sf "$file" "$target"
        fi
    done < <(find "$REPO_DIR/home" -type f -print0 2>/dev/null)

    info "Symlinks created."
}

enable_services() {
    info "Enabling systemd services..."

    local services=(
        "bluetooth.service"
        "networkmanager.service"
        "firewalld.service"
        "pipewire.socket"
        "pipewire-pulse.socket"
        "wireplumber.service"
    )

    for svc in "${services[@]}"; do
        if systemctl --user -q is-enabled "$svc" 2>/dev/null || \
           systemctl -q is-enabled "$svc" 2>/dev/null; then
            info "  $svc already enabled"
        else
            if systemctl list-unit-files "$svc" &>/dev/null; then
                if [[ "$svc" == *.service ]]; then
                    sudo systemctl enable --now "$svc" 2>/dev/null || \
                        systemctl --user enable --now "$svc" 2>/dev/null || \
                        warn "  Could not enable $svc"
                else
                    systemctl --user enable --now "$svc" 2>/dev/null || \
                        warn "  Could not enable $svc"
                fi
                info "  Enabled $svc"
            else
                warn "  $svc not found on this system"
            fi
        fi
    done
}

apply_theme() {
    info "Applying theme..."
    local theme_script="$CONFIG_DIR/hypr/scripts/apply-theme"
    if [ -f "$theme_script" ]; then
        "$theme_script" catppuccin-mocha
        info "Theme applied."
    else
        warn "apply-theme script not found at $theme_script"
    fi
}

set_default_shell() {
    local zsh_path
    zsh_path="$(command -v zsh)" || true

    if [ -z "$zsh_path" ]; then
        warn "zsh not found. Skipping shell change."
        return
    fi

    if [ "$SHELL" = "$zsh_path" ]; then
        info "zsh already default shell."
        return
    fi

    info "Changing default shell to zsh..."

    if chsh -s "$zsh_path"; then
        info "Default shell changed to zsh."
    else
        warn "Could not change shell automatically."
        warn "Run manually:"
        warn "chsh -s $zsh_path"
    fi
}

fix_clipcat_uids() {
    local uid
    uid=$(id -u)
    local clipcat_dir="$CONFIG_DIR/clipcat"

    if [ ! -d "$clipcat_dir" ]; then
        warn "clipcat config directory not found. Skipping UID fix."
        return
    fi

    local fixed=0
    for f in "$clipcat_dir"/*.toml; do
        if [ -f "$f" ] && grep -q '/run/user/$UID/' "$f" 2>/dev/null; then
            sed -i "s|/run/user/\$UID/|/run/user/$uid/|g" "$f"
            info "  Fixed UID paths in clipcat/$(basename "$f")"
            fixed=$((fixed + 1))
        fi
    done

    if [ "$fixed" -gt 0 ]; then
        info "clipcat config UIDs updated to match user $uid."
    fi
}

setup_clipcat() {
    info "Setting up clipcat..."

    pkill clipcatd 2>/dev/null || true
    rm -rf "/run/user/$(id -u)/clipcat"

    mkdir -p "/run/user/$(id -u)/clipcat"

    if command -v clipcatd >/dev/null 2>&1; then
        nohup clipcatd >/dev/null 2>&1 &
        sleep 1

        if clipcatctl list >/dev/null 2>&1; then
            info "clipcat initialized successfully."
        else
            warn "clipcat started but gRPC socket is unavailable."
        fi
    else
        warn "clipcatd not installed."
    fi
}

main() {
    echo "============================================"
    echo "  MochaLand Installer"
    echo "============================================"
    echo ""

    setup_chaotic_aur
    install_official
    install_aur
    setup_symlinks
    fix_clipcat_uids
    set_default_shell
    setup_clipcat
    enable_services
    apply_theme

    echo ""
    info "Installation complete!"
    info "Reboot or restart Hyprland to apply changes."
}

main "$@"
