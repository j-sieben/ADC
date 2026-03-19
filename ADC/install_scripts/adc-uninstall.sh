#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

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

export NLS_LANG=GERMAN_GERMANY.AL32UTF8

cd "${PROJECT_DIR}"
sqlplus "${OWNER}/${OWNER_PWD}@${SERVICE}" @install_scripts/uninstall_apex.sql "${WORKSPACE}" "${APP_ID}"
