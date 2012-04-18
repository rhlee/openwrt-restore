#!/bin/sh

finally()
{
  echo $@ 1>&2
  logger $@
  if [ $1 -eq 0 ]; then
    sync && reboot
    exit 0
  else
    exit $1
  fi
}

cd /backup || finally 1 No backup directory
backup=`ls -Art *.tar.gz | tail -n 1`
if [ -z $backup ]; then finally 1 No backup files; fi
tar -C / -vxzf $backup
chmod -R 0755 /etc
chown -R root:root /etc
finally 0 Restored $PWD/$backup