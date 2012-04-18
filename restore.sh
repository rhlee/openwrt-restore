#!/bin/sh

exit_and_log()
{
  echo $@ 1>&2
  logger $@
  exit $1
}

cd /backup || exit_and_log 1 No backup directory
backup=`ls -Art *.tar.gz | tail -n 1`
if [ -z $backup ]; then exit_and_log 1 No backup files; fi
tar -C / -vxzf $backup
chmod -R 0755 /etc
chown -R root:root /etc

exit_and_log 0 Restored $PWD/$backup
sync && reboot