#!/bin/bash
echo -n "Enter APEX workspace schema for ADC [ENTER] "
read OWNER


read -s -p "Enter password for ${OWNER} [ENTER] " OWNER_PWD
echo 

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE

echo -n "Enter name of APEX workspace [ENTER] "
read WORKSPACE

echo -n "Optionally enter a new admin application ID [ENTER] "
read APP_ID

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

sqlplus ${OWNER}/${OWNER_PWD}@${SERVICE} @install_scripts/install_core.sql ${WORKSPACE}

sqlplus ${OWNER}/${OWNER_PWD}@${SERVICE} @install_scripts/install_apex.sql ${WORKSPACE} ${APP_ID}
