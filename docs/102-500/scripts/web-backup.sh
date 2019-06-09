#!/bin/bash

DATE=$(date "+%d")

/bin/tar -czf /root/site-backup-$DATE.tar.gz /var/www/html
