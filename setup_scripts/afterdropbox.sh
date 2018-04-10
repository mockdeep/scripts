set -e
#!/bin/bash
# this should be run after dropbox has been installed using
# system-setup.sh.  It's then necessary to sync the dotfiles
# directory

ln -sf ~/Dropbox/dotfiles/bashrc ~/.bashrc
ln -sf ~/Dropbox/dotfiles/rspec ~/.rspec
ln -sf ~/Dropbox/dotfiles/rvmrc ~/.rvmrc
ln -sf ~/Dropbox/dotfiles/gemrc ~/.gemrc
ln -sf ~/Dropbox/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/Dropbox/dotfiles/gitignore_global ~/.gitignore_global
ln -sf ~/Dropbox/dotfiles/vimrc ~/.vimrc
ln -sf ~/Dropbox/dotfiles/gtk-bookmarks ~/.gtk-bookmarks
ln -sf ~/Dropbox/dotfiles/irbrc ~/.irbrc
ln -sf ~/Dropbox/dotfiles/irb-save-history ~/.irb-save-history
ln -sf ~/Dropbox/dotfiles/jslintrc ~/.jslintrc
ln -sf ~/Dropbox/dotfiles/railsrc ~/.railsrc

ln -sf ~/Dropbox/dotfiles/.ssh ~/
ln -sf ~/Dropbox/dotfiles/.vim ~/
ln -sf ~/Dropbox/dotfiles/banshee-1 ~/.config/

ln -sf ~/Dropbox/list.txt ~/list.txt
ln -sf ~/Dropbox/Documents/bars.yml ~/bars.yml
ln -sf ~/Dropbox/Documents/rudo.yml ~/rudo.yml
ln -sf ~/Dropbox/Templates/Document.odt ~/Templates/Document.odt
ln -sf ~/Dropbox/Templates/Spreadsheet.ods ~/Templates/Spreadsheet.ods
