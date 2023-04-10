#!/bin/bash

# Backup dir
tar czf /tmp/backups/home-$(date +%Y-%m-%d-%H-%M-%S).tar.gz /home
tar czf /tmp/backups/config-$(date +%Y-%m-%d-%H-%M-%S).tar.gz /etc/ssh/sshd_config /etc/xrdp /etc/vsftpd.conf
tar czf /tmp/backups/logs-$(date +%Y-%m-%d-%H-%M-%S).tar.gz /var/log
# Non zip
#tar cpf /tmp/backup "created on `date '+%d-%B-%Y'`.tar" /home /var/log

# Move backup to archive directory
mv /tmp/backups/*.tar.gz /archive/

# Delete old backups (older than 30 days) from archive directory
find /archive/ -name "*.tar.gz" -type f -mtime +30 -delete
