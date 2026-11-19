-- Call only with validated installer data, or trusted literal values.
set define on
set scan on
set verify off
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
define ADC_VERSION = "&1."
define ADC_GIT_COMMIT = "&2."

declare
begin
  if '&ADC_VERSION.' is null or '&ADC_GIT_COMMIT.' is null
     or not regexp_like('&ADC_VERSION.', '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.[1-9][0-9]*$', 'c')
     or not regexp_like('&ADC_GIT_COMMIT.', '^([0-9a-f]{40}|[0-9a-f]{64})$', 'c') then
    raise_application_error(-20000, 'ADC: Invalid product version or full Git commit hash.');
  end if;
end;
/
prompt ADC version &ADC_VERSION., Git commit &ADC_GIT_COMMIT.
