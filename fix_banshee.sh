# a fix for banshee crashing after a song ends
# apparently the database gets corrupted occasionally

set -e
cd ~/.config/banshee-1
sqlite3 banshee.db ".dump" > dump
mv banshee.db banshee.db.backup
cat dump | sqlite3 banshee.db
