set -e
echo "first we'll update what we've got:"
echo "----------------------------------"
sudo add-apt-repository ppa:conky-companions/ppa
sudo apt-get -y update && sudo apt-get upgrade
sudo apt-get dist-upgrade
echo "setting up editors/ides/build tools:"
echo "----------------------------------"
sudo apt-get install -y vim eclipse git
#curl mysql-server-5.0 zlib1g-dev coreutils libtool bison libxt-dev \
#sqlite3 libsqlite3-dev libxml2-dev \
#libmagickwand-dev libmysqlclient-dev libmemcached-dbg
echo "setting up media players:"
echo "----------------------------------"
sudo apt-get install -y vlc flashplugin-nonfree \
gstreamer0.10-ffmpeg gstreamer0.10-fluendo-mp3 gstreamer0.10-plugins-ugly \
gstreamer0.10-plugins-bad gstreamer0.10-plugins-ugly-multiverse
echo "installing tools, etc."
echo "----------------------------------"
sudo apt-get install -y gnome-do gimp conky chromium-browser \
compizconfig-settings-manager compiz-fusion-plugins-extra comix xsane \
wmctrl iotop unrar conkygooglecalendar conkyrhythmbox tree
