#!/bin/bash

# ==============================================================================
# Neovim (GitHub Latest) & NvChad Installer/Updater
# Supported OS: Debian-based distributions (Ubuntu, Kali, Linux Mint, etc.)
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status

echo -e "\n[+] Starting Neovim and NvChad setup/update process...\n"

# 1. Install required dependencies
echo "=> Installing dependencies via apt..."
sudo apt update
sudo apt install -y curl git build-essential ripgrep unzip fd-find

# Block 'neovim' from being installed via apt to prevent conflicts with our manual install
echo "=> Locking apt to prevent official neovim package installation..."
echo -e "Package: neovim\nPin: release *\nPin-Priority: -1" | sudo tee /etc/apt/preferences.d/block-neovim > /dev/null

# Create a symlink for fd-find if it doesn't exist (required by Telescope)
if [ -x "$(command -v fdfind)" ]; then
	mkdir -p ~/.local/bin
	ln -sf $(which fdfind) ~/.local/bin/fd
	export PATH="$HOME/.local/bin:$PATH"
fi

# 2. Install or Update Neovim from GitHub Releases
echo -e "\n[+] Fetching the latest Neovim release from GitHub..."
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Download the latest pre-compiled Linux binary
curl -LOs https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

echo "=> Extracting and updating Neovim in /opt/nvim..."
# Prepare clean deployment directory
sudo rm -rf /opt/nvim
sudo mkdir -p /opt/nvim

# Strip the top-level directory from the tarball to keep /opt/nvim clean
sudo tar -xzf nvim-linux-x86_64.tar.gz -C /opt/nvim --strip-components=1

# Create a global symlink so 'nvim' can be executed from anywhere
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# Cleanup temporary files
cd ~
rm -rf "$TMP_DIR"

# Verify installation/update
NVIM_VERSION=$(nvim --version | head -n 1)
echo "=> Successfully installed/updated to: $NVIM_VERSION"

# 3. Install NvChad (Only if no configuration exists)
if [ ! -d "$HOME/.config/nvim" ]; then
	echo -e "\n[+] No Neovim configuration found. Installing NvChad starter..."

	# Clean previous cache/state to prevent conflicts
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim

	# Clone the starter template
	git clone https://github.com/NvChad/starter ~/.config/nvim --depth 1
	# Remove the .git folder to allow for personal version control
	rm -rf ~/.config/nvim/.git

	echo -e "\n[+] NvChad installed successfully!"
else
	echo -e "\n[+] Existing Neovim configuration detected in ~/.config/nvim."
	echo "=> Skipping NvChad installation to preserve your current setup."
fi 

echo -e "\n[+] Process complete! Run 'nvim' in your terminal."
