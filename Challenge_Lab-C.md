### Archive /var/log/*.log in ~/archive/log.tar:
mkdir ~/archive
tar -vcf $_/log.tar --xform='s,/\?.*/,,' /var/log/*.log

### List the contents of the tar archive:
tar -vf ~/archive/log.tar --list

### Spread the contents of the archive into ~/backup:
mkdir ~/backup && cd $_
tar -vxf ~/archive/log.tar
