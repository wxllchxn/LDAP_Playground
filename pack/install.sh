#!/bin/sh
apt-get install slapd
echo exit 0 > /usr/sbin/policy-rc.d
dpkg-reconfigure slapd
vim /etc/ldap/ldap.conf
service slapd restart
ldapadd -H ldap://localhost:389 -x -W -D "cn=admin,dc=example,dc=com" -f combined.ldif
ldappasswd -H ldap://localhost:389 -x -D "cn=admin,dc=example,dc=com" -W -S "uid=one, cn=users, dc=example, dc=com"
ldappasswd -H ldap://localhost:389 -x -D "cn=admin,dc=example,dc=com" -W -S "uid=two, cn=users, dc=example, dc=com"