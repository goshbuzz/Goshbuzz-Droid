# AOSP emulator first boot — preparation (T1.3-pre)

Status: **prepared 2026-10-21 from official AOSP documentation. Not executed** — the agent
environment has no build host (2 cores / 3 GB RAM / 20 GB disk vs the 400 GB / 64 GB minimum; see
`../build-host-plan.md`). Every command below is copied or adapted from the pages cited in §1 and
must be re-verified against those pages before the first run, because AOSP changed its release
process in 2026.

Phase 1 is **emulator-first**: the target is a Cuttlefish virtual device, not the owner's Tecno
Spark (which stays a Lite-testing device — never a build target, never to be unlocked or flashed).

## 1. Sources verified on 2026-10-21

| Fact | Value | Source |
|---|---|---|
| Release process (2026) | AOSP publishes source in Q2 and Q4; build from `android-latest-release` (always points at the most recent release) | [Changes to AOSP](https://source.android.com/docs/whatsnew/site-updates#aosp-changes), banner on all setup pages |
| Current release branch | `android17-release` (Android 17, API 37, 26Q2) | [Requirements](https://source.android.com/docs/setup/start/requirements), [build numbers](https://source.android.com/docs/setup/reference/build-numbers) |
| Latest platform tag | `android-17.0.0_r1` (build `CP2A.260605.016`, security patch level 2026-06-05) | [Codenames, tags, and build numbers](https://source.android.com/docs/setup/reference/build-numbers) |
| Latest security tag | `android-security-17.0.0_r1` | same |
| Manifest URL | `https://android.googlesource.com/platform/manifest` | [Download the Android source](https://source.android.com/docs/setup/download) |
| Repo launcher | `https://storage.googleapis.com/git-repo-downloads/repo` (+ `.asc`; signing key `8BB9AD793E8E6153AF0F9A4416530D5E920F5C65`) | [Requirements](https://source.android.com/docs/setup/start/requirements) |
| Emulator target (Cuttlefish) | `aosp_cf_x86_64_only_phone` with release config `aosp_current`, variant `userdebug` | [Build Android](https://source.android.com/docs/setup/build/building) |
| Cuttlefish host + launch | Debian packages from `https://github.com/google/android-cuttlefish`; `launch_cvd --daemon`, `stop_cvd`, web UI on port 8443 | [Cuttlefish: Get started](https://source.android.com/docs/devices/cuttlefish/get-started) |

**Pin policy for this project:** use tag `android-17.0.0_r1` for the first build so the result is
reproducible and the record is unambiguous. `android-latest-release` is fine for learning but moves.
Re-check the tags table on the day of the build: by then there may be an `android-17.0.0_r2` or a
newer security tag.

## 2. Ubuntu packages (18.04+, verified 2026-10-21)

```bash
sudo apt-get update
sudo apt-get install git-core gnupg flex bison build-essential zip curl \
  zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
  libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig repo
repo version   # must print >= 2.4
```

## 3. Get the source and build (the exact sequence)

```bash
mkdir -p ~/aosp && cd ~/aosp

# Pinned init (reproducible). For "latest", replace the tag with android-latest-release.
repo init --partial-clone --no-use-superproject \
  -b android-17.0.0_r1 -u https://android.googlesource.com/platform/manifest

repo sync -c -j8          # official docs: "a little over an hour" on a good connection

source build/envsetup.sh
lunch aosp_cf_x86_64_only_phone-aosp_current-userdebug
m                          # full build; 6h+ on a 6-core/64GB machine, less on bigger ones
```

`lunch` format is `product_name-release_config-build_variant`. If the short two-part form
(`aosp_cf_x86_64_only_phone-userdebug`) is what `lunch` offers on the pinned tag, that is the same
target with the default release config — record whichever form the tree accepted.

Android 17 builds treat the source tree as read-only. If a build step fails with read-only errors,
the official escape hatches are `BUILD_BROKEN_SRC_DIR_IS_WRITABLE=true` (whole tree) or
`BUILD_BROKEN_SRC_DIR_RW_ALLOWLIST="path1,path2"` (specific paths) — use only to diagnose, and
record any use.

## 4. Host packages for Cuttlefish and first boot

```bash
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl
git clone https://github.com/google/android-cuttlefish
cd android-cuttlefish
tools/buildutils/build_packages.sh
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f
sudo usermod -aG kvm,cvdnetwork,render $USER
sudo reboot                # loads kernel modules and udev rules
```

Then, from the build output directory (after `m`, the images land in `$OUT_DIR`):

```bash
launch_cvd --daemon        # boot the virtual device
# web UI: https://localhost:8443
stop_cvd                   # shut it down
```

Success looks for the boot log lines `VIRTUAL_DEVICE_BOOT_STARTED` → `VIRTUAL_DEVICE_BOOT_COMPLETED`
(see the Cuttlefish docs). Use `adb devices` to confirm the instance is reachable.

**Zero-build rehearsal (worth doing first):** prebuilt Cuttlefish images for
`aosp_cf_x86_64_only_phone` (`userdebug`) are published on <https://ci.android.com/>. Downloading an
image zip plus the matching `cvd-host_package.tar.gz` (same build!) exercises `launch_cvd`, the web
UI, and `adb` without a 6-hour build. This does **not** replace T1.3 — T1.3 requires a *self-built*
image to boot — but it de-risks the host setup.

## 5. What T1.3 will record (acceptance, when it runs)

- [ ] Exact tag actually used (and the tags-table date).
- [ ] `repo sync` wall time and disk used after sync.
- [ ] `m` wall time, peak disk, and the exact `lunch` string.
- [ ] Boot evidence: `VIRTUAL_DEVICE_BOOT_COMPLETED` log line and `adb devices` output.
- [ ] Every error and the fix, in the style of the T1.2 build log.
- [ ] The build script (`ci/aosp-emulator-build.sh`) run end-to-end, or updated to match reality.

## 6. Safety

- Nothing here touches the owner's Tecno Spark or any physical phone. Emulator only.
- Do not run `fastboot flashing unlock` on any personal device as part of this task
  (`test-phone-shortlist.md` §2.5).
- The build downloads ~250 GB from Google; run it only on a host and network the owner approved.
