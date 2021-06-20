# Dotfiles!

The best way to install these dotfiles is using [GNU-stow](https://www.gnu.org/software/stow/). For Debian-like distributions, you would thus sync with your home directory as follows:
```bash
cd && git clone --recurse-submodules https://github.com/gfanto/dotfiles.git
sudo apt-get install stow && cd dotfiles && stow .
```
