vi -c "PlugUpdate | PlugUpgrade | qa"
bubu
brew reinstall --HEAD neovim
upgrade_oh_my_zsh
antigen update
antigen selfupdate
pip install --upgrade -r ~/workspace-setup/requirements.txt
