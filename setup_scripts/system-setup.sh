set -e

echo "setting up additional sources"
sudo apt-get install -y curl

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

echo "we'll update what we've got:"
echo "----------------------------------"
sudo apt-get -y update && sudo apt-get upgrade
sudo apt-get dist-upgrade

echo "setting up editors/ides/build tools:"
echo "----------------------------------"
sudo apt-get install -y vim eclipse git heroku \
zlib1g-dev coreutils libtool bison libxt-dev \
sqlite3 libsqlite3-dev libxml2-dev libreadline-dev \
libmagickwand-dev libmemcached-dbg \
postgresql postgresql-client postgresql-contrib libpq-dev libxslt1-dev \
libqt4-dev libqtwebkit-dev libsasl2-dev libcurl4-gnutls-dev \
memcached build-essential imagemagick redis-server \
apt-transport-https ca-certificates software-properties-common docker-ce \
virtualbox virtualbox-dkms linux-headers-generic vagrant yarn

curl -L https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine
sudo usermod -aG docker ${USER}

# update the end of /etc/postgresql/9.1/main/pg_hba.conf to look like this:
# # TYPE  DATABASE    USER        CIDR-ADDRESS          METHOD
# # "local" is for Unix domain socket connections only
# local   all         all                               trust
# # IPv4 local connections:
# host    all         all         127.0.0.1/32          trust
# # IPv6 local connections:
# host    all         all         ::1/128               trust
# then run `sudo /etc/init.d/postgresql restart`

sudo -u postgres createuser --superuser ${USER}

echo "installing tools, media players, etc."
echo "----------------------------------"
sudo apt-get install -y kupfer gimp chromium-browser \
comix xsane dropbox nemo-dropbox soundconverter \
wmctrl iotop unrar tree redshift-gtk jq vlc banshee \
libgtop2-dev libgtop-2.0-10 libgtop2-common steam libnotify-bin

echo "setting up NVM"
echo "----------------------------------"
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

echo "setting up RVM"
echo "----------------------------------"
sudo apt-get install -y rvm
. /etc/profile.d/rvm.sh
rvm rvmrc warning ignore allGemfiles
echo "RVM installed"
echo "you may need to log out and back in to install rubies"

echo "Followup checklist"
echo "----------------------------------"
echo "- run followup installation script when dotfiles are synced"
echo "- rvm install ruby versions in relevant projects"
echo "- nvm install node versions in relevant projects"
echo "- yarn && bundle in relevant projects"
