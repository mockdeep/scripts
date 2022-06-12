set -e
#!/bin/bash
# this should be run after dropbox has been installed using
# system-setup.sh.  It's then necessary to sync the dotfiles
# directory

FILE_ROOT=$HOME/Dropbox

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

ln -sf $FILE_ROOT/list.txt ~/list.txt

# ASDF related stuff
ln -sf $FILE_ROOT/dotfiles/asdfrc ~/.asdfrc
ln -sf $FILE_ROOT/dotfiles/default-gems ~/.default-gems
ln -sf $FILE_ROOT/dotfiles/tool-versions ~/.tool-versions
ln -sf $FILE_ROOT/dotfiles/asdf-postgres-configure-options ~/.asdf-postgres-configure-options
