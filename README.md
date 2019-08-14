# LDAP_Playground - a docker image for setting up a LDAP server quickly

A docker image that automatically installs the essentials for an LDAP server and prompts all the necessary steps for getting it up and running. In your CI all you have to do is docker build and docker push the image. 

After getting into the running docker image, start the set up process and the server itself: `chmod +x install.sh && ./install.sh`

## Commands for manipulating the server
Note: most of these have already been done in install.sh  

Adding a new user using config listed in user.ldif: `ldapadd -H ldap://localhost:389 -x -W -D "cn=admin,dc=example,dc=com" -f user.ldif`  
Searching for a user: `ldapsearch -H ldap://localhost:1389 -LLL -x -D cn=root -w secret -b "ou=users, o=myhost" cn=ldapjs`  
Deleting a user: `ldapdelete -H ldap://localhost:1389 -x -D cn=root -w secret "cn=ldapjs, ou=users, o=myhost"`  

On server start:  
`apt-get install slapd`  
`echo exit 0 > /usr/sbin/policy-rc.d`  
`dpkg-reconfigure slapd`  

Confirm server was successfully started: `ldapsearch -h localhost -p 389 -b "dc=example,dc=com" "cn=admin" -D "cn=admin,dc=example,dc=com" -W`  

Add schemas to allow the server to run correctly
`vim /etc/ldap/ldap.conf`  
Insert these lines into the file  
`include /etc/ldap/schema/cosine.schema`  
`include /etc/ldap/schema/nis.schema`  
Restart the server  
`service slapd restart`  

Show all users: `ldapsearch -h localhost -p 389 -b "dc=example,dc=com" -D "cn=admin,dc=example,dc=com" -W`  
Delete: `ldapmodify -x -D "cn=admin,dc=example,dc=com" -w secret -H ldap://localhost:389 -f deleteObject.ldif`  
Add: `ldapadd -H ldap://localhost:389 -x -W -D "cn=admin,dc=example,dc=com" -f combined.ldif`  
Set Password for a specific user: `ldappasswd -H ldap://localhost:389 -x -D "cn=admin,dc=example,dc=com" -W -S "uid=one, cn=users, dc=example, dc=com"`  
Check credentials: `ldapwhoami -vvv -h localhost -p 389 -D "uid=one, cn=users, dc=example, dc=com" -x -w deepmets2019`  

The LDAP server will be hosted at localhost:389