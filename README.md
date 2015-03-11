debian-packages
===============
Custom debian packages

Installing the packages
-----------------------

Install signing key:
```
wget -O - http://debian-packages.cargomedia.ch/conf/signing.key | apt-key add -
```

Add to your `sources.list`:
```
deb http://debian-packages.cargomedia.ch wheezy main
```

Available packages
------------------

#### gearmand
- Version: 1.1.13 (unstable)
- Packages: libgearman7, libgearman-dev, libgearman7-dbg, libgearman-doc, gearman-job-server, gearman-tools, gearman
- Debianization via: https://github.com/ssm/pkg-gearmand/

#### arcconf
- Version: 1.5.20942
- Packages: arcconf
- Debianization via: https://github.com/eLvErDe/hwraid/pull/4

#### mysql-proxy
- Version: 0.8.5
- Packages: mysql-proxy
- Debianization via: https://packages.debian.org/wheezy/mysql-proxy

Development
-----------

For signing the repo, the vagrant-provisioner will look for keys in `keys/{private,public},key`.
Alternatively you might want to create new keys:

#### Creating a signing key
Create key:
```
gpg --gen-key
```

Export private and public key:
```
mkdir -p /vagrant/keys/
gpg --export -a 'Cargo Media' > /vagrant/keys/public.key
gpg --export-secret-key -a 'Cargo Media' > /vagrant/keys/private.key
```
