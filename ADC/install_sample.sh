#!/bin/bash
set -euo pipefail

echo -n "Enter APEX workspace schema for ADC [ENTER] "
read OWNER

echo -n "Enter password for ${OWNER} [ENTER] "
read -s OWNER_PWD
echo

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE

echo -n "Enter name of APEX workspace [ENTER] "
read WORKSPACE

echo -n "Optionally enter a new sample application ID [ENTER] "
read APP_ID

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

sqlplus ${OWNER}/${OWNER_PWD}@${SERVICE} @install_scripts/install_sample.sql ${WORKSPACE} ${APP_ID}
