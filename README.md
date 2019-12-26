
# centos docker build.

This helps you build CentOS docker image from ISO files like CentOS-6.5-x86_64-bin-DVD1.iso.

The idea is from [base-image-docker](https://github.com/GoogleContainerTools/base-images-docker).

# How to use

1. Download iso file from [centos vault](http://vault.centos.org/)
2. Run script build.sh. `sudo sh ./build.sh CentOS-6.5-x86_64-bin-DVD1.iso`.
3. If step 2 is success, then you get `layer.tgz` file.
4. Create docker image. `sudo cat layer.tgz | docker import - centos6.5`.
5. Run docker:`sudo docker run --rm -ti centos6.5 /bin/bash`.  

The `build.sh` create `tmnt` and `target` directory. 

`tmnt` is used for temp mount. `target` is an chroot filesystem. After success, You can delete both.
You also can play `target` with `chroot` command, like `chroot target /bin/bash`.

# DIY

Change `chroot.sh` script, to choose RPM packages which you need.


