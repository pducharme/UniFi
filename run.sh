#!/bin/bash

if [[ ! -f /usr/lib/unifi/data/keystore ]]; then
    keytool -genkey -keyalg RSA -alias unifi -keystore /usr/lib/unifi/data/keystore -storepass aircontrolenterprise -keypass aircontrolenterprise -validity 1825 -keysize 4096 -dname "cn=unfi"
fi

exec /usr/lib/jvm/java-8-oracle/jre/bin/java -Xmx1024M -jar /usr/lib/unifi/lib/ace.jar start
