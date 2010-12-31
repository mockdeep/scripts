set -e
echo "first we'll update what we've got:"
echo "----------------------------------"
sudo apt-get -y update && sudo apt-get upgrade
sudo apt-get dist-upgrade
#sudo gem update --system
#sudo gem update
echo "setting up editors/ides/build tools:"
echo "----------------------------------"
sudo apt-get install -y vim eclipse build-essential ruby ri rdoc python git curl mysql-server-5.0 zlib1g-dev coreutils libtool bison libxt-dev openvpn tunneldigger ruby1.8-dev
echo "setting up media players:"
echo "----------------------------------"
sudo apt-get install -y vlc flashplugin-nonfree mplayer gstreamer0.10-ffmpeg gstreamer0.10-fluendo-mp3 gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad
echo "installing tools, etc."
echo "----------------------------------"
sudo apt-get install -y gnome-do gimp conky chromium-browser compizconfig-settings-manager compiz-fusion-plugins-extra comix xsane wmctrl iotop

if !  dpkg -l nautilus-dropbox > /dev/null; then
    echo 'dropbox not installed...'
    #wget http://linux.dropbox.com/packages/nautilus-dropbox_0.6.3_i386.deb
    #sudo dpkg -i nautilus-dropbox_0.6.3_i386.deb
    #rm nautilus-dropbox_0.6.3_i386.deb
fi

if ! gem -v > /dev/null; then
    echo 'install rubygems'
    wget http://rubyforge.org/frs/download.php/70696/rubygems-1.3.7.tgz
    tar xvzf rubygems-1.3.7.tgz
    cd rubygems-1.3.7
    sudo ruby setup.rb
    cd ..
    rm -rf rubygems-1.3.7
    rm rubygems-1.3.7.tgz
    sudo ln -s /usr/bin/gem1.8 /usr/local/bin/gem
    sudo ln -s /usr/bin/ruby1.8 /usr/local/bin/ruby
    sudo ln -s /usr/bin/rdoc1.8 /usr/local/bin/rdoc
    sudo ln -s /usr/bin/ri1.8 /usr/local/bin/ri
    sudo ln -s /usr/bin/irb1.8 /usr/local/bin/irb
fi
#wget http://linux.dropbox.com/packages/nautilus-dropbox_0.6.3_i386.deb
#sudo dpkg -i nautilus-dropbox_0.6.3_i386.deb
# nautilus-dropbox
# download rubygems from web
# change gnome-do settings
# turn off sleep, screensaver
# create hotkey to lock computer
# install rails, rspec, rspec-rails, rvm, cucumber
# install firefox plugins
# install dropbox
# add medibuntu repositories
# install libdvdcss
# install adobe reader, skype
# install NerdTree, buffer explorer
# install android plugin in eclipse, configure path
# set up .bashrc, conkyrc
# set up flaming windows, desktop cube, window snap hot keys
# install Greasemonkey scripts: ffixer, Google MonkeyR, embedifier, gmail favicon alerts, Open all unread button
