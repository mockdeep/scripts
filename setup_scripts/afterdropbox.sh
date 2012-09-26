set -e
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

ln -sf ~/Dropbox/dotfiles/conkyrc ~/.conkyrc
ln -sf ~/Dropbox/dotfiles/conkyrc2 ~/.conkyrc2
ln -sf ~/Dropbox/dotfiles/conkyrc3 ~/.conkyrc3
ln -sf ~/Dropbox/dotfiles/gemrc ~/.gemrc
ln -sf ~/Dropbox/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/Dropbox/dotfiles/gitignore_global ~/.gitignore_global
ln -sf ~/Dropbox/dotfiles/vimrc ~/.vimrc
ln -sf ~/Dropbox/dotfiles/gtk-bookmarks ~/.gtk-bookmarks
ln -sf ~/Dropbox/dotfiles/irbrc ~/.irbrc
ln -sf ~/Dropbox/dotfiles/irb-save-history ~/.irb-save-history
ln -sf ~/Dropbox/dotfiles/jslintrc ~/.jslintrc

ln -sf ~/Dropbox/dotfiles/.ssh ~/
ln -sf ~/Dropbox/dotfiles/.vim ~/
#ln -sf ~/Dropbox/dotfiles/deluge ~/.config/
ln -sf ~/Dropbox/dotfiles/banshee-1 ~/.config/
ln -sf ~/Dropbox/dotfiles/gconf.xml ~/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml

ln -sf ~/Dropbox/Documents/bars.yml ~/bars.yml
ln -sf ~/Dropbox/Documents/rudo.yml ~/rudo.yml

if [[ $unamestr == 'Linux' ]]; then
  ln -sf ~/Dropbox/Templates/Document.odt ~/Templates/Document.odt
  ln -sf ~/Dropbox/Templates/Spreadsheet.ods ~/Templates/Spreadsheet.ods
fi
