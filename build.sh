iso=$1
RPWD=$(pwd)

# temp mount directory
mkdir -p tmnt               

# chroot target directory.
mkdir -p target
mkdir -p target/media

# mount iso file to temp mount dir.
mount -o loop ${iso} tmnt/

# make temp mount dir visible in chroot env.
mount --bind tmnt target/media

# install centos-release.
rpm --nodeps --root ${RPWD}/target -i tmnt/Packages/centos-release-6-5.el6.centos.11.1.x86_64.rpm

# set local.repo to temp mount dir.
sed -i -e "s%baseurl.*%baseurl=file://$(pwd)/tmnt%g" local.repo
cp -f local.repo target/etc/yum.repos.d/

# install yum from local repo.
# NOTICE: even used --installroot, the baseurl in local.repo should be temp mount dir path.
yum -q -y --installroot=${RPWD}/target --disablerepo=\* --enablerepo=local install yum

# run chroot.sh in target env.
cp chroot.sh target/
chroot target ./chroot.sh
rm -f target/chroot.sh

umount target/media
umount tmnt

# create tar file.
# or you can run below cmd to create docker image. 
# $ tar -C ${RPWD}/target -c . | docker import - centos
tar -C ${RPWD}/target -cf ./layer.tgz .

