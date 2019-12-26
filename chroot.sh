#!/bin/bash

# change baseurl to /media, because build.sh: mount --bind tmnt target/media.
sed -i -e "s%baseurl.*%baseurl=file:///media%g" /etc/yum.repos.d/local.repo

# rebuild rpm database.
rpm -vv --rebuilddb

# reinstall yum.
yum reinstall -y -q --disablerepo=\* --enablerepo=local yum centos-release
yum install -q -y --disablerepo=\* --enablerepo=local bind-utils bash yum vim-minimal centos-release less iputils iproute systemd rootfiles tar passwd yum-utils yum-plugin-ovl hostname  which 
yum install -q -y --disablerepo=\* --enablerepo=local gcc which tar net-tools grubby gawk passwd perl

# Just want kernel-xx.rpm, so I can compile driver in this environment.
rpm -ivh /media/Packages/kernel-2.6.32-431.el6.x86_64.rpm --nodeps --force
yum install -q -y --disablerepo=\* --enablerepo=local kernel-header
yum install -q -y --disablerepo=\* --enablerepo=local kernel-devel

# clean stuff.
yum clean all
rm -rf /var/cache/yum
rm -rf /boot

rm -rf /var/cache/yum/x86_64
rm -rf /var/lib/yum/history
rm -rf /var/lib/yum/yumdb
rm -f /var/lib/yum/uuid
rm -f /var/log/yum.log

