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

ln -s ~/Dropbox/dotfiles/conkyrc ~/.conkyrc
ln -s ~/Dropbox/dotfiles/conkyrc2 ~/.conkyrc2
ln -s ~/Dropbox/dotfiles/conkyrc3 ~/.conkyrc3
ln -s ~/Dropbox/dotfiles/gitconfig ~/.gitconfig
ln -s ~/Dropbox/dotfiles/vimrc ~/.vimrc
ln -s ~/Dropbox/dotfiles/gtk-bookmarks ~/.gtk-bookmarks
ln -s ~/Dropbox/dotfiles/irbrc ~/.irbrc
ln -s ~/Dropbox/dotfiles/irb-save-history ~/.irb-save-history
ln -s ~/Dropbox/dotfiles/jslintrc ~/.jslintrc

if [[ $unamestr == 'Linux' ]]; then
  ln -s ~/Dropbox/Templates/Document.odt ~/Templates/Document.odt
  ln -s ~/Dropbox/Templates/Spreadsheet.ods ~/Templates/Spreadsheet.ods
fi

ln -s ~/Dropbox/dotfiles/ssh ~/.ssh
ln -s ~/Dropbox/dotfiles/vim ~/.vim
ln -s ~/Dropbox/Documents/bars.yml ~/bars.yml
ln -s ~/Dropbox/Documents/rudo.yml ~/rudo.yml

# copy firefox extensions
myDefault=`ls ~/.mozilla/firefox/ | grep default`
cp ~/Dropbox/ffaddons/*.xpi ~/.mozilla/firefox/$myDefault/extensions/
firefox http://userscripts.org/scripts/source/24430.user.js http://userscripts.org/scripts/source/9310.user.js http://userscripts.org/scripts/source/22275.user.js
ln -s ~/Dropbox/conky_start.sh.desktop ~/.config/autostart/
