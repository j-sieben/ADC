# Repository Map

This page gives developers a fast orientation across the repository.

## Main Areas

- `ADC/core`
  Core database objects: tables, views, sequences, packages, types, messages, and version-specific install fragments.
- `ADC/plugin`
  Dynamic Action plugin package and static browser assets.
- `ADC/apex`
  APEX administration and designer application objects.
- `ADC/sample_app`
  Sample application and helper packages.
- `ADC/unit_test`
  Database unit-test objects.
- `ADC/install_scripts`
  `SQL*Plus`-driven orchestration scripts for installation and uninstall.
- `ADC/tools`
  Helper scripts used by the installation flow.
- `Docs/obsidian`
  Handwritten project documentation vault.
- `Docs/api_doc`
  Generated Natural Docs API reference.

## Most Useful Starting Files

- `ADC/plugin/packages/adc_plugin.pks`
- `ADC/plugin/packages/adc_plugin.pkb`
- `ADC/core/packages/adc_internal.pkb`
- `ADC/core/packages/adc_api.pks`
- `ADC/core/packages/adc_admin.pks`
- `ADC/core/packages/adc_page_state.pkb`
- `ADC/adc.sh`

## Continue Reading

- [[Getting Started]]
- [[Database/Home|Database Development]]
- [[JavaScript/Home|JavaScript Development]]
- [[../40_Architecture/System Overview|System Overview]]
