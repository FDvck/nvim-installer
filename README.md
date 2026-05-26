# nvim-installer

An automated setup script designed to quickly bootstrap a modern Neovim environment using the [NvChad](https://nvchad.com/) starter template on Debian-based Linux distributions (Ubuntu, Kali, Linux Mint, etc.).

## ✨ Features

* **Always Up-to-Date:** Fetches and installs the latest pre-compiled Neovim binary (`nvim-linux-x86_64.tar.gz`) directly from the official GitHub releases.
* **Smart Dependency Management:** Automatically installs required dependencies (`curl`, `git`, `build-essential`, `ripgrep`, `unzip`, `fd-find`).
* **Apt Conflict Prevention:** Locks the official `neovim` apt package (assigns a negative priority) to prevent the OS from accidentally overwriting your manual installation with an outdated version.
* **Symlink Configuration:** Automatically sets up necessary symlinks for `fd` and `nvim` in your `$PATH` (`~/.local/bin` and `/usr/local/bin`).
* **Clean NvChad Setup:** Clones the NvChad starter template without the `.git` directory, leaving it ready for your own version control. Safely skips installation if an existing configuration is detected in `~/.config/nvim`.

## 🚀 Usage

Clone this repository and execute the installer script. You will be prompted for your `sudo` password to install dependencies and place the Neovim binary in `/opt`.

```bash
# 1. Clone the repository
git clone https://github.com/fduck/nvim-installer.git
cd nvim-installer

# 2. Make the script executable
chmod +x nvim-installer.sh

# 3. Run the installer
./nvim-installer.sh
