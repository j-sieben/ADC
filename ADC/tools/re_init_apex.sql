set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
set termout on

define script_dir=apex/scripts/

set define on

alter session set current_schema=&INSTALL_USER.;

set termout on