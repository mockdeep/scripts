set -e
echo "first we'll update what we've got:"
echo "----------------------------------"
sudo add-apt-repository ppa:conky-companions/ppa
sudo apt-get -y update && sudo apt-get upgrade
sudo apt-get dist-upgrade
echo "setting up editors/ides/build tools:"
echo "----------------------------------"
sudo apt-get install -y vim eclipse git \
curl mysql-server-5.0 zlib1g-dev coreutils libtool bison libxt-dev \
sqlite3 libsqlite3-dev libxml2-dev \
libmagickwand-dev libmysqlclient-dev libmemcached-dbg \
postgresql postgresql-client libpq-dev
sudo -u postgres createuser elements

# update the end of /etc/postgresql/9.1/main/pg_hba.conf to look like this:
# # TYPE  DATABASE    USER        CIDR-ADDRESS          METHOD
# # "local" is for Unix domain socket connections only
# local   all         all                               trust
# # IPv4 local connections:
# host    all         all         127.0.0.1/32          trust
# # IPv6 local connections:
# host    all         all         ::1/128               trust
# then run `sudo /etc/init.d/postgresql restart`

echo "setting up media players:"
echo "----------------------------------"
sudo apt-get install -y vlc adobe-flashplugin \
gstreamer0.10-ffmpeg gstreamer0.10-fluendo-mp3 gstreamer0.10-plugins-ugly \
gstreamer0.10-plugins-bad
echo "installing tools, etc."
echo "----------------------------------"
sudo apt-get install -y gnome-do gimp conky chromium-browser \
comix xsane \
wmctrl iotop unrar conkygooglecalendar conkyrhythmbox tree
