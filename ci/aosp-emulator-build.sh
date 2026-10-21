#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# AOSP emulator (Cuttlefish) build script — prepared for T1.3, NOT yet executed.
# See docs/testing/emulator-first-boot-prep.md for the verified sources of every step.
# Usage:
#   ci/aosp-emulator-build.sh            # check host readiness only (default, safe)
#   ci/aosp-emulator-build.sh sync       # repo init + sync into $AOSP_DIR
#   ci/aosp-emulator-build.sh build      # lunch + m
#   ci/aosp-emulator-build.sh all        # sync + build
#
# Environment:
#   AOSP_DIR   working directory for the tree (default: ~/aosp)
#   AOSP_TAG   manifest branch or tag  (default: android-17.0.0_r1;
#              use android-latest-release for "newest release", see prep doc §1)
set -euo pipefail

AOSP_DIR="${AOSP_DIR:-$HOME/aosp}"
AOSP_TAG="${AOSP_TAG:-android-17.0.0_r1}"
MANIFEST_URL="https://android.googlesource.com/platform/manifest"
LUNCH_TARGET="${LUNCH_TARGET:-aosp_cf_x86_64_only_phone-aosp_current-userdebug}"
# AOSP-documented minimums (docs/setup/start/requirements, 2026-10-21):
MIN_RAM_GB=64
MIN_DISK_GB=400

log() { printf '%s\n' "$*"; }
die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

check_host() {
  local ok=0
  log "== Host readiness check (read-only) =="
  log "CPU arch:      $(uname -m)"
  [ "$(uname -m)" = "x86_64" ] || { log "FAIL: AOSP requires x86_64"; ok=1; }
  log "Cores:         $(nproc)"
  local ram_gb disk_gb
  ram_gb=$(free -g | awk '/^Mem:/{print $2}')
  log "RAM GB:        ${ram_gb}  (minimum ${MIN_RAM_GB})"
  [ "${ram_gb}" -ge "${MIN_RAM_GB}" ] || { log "FAIL: below AOSP minimum RAM"; ok=1; }
  disk_gb=$(df -BG --output=avail "$AOSP_DIR" 2>/dev/null | tail -1 | tr -dc '0-9' || true)
  [ -n "${disk_gb}" ] || disk_gb=0
  if [ "${disk_gb}" -eq 0 ] && [ ! -e "$AOSP_DIR" ]; then
    # AOSP_DIR does not exist yet; measure the nearest existing ancestor instead.
    local probe="${AOSP_DIR}"
    while [ ! -e "${probe}" ] && [ "${probe}" != "/" ]; do probe=$(dirname "${probe}"); done
    disk_gb=$(df -BG --output=avail "${probe}" 2>/dev/null | tail -1 | tr -dc '0-9' || true)
  fi
  log "Free GB:       ${disk_gb} at ${AOSP_DIR}  (minimum ${MIN_DISK_GB})"
  [ "${disk_gb}" -ge "${MIN_DISK_GB}" ] || { log "FAIL: below AOSP minimum free disk"; ok=1; }
  log "Distro:        $(. /etc/os-release 2>/dev/null && echo "${PRETTY_NAME:-unknown}" || echo unknown)"
  command -v repo >/dev/null && log "repo launcher: $(repo version 2>/dev/null | head -1)" \
                             || log "repo launcher: NOT INSTALLED (apt-get install repo)"
  if [ "${ok}" -ne 0 ]; then
    die "host does not meet documented AOSP minimums; see docs/build-host-plan.md (do not rent/buy anything without owner approval)"
  fi
  log "Host meets the documented minimums."
}

do_sync() {
  check_host
  mkdir -p "${AOSP_DIR}" && cd "${AOSP_DIR}"
  if [ ! -d .repo ]; then
    log "== repo init (${AOSP_TAG}) from ${MANIFEST_URL} =="
    repo init --partial-clone --no-use-superproject -b "${AOSP_TAG}" -u "${MANIFEST_URL}"
  else
    log "== existing .repo found; skipping init (AOSP_TAG change requires deleting .repo) =="
  fi
  log "== repo sync =="
  repo sync -c -j8
  log "Sync done. Record disk use: $(du -sh "${AOSP_DIR}" 2>/dev/null | cut -f1)"
}

do_build() {
  cd "${AOSP_DIR}"
  [ -f build/envsetup.sh ] || die "no build/envsetup.sh in ${AOSP_DIR} — run sync first"
  log "== lunch ${LUNCH_TARGET} =="
  # shellcheck disable=SC1091
  source build/envsetup.sh
  lunch "${LUNCH_TARGET}"
  log "== m (full build) =="
  local start end
  start=$(date +%s)
  m
  end=$(date +%s)
  log "Build finished in $(( (end - start) / 60 )) minutes. Record this in docs/testing/emulator-first-boot-prep.md §5."
  log "Next (host packages required): launch_cvd --daemon   # web UI https://localhost:8443 ; stop with stop_cvd"
}

case "${1:-check}" in
  check) check_host ;;
  sync)  do_sync ;;
  build) do_build ;;
  all)   do_sync; do_build ;;
  *)     die "unknown step '${1}' (use: check|sync|build|all)" ;;
esac
