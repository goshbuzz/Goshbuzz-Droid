# Build host plan (T1.1) — no budget

Status: **plan written 2026-10-21. No machine is provisioned yet**, so Phase 0's "build machine
ready" exit criterion is not met until one passes the check in §3. Costs below are approximate and
labelled; per `test-phone-shortlist.md`, a number I cannot verify is worse than no number — treat
every price as an order-of-magnitude anchor, not a quote.

All AOSP facts in this document were read from official AOSP documentation on 2026-10-21:

- [Set up for AOSP development](https://source.android.com/docs/setup/start/requirements)
- [Download the Android source](https://source.android.com/docs/setup/download)
- [Build Android](https://source.android.com/docs/setup/build/building)

## 1. What AOSP actually requires (verified 2026-10-21)

| Requirement | Value (official docs) |
|---|---|
| CPU | 64-bit x86 system |
| Free disk | **at least 400 GB** (250 GB checkout + 150 GB build) |
| RAM | **minimum 64 GB** (Google builds on 72-core/64 GB machines, ≈40 min per full build; a 6-core/64 GB machine takes ≈6 hours per full build) |
| OS | Any 64-bit Linux with glibc ≥ 2.17; **Ubuntu 18.04 or later** for Android 11+ |
| Software | OpenJDK, Make, Python 3 (prebuilt inside the latest release branch — no separate install), and Repo launcher ≥ 2.4 |

Notes:

- These numbers are for the current AOSP release (`android17-release` family). They are Google's
  stated **minimums**, not comfortable targets. A machine below them may still limp through an
  emulator build with swap and patience — do not plan on that, and do not promise it.
- Effective 2026, AOSP publishes source in Q2 and Q4; builds should track `android-latest-release`
  (or an exact tag). See `docs/testing/emulator-first-boot-prep.md` for the pinned tag and commands.

## 2. Options

Prices are approximate 2026 anchors gathered from public pricing pages/summaries on 2026-10-21 and
are **unverified quotes** — confirm before spending anything. Nobody is buying hardware in Phase 1.

| # | Option | Approx. cost | Pros | Cons |
|---|---|---|---|---|
| A | **Owner's existing PC or laptop** (x86_64) | 0 (electricity only) | No spend; full control; iteration is free | Must pass §3; a slow machine makes a 6-hour build painful |
| B | Second-hand desktop/workstation (x86_64, ≥64 GB RAM, 2× 1 TB+ NVMe) | One-off, varies wildly by country; typical used-IT market range is on the order of a few hundred USD — **verify locally** | Fast iteration, no per-hour meter; useful for every later phase | Up-front cash the project does not have; no purchase without owner decision |
| C | Rented cloud VM (burst) — e.g. 8 vCPU/64 GB or 16 vCPU/64 GB class | On-demand ≈ $0.50–0.81/hour (≈ $360–590/month if left running); spot/preemptible roughly 30–60% less; plus ≈400 GB block storage | Only pay for build windows; no hardware risk | Costs track build time; egress; a stalled VM still bills; spot can be interrupted mid-build |
| D | Free/academic/sponsored (university lab machine, employer build box with permission, cloud credits) | 0, if available | No spend | Access must be explicit and documented; do not build on anything you are not allowed to use |

Cloud anchors cited (2026-10-21, third-party summaries; verify on the provider's page before use):
8 vCPU/64 GB ≈ $0.50–0.53/hour on-demand (AWS r6i/r7i.2xlarge class, GCP n2-highmem-8);
16 vCPU/64 GB ≈ $0.77–0.81/hour on-demand (AWS m7i.4xlarge, GCP n2-standard-16 class).

## 3. Chosen setup (no budget): Option A first, measured before anything else

**Decision 2026-10-21: no purchase and no rental.** First run the read-only host check below on the
machine you already own. It only reads; it changes nothing.

```bash
# Read-only build-host check. Prints what we need; changes nothing.
echo "CPU:     $(uname -m)   # must be x86_64"
echo "Cores:   $(nproc)"
echo "RAM GB:  $(free -g | awk '/^Mem:/{print $2}')   # AOSP minimum: 64"
echo "Free GB on largest filesystem:"
df -BG --output=avail,target | sort -rn | head -4
echo "OS:      $(. /etc/os-release && echo $PRETTY_NAME)   # Ubuntu 18.04+ or other glibc>=2.17 Linux"
ldd --version | head -1
```

Reading the output:

- **x86_64 + ≥ 64 GB RAM + ≥ 400 GB free (on one filesystem you can use):** Option A works. Proceed
  to §4 and then `emulator-first-boot-prep.md`.
- **Close but short (e.g. 32 GB RAM, or 200–400 GB disk):** do not rent anything yet. Record the
  numbers in the Phase 0 checklist and let the owner decide between freeing disk/RAM (close apps,
  add swap, attach an external SSD) and Option C for the one big `repo sync` + first build window.
- **Way off (old laptop, < 16 GB RAM):** the honest answer is that AOSP work waits for hardware or
  a rented build window. Lite work (Phase 3) does not need a build host and can proceed meanwhile.

The Arena agent environment is explicitly **not** a build host: it measured 2 cores / 3 GB RAM /
20 GB free disk on 2026-10-21 — two orders of magnitude short. Do not attempt AOSP there.

## 4. Install steps on Ubuntu 18.04+ (verified from AOSP docs, 2026-10-21)

```bash
sudo apt-get update
# Required packages (AOSP "Install required packages"):
sudo apt-get install git-core gnupg flex bison build-essential zip curl \
  zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
  libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
# Repo launcher (Ubuntu package, version must be >= 2.4):
sudo apt-get install repo
repo version
```

If the distro `repo` package is missing or too old, install the launcher manually and verify its
signature (commands exactly as in the AOSP docs):

```bash
export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo
```

OpenJDK, Make and Python 3 need no separate install on the latest release branch (they ship as
prebuilts in the tree). For Cuttlefish (the emulator used in Phase 1) there is one more host step —
the KVM-capable host packages — in `emulator-first-boot-prep.md` §4.

## 5. Honest limits of this plan

- Build **times** depend heavily on the machine; the only trustworthy numbers will come from our
  first real build (recorded as T1.3 acceptance).
- A 64 GB RAM minimum means many consumer laptops are out. Say so; do not quietly recommend swap as
  if it were the same thing.
- Cloud spot instances can be interrupted mid-build; if the owner later approves a rented window,
  use on-demand for the first full build and record the actual cost.
- Nothing here buys, rents, or unlocks anything. Hardware purchase remains a separate owner decision
  (see `test-phone-shortlist.md` §6).
