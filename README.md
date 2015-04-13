

SKLTP with Puppet

This is a Vagrant project for developers when setting up a development environment 
for SKLTP (https://code.google.com/p/skltp/).

See: https://github.com/callistaenterprise/cm-tools/wiki/SKLTP

Usage:






Todo:

* Fetch packages from mirrors instead of having them in the git repo.
* Maybe use parameters to the class instead of using params manifest?
* Add webserver.
* Uppdate to VP ver 2.1


MIXED NOTES

wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -Uvh epel-release-6*.rpm

yum repolist
--> Error: Cannot retrieve metalink for repository: epel. Please verify its path and try again

sudo mv /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

sudo vi /etc/yum.repos.d/epel.repo 
--> ta bort s i https...

yum repolist
...
epel                                   Extra Packages for Enterprise Linux 6 - i386                                 9,172
...

sudo yum install fonts





------------------------------
 

diff /vagrant/puppet/modules/soapui/files/soapui-settings.xml soapui-settings.xml 
diff /vagrant/puppet/modules/soapui/files/default-soapui-workspace.xml default-soapui-workspace.xml 

cp /vagrant/puppet/modules/soapui/files/soapui-settings.xml soapui-settings.xml 
cp /vagrant/puppet/modules/soapui/files/default-soapui-workspace.xml default-soapui-workspace.xml 

--------------------

sudo yum install file-libs file-devel pcre pcre-devel

cd /usr/src/
wget http://projects.l3ib.org/fsniper/files/fsniper-1.3.1.tar.gz
tar xzf fsniper-1.3.1.tar.gz
cd fsniper-1.3.1

./configure
make
make install


mkdir ~/.config/fsniper/
vim ~/.config/fsniper/config

Add below content in configuration file, You may need to change it as per your requirements.


watch {
        /home/skltp {
          */* {
                      handler = echo file: %%
          }
        }
}

 # fsniper --daemon


fsniper &
tail -f .config/fsniper/log
