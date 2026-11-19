#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$SCRIPT_DIR/version.sh"
[[ $# == 1 && ! -e "$1" ]] || { echo 'Usage: export-release.sh <new destination directory>' >&2; exit 1; }
[[ -e "$ROOT/.git" ]] || { echo 'ADC: Release export requires a complete Git checkout.' >&2; exit 1; }
adc_read_version
ARCHIVE="$(mktemp "${TMPDIR:-/tmp}/adc-release.XXXXXX")"
trap 'rm -f "$ARCHIVE"' EXIT
git -C "$ROOT" archive --format=tar --output="$ARCHIVE" "$ADC_GIT_COMMIT"
mkdir -p "$1"
tar -xf "$ARCHIVE" -C "$1"
printf 'ADC_VERSION=%s\nADC_GIT_COMMIT=%s\n' "$ADC_VERSION" "$ADC_GIT_COMMIT" > "$1/ADC/install_scripts/version.properties"
