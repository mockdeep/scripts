sudo yum install \
# gem requirements
libxml2-devel xslt-devel libcurl-devel cyrus-sasl-devel sqlite-devel ImageMagick-devel mysql-devel mysql-server \
# etc
deluge libreoffice-core libreoffice-writer libreoffice-calc
# figure out memcached to install
sudo /etc/init.d/mysqld start
sudo /etc/init.d/memcached start
# install rvm
# install rubies
# rvm install 1.8.7
# rvm install 1.9.2 # current?
# rvm gemset create edge
# rvm use 1.9.2@edge
# gem install rails
# rvm use 1.8.7
# rvm gemset create work
# rvm use 1.8.7@work
# create gemsets work/edge
# cd $WORKDIR
# rake gems:install
# add gems to gemsets
# figure out rvm lines
# gem install mongrel
