#!/bin/bash
# this should be run after dropbox has been installed using
# system-setup.sh.  It's then necessary to sync the dotfiles
# directory

unamestr=`uname`
if [[ $unamestr == 'Darwin' ]]; then
  bashfile=~/.bash_profile
else
  bashfile=~/.bashrc
fi
if ! grep Dropbox $bashfile; then
  echo 'linking bashrc'
  echo '. ~/Dropbox/dotfiles/bashrc' >> $bashfile
fi

ln ~/Dropbox/dotfiles/conkyrc ~/.conkyrc
ln ~/Dropbox/dotfiles/conkyrc2 ~/.conkyrc2
ln ~/Dropbox/dotfiles/conkyrc3 ~/.conkyrc3
ln ~/Dropbox/dotfiles/gitconfig ~/.gitconfig
ln ~/Dropbox/dotfiles/vimrc ~/.vimrc

if [[ $unamestr == 'Linux' ]]; then
  ln ~/Dropbox/Templates/Document.odt ~/Templates/Document.odt
  ln ~/Dropbox/Templates/Spreadsheet.ods ~/Templates/Spreadsheet.ods
fi

mkdir -p ~/.ssh
ln ~/Dropbox/dotfiles/ssh/id_rsa ~/.ssh/id_rsa
ln ~/Dropbox/dotfiles/ssh/id_rsa.pub ~/.ssh/id_rsa.pub
mkdir -p ~/.vim
cp -rn ~/Dropbox/dotfiles/vim/* ~/.vim/

# copy firefox extensions
myDefault=`ls ~/.mozilla/firefox/ | grep default`
cp ~/Dropbox/ffaddons/*.xpi ~/.mozilla/firefox/$myDefault/extensions/
firefox http://userscripts.org/scripts/source/24430.user.js http://userscripts.org/scripts/source/9310.user.js http://userscripts.org/scripts/source/22275.user.js
ln ~/Dropbox/conky_start.sh.desktop ~/.config/autostart/
