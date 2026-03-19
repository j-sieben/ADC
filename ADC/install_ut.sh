#!/bin/bash
set -euo pipefail

echo -n "Enter APEX workspace schema for ADC [ENTER] "
read OWNER

echo -n "Enter password for ${OWNER} [ENTER] "
read -s OWNER_PWD
echo

echo -n "Enter service name for the database or PDB [ENTER] "
read SERVICE

NLS_LANG=GERMAN_GERMANY.AL32UTF8
export NLS_LANG

sqlplus ${OWNER}/${OWNER_PWD}@${SERVICE} @install_scripts/install_ut.sql
