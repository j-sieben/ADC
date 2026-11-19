#!/bin/bash
# Isolated Git fixtures and a mock SQL*Plus; never connects to a database.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/adc-version-test.XXXXXX")"
trap 'rm -rf "$TEMP_ROOT"' EXIT
REPO="$TEMP_ROOT/source checkout"
mkdir -p "$REPO/ADC/install_scripts" "$TEMP_ROOT/bin"
printf '1.0\n' > "$REPO/VERSION"
cp "$ROOT/ADC/install_scripts/"{version.sh,version.ps1,export-release.sh,adc-install.sh,adc-runtime.sh} "$REPO/ADC/install_scripts/"
git -C "$REPO" init -q
git -C "$REPO" config user.name 'ADC Test'
git -C "$REPO" config user.email 'adc-test@example.invalid'
git -C "$REPO" add .
git -C "$REPO" commit -qm initial
BRANCH="$(git -C "$REPO" symbolic-ref --short HEAD)"
# Create merged, non-linear history: all four commits must count.
git -C "$REPO" checkout -qb feature
printf feature > "$REPO/feature"
git -C "$REPO" add .; git -C "$REPO" commit -qm feature
git -C "$REPO" checkout -q "$BRANCH"
printf main > "$REPO/main"
git -C "$REPO" add .; git -C "$REPO" commit -qm main
git -C "$REPO" merge -q --no-ff feature -m merge
COMMIT="$(git -C "$REPO" rev-parse HEAD)"
read_version() { (cd /; source "$1/ADC/install_scripts/version.sh"; adc_read_version); }
expect_failure() {
  if "$@" > "$TEMP_ROOT/failure.log" 2>&1; then echo "Expected failure: $*" >&2; exit 1; fi
}
read_version "$REPO" | tee "$TEMP_ROOT/result"
rg -q "ADC version 1.0.4, Git commit $COMMIT" "$TEMP_ROOT/result"
if command -v pwsh >/dev/null; then
  pwsh -NoProfile -File "$REPO/ADC/install_scripts/version.ps1" -OutputPath "$TEMP_ROOT/windows.properties"
  rg -q '^ADC_VERSION=1.0.4$' "$TEMP_ROOT/windows.properties"
  rg -q "^ADC_GIT_COMMIT=$COMMIT$" "$TEMP_ROOT/windows.properties"
fi
printf dirty >> "$REPO/main"
expect_failure read_version "$REPO"
if command -v pwsh >/dev/null; then expect_failure pwsh -NoProfile -File "$REPO/ADC/install_scripts/version.ps1"; fi
git -C "$REPO" checkout -- main
printf untracked > "$REPO/untracked"
expect_failure read_version "$REPO"
rm "$REPO/untracked"
printf staged >> "$REPO/main"; git -C "$REPO" add main
expect_failure read_version "$REPO"
git -C "$REPO" reset -q --hard HEAD
# New Major/Minor does not reset the commit count.
printf '2.3\n' > "$REPO/VERSION"
git -C "$REPO" add VERSION; git -C "$REPO" commit -qm version
COMMIT="$(git -C "$REPO" rev-parse HEAD)"
read_version "$REPO" | rg -q 'ADC version 2.3.5,'
# A tracked stale prepared file must never override Git data.
printf 'ADC_VERSION=9.9.99\nADC_GIT_COMMIT=%040d\n' 0 > "$REPO/ADC/install_scripts/version.properties"
git -C "$REPO" add .; git -C "$REPO" commit -qm stale
COMMIT="$(git -C "$REPO" rev-parse HEAD)"
read_version "$REPO" | rg -q "ADC version 2.3.6, Git commit $COMMIT"
if command -v pwsh >/dev/null; then
  pwsh -NoProfile -File "$REPO/ADC/install_scripts/version.ps1" -OutputPath "$TEMP_ROOT/windows.properties"
  rg -q '^ADC_VERSION=2.3.6$' "$TEMP_ROOT/windows.properties"
fi
# Both exporters pin content and metadata without modifying the checkout.
RELEASE="$TEMP_ROOT/release directory"
bash "$REPO/ADC/install_scripts/export-release.sh" "$RELEASE"
read_version "$RELEASE" | rg -q "ADC version 2.3.6, Git commit $COMMIT"
[[ -z "$(git -C "$REPO" status --porcelain)" ]]
if command -v pwsh >/dev/null; then
  PS_RELEASE="$TEMP_ROOT/PowerShell release"
  pwsh -NoProfile -File "$REPO/ADC/install_scripts/version.ps1" -ExportPath "$PS_RELEASE"
  read_version "$PS_RELEASE" | rg -q 'ADC version 2.3.6,'
  pwsh -NoProfile -File "$RELEASE/ADC/install_scripts/version.ps1" -OutputPath "$TEMP_ROOT/windows.properties"
fi
# Invalid metadata, duplicate keys, missing data and incomplete histories fail.
printf 'ADC_VERSION=2.3.6\nADC_GIT_COMMIT=not-a-hash\n' > "$RELEASE/ADC/install_scripts/version.properties"
expect_failure read_version "$RELEASE"
if command -v pwsh >/dev/null; then expect_failure pwsh -NoProfile -File "$RELEASE/ADC/install_scripts/version.ps1"; fi
printf 'ADC_VERSION=2.3.6\nADC_VERSION=2.3.6\nADC_GIT_COMMIT=%s\n' "$COMMIT" > "$RELEASE/ADC/install_scripts/version.properties"
expect_failure read_version "$RELEASE"
rm "$RELEASE/ADC/install_scripts/version.properties"
expect_failure read_version "$RELEASE"
git clone -q --depth 1 "file://$REPO" "$TEMP_ROOT/shallow"
expect_failure read_version "$TEMP_ROOT/shallow"
if command -v pwsh >/dev/null; then expect_failure pwsh -NoProfile -File "$TEMP_ROOT/shallow/ADC/install_scripts/version.ps1"; fi
git -C "$REPO" config remote.origin.promisor true
expect_failure read_version "$REPO"
git -C "$REPO" config --unset remote.origin.promisor
# Broken non-shallow history must fail too.
BROKEN="$TEMP_ROOT/broken history"
cp -R "$REPO" "$BROKEN"
FIRST="$(git -C "$REPO" rev-list --max-parents=0 "$COMMIT")"
rm "$BROKEN/.git/objects/${FIRST:0:2}/${FIRST:2}"
expect_failure read_version "$BROKEN"
if command -v pwsh >/dev/null; then expect_failure pwsh -NoProfile -File "$BROKEN/ADC/install_scripts/version.ps1"; fi
# Reject history replacements instead of counting substituted objects.
PARENT="$(git -C "$REPO" rev-parse "$COMMIT^")"
git -C "$REPO" replace "$COMMIT" "$PARENT"
expect_failure read_version "$REPO"
if command -v pwsh >/dev/null; then expect_failure pwsh -NoProfile -File "$REPO/ADC/install_scripts/version.ps1"; fi
git -C "$REPO" replace -d "$COMMIT" >/dev/null
# A worktree has a .git file, not a directory.
git -C "$REPO" worktree add -q --detach "$TEMP_ROOT/worktree" HEAD
read_version "$TEMP_ROOT/worktree" | rg -q 'ADC version 2.3.6,'
# Mock SQL*Plus records argv; verify automatic forwarding and fail-fast behavior.
cat > "$TEMP_ROOT/bin/sqlplus" <<'SQLPLUS'
#!/bin/bash
printf '%s\n' "$@" >> "$ADC_TEST_LOG"
exit "${ADC_TEST_EXIT:-0}"
SQLPLUS
chmod +x "$TEMP_ROOT/bin/sqlplus"
export PATH="$TEMP_ROOT/bin:$PATH" ADC_TEST_LOG="$TEMP_ROOT/sqlplus.log"
printf 'schema\npassword\nservice\nworkspace with spaces\n123\n' | bash "$REPO/ADC/install_scripts/adc-install.sh" >/dev/null
[[ "$(rg -c "^$COMMIT$" "$ADC_TEST_LOG")" == 2 ]]
rg -q '^workspace with spaces$' "$ADC_TEST_LOG"
printf 'schema\npassword\nservice\n' | bash "$REPO/ADC/install_scripts/adc-runtime.sh" >/dev/null
[[ "$(rg -c "^$COMMIT$" "$ADC_TEST_LOG")" == 3 ]]
: > "$ADC_TEST_LOG"
export ADC_TEST_EXIT=7
expect_failure bash "$REPO/ADC/install_scripts/adc-install.sh" <<<'schema
password
service
workspace
123'
[[ "$(rg -c "^$COMMIT$" "$ADC_TEST_LOG")" == 1 ]]
unset ADC_TEST_EXIT
: > "$ADC_TEST_LOG"
printf dirty >> "$REPO/main"
expect_failure bash "$REPO/ADC/install_scripts/adc-runtime.sh"
[[ ! -s "$ADC_TEST_LOG" ]]
# Nested SQL arguments must be captured before version.sql resets &1/&2.
rg -q 'define ADC_INSTALL_WORKSPACE = "&1\."' "$ROOT/ADC/install_scripts/install_apex.sql"
rg -q 'init_apex.sql "&ADC_INSTALL_WORKSPACE\." "&ADC_INSTALL_APP_ID\." ADCA' "$ROOT/ADC/install_scripts/install_apex.sql"
echo 'PASS: Bash/PowerShell provenance, release exports, merge counts, version changes, worktrees and installer argument/error handling.'
