# Installation and Operations

ADC is intended to be installed into the APEX workspace schema.

## Prerequisites

ADC depends on these companion utilities:

- `PIT`
- `UTL_TEXT`
- `UTL_APEX`

The install scripts under `ADC/install_scripts` check these prerequisites before installation.

### PIT

ADC uses PIT for logging, messaging, and parts of the runtime infrastructure.

Repository:
[https://github.com/j-sieben/PIT](https://github.com/j-sieben/PIT)

PIT can be installed directly into the workspace schema or into a shared utility schema. If it is installed outside the workspace schema, the required client installation for the workspace schema must also be executed.

### UTL_TEXT

ADC uses `UTL_TEXT` for text generation tasks, including response and export generation.

Repository:
[https://github.com/j-sieben/UTL_TEXT](https://github.com/j-sieben/UTL_TEXT)

As with PIT, `UTL_TEXT` may live in the workspace schema or in a shared utility schema, provided the workspace schema has the required client-side access.

### UTL_APEX

ADC uses `UTL_APEX` for APEX-specific helper functionality.

Repository:
[https://github.com/j-sieben/UTL_APEX](https://github.com/j-sieben/UTL_APEX)

`UTL_APEX` is an APEX-focused utility and is normally installed into the workspace schema directly.

## Main Commands

Run these commands from the `ADC/` directory:

- `./adc.sh install`
- `./adc.sh runtime`
- `./adc.sh sample`
- `./adc.sh ut`
- `./adc.sh uninstall`

Windows equivalents:

- `adc.bat install`
- `adc.bat runtime`
- `adc.bat sample`
- `adc.bat ut`
- `adc.bat uninstall`

## Installation Modes

`install`
Installs core objects, plugin, and ADC administration application.

`runtime`
Installs core objects and plugin, but omits the administration application. Rules can be imported but not generated. This is useful for production environments.

`sample`
Installs the sample application.

`ut`
Installs unit-test objects.

`uninstall`
Removes ADC, including the administration application.

## Rule Deployment

Rules are typically maintained in a development environment and then transported to downstream environments.

ADC supports two deployment styles:

- rule groups can be exported as dedicated SQL scripts
- rule groups can be embedded into the exported APEX application as supporting objects

Which style is preferred depends on the delivery process of the project. ADC supports both, so teams can choose the variant that fits their release model best.

## Optional Installations

### Sample Application

The sample application is intended as a walkthrough and showcase for ADC usage.

### Unit Tests

The `ut` installation path installs the database unit-test objects used for verification work.

## Operational Guidance

- Maintain rules in development first.
- Transport rules through dedicated SQL export files or supporting objects in APEX exports.
- Treat generated API documentation under `Docs/api_doc` as build output.

## Continue Reading

- [[Glossary]]
- [[../20_Users/First Steps on a Page|First Steps on a Page]]
- [[../30_Developers/Getting Started|Getting Started]]

## Product version and provenance

`ADC_BASIC` exposes two static functions, callable from SQL without an instance:

```sql
select adc_basic.get_version(), adc_basic.get_git_commit() from dual;
```

The version is `Major.Minor.CommitCount`. The root `VERSION` file contains
the configured Major/Minor; change only those components there. The final component counts **all** commits
reachable from the installation commit (including merged branches), and never
resets when Major/Minor changes. The full commit hash is resolved once, then used
for both `git show <hash>:VERSION` and `git rev-list --count <hash>`.

The existing `install` and `runtime` commands, including their direct
`install_scripts/adc-*.sh` and `.bat` starters, resolve and validate version data
before connecting to Oracle. Bash implements this on Unix; the Windows starters
use PowerShell, which was already used for password input. Git is required for
checkout installations. No Python or additional database runtime dependency is
required. Run the starters from any working directory; paths may contain spaces.

A checkout must be clean, including staged changes and untracked nonignored files,
and must have complete history. Shallow/partial clones, replacements and grafts
are rejected. Existing ignored local settings are not counted as source changes.
Prepared release data never overrides a Git checkout. A checkout without the root
`VERSION` file at the selected commit fails rather than guessing a version.
The installer prints version and commit and verifies `ADC_BASIC` and its dependent
objects, SQL callability, and exact returned values at the end of core/runtime
installation and after the administration application installation.

### Release directories without Git

The existing rule-group/APEX exports transport application metadata; they do not
package the ADC source repository. To create a complete ADC source release from a
clean checkout, use one of these commands (destination must not exist):

```bash
./ADC/install_scripts/export-release.sh "/path/to/ADC release"
```

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\ADC\install_scripts\version.ps1 -ExportPath "C:\Releases\ADC release"
```

These export the pinned commit with `git archive` and write
`ADC/install_scripts/version.properties` **inside the release directory**, leaving
the checkout untouched. Distribute the entire directory, including root `VERSION`.
Users then run the normal installers, without an extra build step. Prepared data
contains `ADC_VERSION=1.0.<count>` and `ADC_GIT_COMMIT=<full hash>`; it is validated
before SQL use. A plain GitHub source ZIP or `git archive` without this preparation
cannot be installed: it lacks reliable commit-count metadata. Release metadata
records provenance; it is not a cryptographic signature of the distributed files.

### Direct SQL installation and individual bodies

Shell starters are the automatic, provenance-checked entry points. For a direct
SQL*Plus/SQLcl invocation, obtain validated values from `version.sh` (source it and
call `adc_read_version`) or `version.ps1 -OutputPath <temporary-file>`. Pass those
trusted values to SQL; do not pass arbitrary SQL fragments. From the `ADC/`
directory, the argument contracts are:

```text
@install_scripts/install_core.sql "<workspace>" "<version>" "<full-commit>"
@install_scripts/install_runtime.sql "<version>" "<full-commit>"
@install_scripts/install_apex.sql "<workspace>" "<app-id-or-null>" "<version>" "<full-commit>"
```

Nested scripts reuse positional arguments, so product values are captured in
named `ADC_VERSION` and `ADC_GIT_COMMIT` variables before any nested installation.
SQL validates their format before DDL. Substitution is explicitly enabled before
reading the type body. The stored body contains fixed string literals and needs
neither Git nor metadata at runtime.

To reinstall only the `ADC_BASIC` body from source, use the **same validated
version and commit for the complete installed release** and run from `ADC/`:

```sql
@install_scripts/version.sql "<version>" "<full-commit>"
@core/types/adc_basic.tpb
@tools/recompile.sql
@install_scripts/verify_version.sql
```

A plain `ALTER TYPE adc_basic COMPILE BODY` recompiles the already substituted
stored source and needs no substitution variables. `ADC` remains the protected
customer extension type; its source is not overwritten. New function names must
also be checked against customer extensions when upgrading an existing database.
Installer failures return a nonzero exit status; Oracle DDL already executed
cannot be rolled back. No live database is changed by local repository checks.

### Local verification

Run `bash tests/version-installation.sh` from the repository root. The checks use
isolated Git fixtures and a mock SQL*Plus, with PowerShell checks when `pwsh` is
available. They cover merge history, Major/Minor changes, dirty/staged/untracked
sources, shallow and broken histories, worktrees, stale/invalid/missing release
metadata, both exporters, paths with spaces and installer failures. They never
connect to Oracle. Actual Oracle compilation and SQL method invocation are checked
by the installation scripts in an authorized target database. Preserve the CRLF
convention of existing source files when checking whitespace:
`git -c core.whitespace=cr-at-eol diff --check`.
