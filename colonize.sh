#!/bin/sh

ln -s -f `which vim` `which vi`
ln -s -f `pwd`/.tmux.conf ~/.tmux.conf
mkdir -p ~/.byobu
ln -s -f `pwd`/.tmux.conf ~/.byobu/.tmux.conf
mkdir -p ~/.ipython/profile_default
ln -s -f `pwd`/ipython_config.py ~/.ipython/profile_default/ipython_config.py

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s -f `pwd`/.zshrc ~/.zshrc
curl -L git.io/antigen > antigen.zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
