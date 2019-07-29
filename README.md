# LDAP_Playground
A simple LDAP server created by following the guide on ldapjs, except debugged to fit updated version

## Commands
To Start Server: `node server.js`
Adding a new user using config listed in user.ldif: `ldapadd -H ldap://localhost:1389 -x -D cn=root -w secret -f ./user.ldif`
Searching for a user: `ldapsearch -H ldap://localhost:1389 -LLL -x -D cn=root -w secret -b "ou=users, o=myhost" cn=ldapjs`
Deleting a user: `ldapdelete -H ldap://localhost:1389 -x -D cn=root -w secret "cn=ldapjs, ou=users, o=myhost"`