#! /bin/bash
# Copyright 2019 Kuei-chun Chen. All rights reserved.
: ${ADMIN_PASSWORD:=admin}

# Enable TLS
echo "TLS_REQCERT never" >> /etc/openldap/ldap.conf
echo "TLS_CACERT /server.pem" >> /etc/openldap/ldap.conf
echo "127.0.0.1	localhost" > /etc/hosts
echo "$(ping -c 1 kerberos|head -1|cut -d'(' -f2|cut -d')' -f1)  kerberos.simagix.com kerberos" >> /etc/hosts
echo "$(ping -c 1 ldap|head -1|cut -d'(' -f2|cut -d')' -f1)  ldap.simagix.com ldap" >> /etc/hosts

# Start slapd
/usr/sbin/slapd -u ldap -h "ldapi:/// ldaps://ldap.simagix.com"
LDAP_LOG=/tmp/ldap.log

olcRootPW=$(slappasswd -h {SSHA} -s $ADMIN_PASSWORD)
cp /db.ldif /hdb.ldif
echo "olcRootPW: ${olcRootPW}" >> /hdb.ldif
ldapmodify -Y EXTERNAL -H ldapi:/// -f /hdb.ldif
ldapmodify -Y EXTERNAL -H ldapi:/// -f /monitor.ldif

# Set up LDAP database
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap:ldap /var/lib/ldap/*
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

# enable memberOf
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /memberof_config.ldif
ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /refint.ldif

# Add users and group
ldapadd -x -w $ADMIN_PASSWORD -D "cn=ldapadm,dc=simagix,dc=local" -H ldapi:/// -f /base.ldif
ldapadd -x -w $ADMIN_PASSWORD -D "cn=ldapadm,dc=simagix,dc=local" -H ldapi:/// -f /users.ldif

# validate configurations
echo "# ldapsearch -x -LLL -H ldapi:/// -b cn=admin,ou=users,dc=simagix,dc=local"
ldapsearch -x -LLL -H ldapi:/// -b cn=admin,ou=users,dc=simagix,dc=local
echo "# ldapsearch -x -LLL -H ldapi:/// -b cn=admin,ou=users,dc=simagix,dc=local memberOf"
ldapsearch -x -LLL -H ldapi:/// -b cn=admin,ou=users,dc=simagix,dc=local memberOf

touch $LDAP_LOG
tail -F $LDAP_LOG
