set -e
#!/bin/bash
# this should be run after dropbox has been installed using
# system-setup.sh.  It's then necessary to sync the dotfiles
# directory

FILE_ROOT=$HOME/Sync

ln -sf $FILE_ROOT/dotfiles/bashrc ~/.bashrc
ln -sf $FILE_ROOT/dotfiles/rspec ~/.rspec
ln -sf $FILE_ROOT/dotfiles/rvmrc ~/.rvmrc
ln -sf $FILE_ROOT/dotfiles/gemrc ~/.gemrc
ln -sf $FILE_ROOT/dotfiles/gitconfig ~/.gitconfig
ln -sf $FILE_ROOT/dotfiles/gitignore_global ~/.gitignore_global
ln -sf $FILE_ROOT/dotfiles/vimrc ~/.vimrc
ln -sf $FILE_ROOT/dotfiles/gtk-bookmarks ~/.gtk-bookmarks
ln -sf $FILE_ROOT/dotfiles/irbrc ~/.irbrc
ln -sf $FILE_ROOT/dotfiles/irb-save-history ~/.irb-save-history
ln -sf $FILE_ROOT/dotfiles/jslintrc ~/.jslintrc
ln -sf $FILE_ROOT/dotfiles/railsrc ~/.railsrc

ln -sf $FILE_ROOT/dotfiles/.ssh ~/
ln -sf $FILE_ROOT/dotfiles/.vim ~/
ln -sf $FILE_ROOT/dotfiles/banshee-1 ~/.config/

ln -sf $FILE_ROOT/list.txt ~/list.txt
ln -sf $FILE_ROOT/Documents/bars.yml ~/bars.yml
ln -sf $FILE_ROOT/Documents/rudo.yml ~/rudo.yml
ln -sf $FILE_ROOT/Templates/Document.odt ~/Templates/Document.odt
ln -sf $FILE_ROOT/Templates/Spreadsheet.ods ~/Templates/Spreadsheet.ods
