#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage: ./adc.sh <command>

Commands:
  install     Install core, plugin and ADC admin app
  runtime     Install core and plugin without the admin app
  sample      Install the sample application
  ut          Install unit tests
  uninstall   Uninstall ADC including the admin app
  help        Show this help
EOF
}

COMMAND="${1:-help}"

case "${COMMAND}" in
  install)
    exec "${SCRIPT_DIR}/install_scripts/adc-install.sh"
    ;;
  runtime)
    exec "${SCRIPT_DIR}/install_scripts/adc-runtime.sh"
    ;;
  sample)
    exec "${SCRIPT_DIR}/install_scripts/adc-sample.sh"
    ;;
  ut)
    exec "${SCRIPT_DIR}/install_scripts/adc-ut.sh"
    ;;
  uninstall)
    exec "${SCRIPT_DIR}/install_scripts/adc-uninstall.sh"
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    echo "Unknown command: ${COMMAND}" >&2
    usage >&2
    exit 1
    ;;
esac
