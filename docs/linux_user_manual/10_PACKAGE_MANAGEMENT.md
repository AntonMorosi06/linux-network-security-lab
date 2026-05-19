# Package Management

Package managers install, update and remove software.

## Debian/Ubuntu

```bash
sudo apt update
sudo apt install package_name
sudo apt remove package_name
apt search package_name
```

## Fedora

```bash
sudo dnf install package_name
sudo dnf remove package_name
dnf search package_name
```

## Arch

```bash
sudo pacman -S package_name
sudo pacman -R package_name
pacman -Ss package_name
```

## macOS Homebrew

```bash
brew update
brew install package_name
brew uninstall package_name
brew search package_name
```

## Safety

Installing packages changes the system. Prefer official repositories and understand what you install.
