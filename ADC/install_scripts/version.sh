#!/bin/bash
# Source this file, then call adc_read_version. No generated source files.
adc_read_version() {
  local root commit count base metadata line key value state shallow partial replacements graft
  root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)" || return 1
  metadata="$root/ADC/install_scripts/version.properties"
  if [[ -e "$root/.git" || -L "$root/.git" ]]; then
    command -v git >/dev/null || { echo 'ADC: Git is required for this checkout.' >&2; return 1; }
    state="$(git -C "$root" rev-parse --show-toplevel)" || return 1
    [[ "$state" == "$root" ]] || return 1
    shallow="$(git -C "$root" rev-parse --is-shallow-repository)" || return 1
    [[ "$shallow" == false ]] || {
      echo 'ADC: Incomplete (shallow) Git history. Fetch the complete history first.' >&2; return 1;
    }
    if partial="$(git -C "$root" config --get-regexp '^(extensions\.partialclone|remote\..*\.promisor)$')"; then
      echo 'ADC: Partial clones are not supported; use a complete checkout.' >&2; return 1
    else
      [[ $? == 1 ]] || { echo 'ADC: Cannot inspect Git configuration.' >&2; return 1; }
    fi
    state="$(git -C "$root" status --porcelain=v1 --untracked-files=all --ignore-submodules=none)" || return 1
    if [[ -n "$state" ]]; then
      echo 'ADC: Local changes found. Commit or remove them before installation/export.' >&2; return 1
    fi
    replacements="$(git -C "$root" replace -l)" || return 1
    graft="$(git -C "$root" rev-parse --git-path info/grafts)" || return 1
    [[ "$graft" == /* ]] || graft="$root/$graft"
    if [[ -n "$replacements" || -s "$graft" ]]; then
      echo 'ADC: Git replacements/grafts are not supported.' >&2; return 1
    fi
    commit="$(git -C "$root" rev-parse --verify 'HEAD^{commit}')" || return 1
    # Every history/content query is pinned to the same immutable commit.
    base="$(git -C "$root" show "$commit:VERSION")" || return 1
    base="${base%$'\r'}"
    count="$(git -C "$root" --no-replace-objects rev-list --count "$commit")" || {
      echo 'ADC: Cannot read the complete commit history.' >&2; return 1;
    }
    [[ "$base" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ && "$count" =~ ^[1-9][0-9]*$ ]] || {
      echo 'ADC: Invalid VERSION or commit count.' >&2; return 1;
    }
    git -C "$root" diff --quiet "$commit" -- &&
      git -C "$root" diff --cached --quiet "$commit" -- || {
      echo 'ADC: Checkout changed while resolving version data.' >&2; return 1;
    }
    ADC_VERSION="$base.$count"
    ADC_GIT_COMMIT="$commit"
    # Prepared data never overrides a checkout, even if stale.
  else
    [[ -f "$metadata" ]] || { echo 'ADC: No Git checkout or prepared release version data found.' >&2; return 1; }
    ADC_VERSION= ADC_GIT_COMMIT=
    while IFS= read -r line || [[ -n "$line" ]]; do
      line="${line%$'\r'}"
      key="${line%%=*}"; value="${line#*=}"
      case "$key" in
        ADC_VERSION) [[ -z "$ADC_VERSION" ]] || return 1; ADC_VERSION="$value" ;;
        ADC_GIT_COMMIT) [[ -z "$ADC_GIT_COMMIT" ]] || return 1; ADC_GIT_COMMIT="$value" ;;
        *) echo 'ADC: Invalid release version data.' >&2; return 1 ;;
      esac
    done < "$metadata"
    base="$(cat "$root/VERSION")" || return 1
    base="${base%$'\r'}"
    [[ "$base" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ && "$ADC_VERSION" == "$base."* ]] || { echo 'ADC: Release data does not match VERSION.' >&2; return 1; }
  fi
  [[ "$ADC_VERSION" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.[1-9][0-9]*$ &&
     "$ADC_GIT_COMMIT" =~ ^([0-9a-f]{40}|[0-9a-f]{64})$ ]] || {
    echo 'ADC: Invalid product version or full Git commit hash.' >&2; return 1;
  }
  export ADC_VERSION ADC_GIT_COMMIT
  echo "ADC version $ADC_VERSION, Git commit $ADC_GIT_COMMIT"
}
