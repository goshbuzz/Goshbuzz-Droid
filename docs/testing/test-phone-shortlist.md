# Test phone shortlist (T0.5) — draft

Status: **decided 2026-10-21 — no hardware purchase.** Phase 1 builds target the Android emulator. The
owner's own device (Tecno Spark, exact model to be checked) is a Lite/tester device, not a build target. See §2.5.
Prices are deliberately omitted: they vary by country and second-hand condition, and a number I cannot verify is
worse than no number. The Pixel research below stays here for when a budget exists.

## 1. What the test phone must do for us

| Requirement | Why | Hard or soft |
|---|---|---|
| Bootloader officially unlockable, without a vendor account or wait | Every flash attempt needs it; a wait period blocks a working session | **Hard** |
| Unlock wipe is acceptable (spare device) | Unlocking erases all data | **Hard** |
| Fastboot access to `boot`, `system`/`super`, `vbmeta` | Needed to flash our builds and to test verified boot | **Hard** |
| Published factory images / full OTA for recovery | Our safety net when a build does not boot | **Hard** |
| Active AOSP-adjacent device tree or a Treble GSI path | So the first build is not also a device-porting project | **Hard** |
| Verified boot that accepts a custom key | Tests our AVB story, the honest-limits story | Soft, strongly preferred |
| Hardware-backed keystore / secure element | Tests encryption and brute-force resistance | Soft |
| Cheap enough to lose | First-time flashing goes wrong | Soft |
| 7 years of vendor updates from launch | Long-term maintainability of the tier-1 device | Soft |

## 2. Recommendation in order

### Step 0 — Free: build for the emulator first

Before buying hardware, complete the toolchain learning on `aosp_*_userdebug` emulator targets or the Android
Studio emulator (`sdk_phone64_x86_64` style targets). This proves `repo`, `soong`, build time, disk space, and
your host setup without risking a device. It exercises none of the bootloader, AVB, or vendor-blob work, so it is
a rehearsal, not the real test.

### Step 1 — Best first real device: a **Google Pixel**, used, 6th generation or newer

Why this is the least risky choice for someone building a ROM for the first time:

- **Official, self-service unlock, no waiting period, no vendor application.** On Nexus/Pixel devices
  manufactured in 2015 or later the documented command is `fastboot flashing unlock` (`fastboot oem unlock` is
  the pre-2015 form). Google's own flashing documentation states that unlocking deletes user data.
  Source: [AOSP: Flash with fastboot](https://source.android.com/docs/setup/test/running) and
  [AOSP: Lock and unlock the bootloader](https://source.android.com/docs/core/architecture/bootloader/locking_unlocking).
- **Factory images and full OTA images are published for every Pixel**, which is our recovery path when a build
  does not boot: [developers.google.com/android/images](https://developers.google.com/android/images).
- **Reference implementation of Android Verified Boot.** Pixels are the platform where AVB, the secure element
  (Titan M), and custom-key enrolment are best documented, so our verified-boot story can actually be tested.
- **The most mature alternate-OS tooling exists for them.** The GrapheneOS project supports Pixels only and
  publishes its reasoning and device list at [grapheneos.org/faq](https://grapheneos.org/faq); their build and
  flashing documentation is a useful cross-check for ours.

Generation guidance, from the GrapheneOS support table (checked 2026-10-21):

| Generation | Vendor support ends (minimum) | Hardware memory tagging | Suitable as our tier-1 device |
|---|---|---|---|
| Pixel 6 / 6 Pro / 6a | Oct 2026 / Oct 2026 / Jul 2027 | no | **No** — 6 and 6 Pro are out of support now |
| Pixel 7 / 7 Pro / 7a | Oct 2027 / Oct 2027 / May 2028 | no | Marginal: cheap, but the clock is nearly up |
| Pixel 8 / 8 Pro / 8a | Oct 2030 / Oct 2030 / May 2031 | yes | **Yes** |
| Pixel 9 family and later | 2031+ | yes | Yes, if the budget allows |

Practical reading: **a used Pixel 8a is the sweet spot** if the budget stretches; **a Pixel 7a** is the
budget fallback, accepting that vendor security updates end in 2028 and it lacks memory tagging.

One important caveat to check **before paying**: carrier-locked Pixels, most commonly US Verizon models, ship
with OEM unlocking permanently disabled and the toggle greyed out. Buy an unlocked, non-carrier model. Verify by
booting the phone and confirming `Settings → System → Developer options → OEM unlocking` is present and can be
switched on. If it is missing, do not buy: no tool changes that.

### Step 2 — Fallback: a popular, well-supported budget device

If Pixels are hard to source or too expensive locally, the alternative is a device with a large community and a
published device tree. The cost of that choice is real:

- **Xiaomi / Redmi / POCO (HyperOS)**: unlocking is an **application, not a command**. You apply inside the
  Xiaomi Community app (version 5.3.31 or newer) under *Me → Unlock bootloader*; the account must be registered
  outside mainland China and active for 30+ days; there is a **daily quota**, roughly **1 device per month and
  3–4 per year per account**, permission expires and must be re-applied for, and you need a Windows PC running
  the Mi Unlock Tool. Devices sold for mainland China are effectively not unlockable through official channels.
  Sources: [Xiaomi Boot Loader Lock FAQ](https://www.mi.com/global/support/faq/details/KA-07238/) and
  [Xiaomi's unlock rules announcement](https://new.c.mi.com/global/post/673501).
  Verdict: **not recommended as the first device** — the wait and quota stand between you and a debugging
  session, and that is exactly when you need to flash repeatedly.
- **Samsung**: not researched in this pass. Do not assume it works. US-market models commonly have unlocking
  disabled, and Knox permanently records a custom system, which breaks some Samsung features. If you want to
  consider Samsung, I will research your exact model first.
- **Motorola**: a documented web-based unlock-code process exists, but eligibility varies by model and by sales
  region. Verify your exact model on Motorola's official unlock page before buying.
- **OnePlus / Nothing / Fairphone**: community-friendly on some models, inconsistent across generations and
  regions. Verify per model.

## 2.5 Your Tecno Spark: what it can and cannot do for this project

**Verdict: useful as a GoshBuzz Lite test phone and a real-world privacy target, not as a development device.**

Why not a build target, based on what I could verify:

1. **Tecno gates unlocking behind an account and a wait.** Community guides report that the OEM unlocking toggle
   stays greyed out until you create a Tecno ID and wait, commonly cited as up to about two weeks.
   (XDA guide for Spark 20: <https://xdaforums.com/t/guide-rooting-tecno-spark-20-kj5n-twrp-custom-recovery.4667636/>,
   and the Spark 10 root guide: <https://github.com/AhmadMorningstar/Tecno-Spark-10-Root-Guide>.) A two-week wait
   between flash attempts is incompatible with development.
2. **On Unisoc-based models, unlocking has been removed rather than restricted.** Reports for the Spark Go 1
   (KL4, Unisoc T615) say both `fastboot flashing unlock` and `fastboot oem unlock` fail or are unknown commands
   even with OEM unlocking enabled, and that the community unlock relies on a chip-level BootROM exploit
   (CVE-2022-38694). Source: <https://xdaforums.com/t/solved-any-way-to-unlock-the-bootloader-of-tecno-spark-go-1-kl4.4735102/>
   and the KL4 guide thread. **We will not use that path**, and not only for policy reasons: an exploit-based
   unlock cannot be part of an installer we hand to ordinary users, and it is a chip-level operation with a real
   chance of an unrecoverable device.
3. **No factory images or kernel source published** for Spark models, as far as I could verify. That removes our
   recovery net and breaks the GPL obligation for any build we would distribute, so a Tecno device build could
   not legally ship without vendor source we do not have.
4. **MediaTek-based Spark models are a different story** and sometimes accept `fastboot flashing unlock` after
   the Tecno ID wait. Unverified for your unit until we check.

This is not a criticism of the hardware; cheap phones are what most of the world uses, and they are exactly who
this project should serve. But "we cannot build it" and "it cannot be helped" are different statements. Lite is
the honest answer for this class of device, and being able to say that plainly is part of the point.

### Step 1 (safe, read-only): identify the phone

Turning on USB debugging is a settings change, not a wipe, and can be turned off again. Nothing below writes to
the device.

```bash
# On the phone: Settings → About phone → tap "Build number" 7 times
#   → Settings → System → Developer options → enable "USB debugging"
# Connect by USB, accept the prompt on the phone, then on the computer:

adb devices                      # expect: <serial>  device
adb shell getprop ro.product.model
adb shell getprop ro.product.device        # this is the codename we would need
adb shell getprop ro.board.platform        # mediatek / ums9230 / ... tells MTK vs Unisoc
adb shell getprop ro.build.version.release # Android version
adb shell getprop ro.build.version.security_patch  # the honest patch level to display
adb shell getprop ro.treble.enabled        # true = a GSI is at least conceivable later
adb shell getprop ro.boot.flash.locked     # 1 = bootloader locked
adb shell getprop ro.boot.verifiedbootstate
```

Then look, by hand, at **Settings → System → Developer options → OEM unlocking**:

- Toggle present and not greyed out → some hope, but still no factory image, so still not a build target.
- Toggled greyed out → that is the Tecno ID wait, and it confirms the gating above.

**Do not run `fastboot flashing unlock` on this phone.** It erases everything, and on this class of device it
may also be the last step before a device that will not boot. If you ever want to try it, we do it on a device
you can afford to lose, after a full backup, and after I have written the recovery plan.

### What we will use it for

- Phase 3 (T3.1): install GoshBuzz Lite and test it against a real, cheap, current phone with vendor bloat —
  the exact conditions most of our users are in.
- A source of truth for the permission audit and the privacy-score wording: what does a phone like this actually
  leak out of the box? Captured on your own device, with your consent, and never uploaded anywhere by us.

## 3. Devices to avoid for the first build

- Anything with a permanently locked bootloader (many US carrier models, several 2024+ flagships).
- Anything whose vendor has no published factory image or full OTA.
- Your daily-driver phone. The first flash attempt should assume data loss.
- Very old devices (Android 5–7): that is Phase 6 work, and it is the least likely to succeed first.

## 4. What I need to verify before any purchase

| # | Item | How |
|---|---|---|
| 1 | Exact model number and region variant | From the listing, not the marketing name |
| 2 | OEM unlocking present and not greyed out | In person, on the device |
| 3 | Factory image / full OTA published for that exact model | Vendor's official page |
| 4 | Community device tree or working GSI report for that model | Project's public device list / forums (treat as unverified until a person tests) |
| 5 | Return policy if the bootloader turns out to be locked | Seller's terms, in writing |

Anything I cannot verify, I will mark as unverified rather than guess.

## 5. Safety before the first flash (applies to whichever device)

1. Use a spare phone. Assume every byte on it will be erased.
2. Download the stock factory image for the exact model **before** flashing anything, and confirm you know the
   restore procedure.
3. Confirm the battery is above roughly 50% and use a good USB data cable.
4. Read the recovery page first, not after.

## 6. Decisions made, and what is still open

Answered 2026-10-21:

1. **Budget:** none right now. Phase 1 proceeds on the emulator only.
2. **Existing hardware:** a Tecno Spark. Assessed above; used for Lite testing, not for building.
3. **License:** decided (GPLv3-or-later / AGPL for services / Apache-2.0 for docs and device data). See
   [`../../LICENSING.md`](../../LICENSING.md).

Still open, and only needed when a budget appears:

- Budget ceiling and country of purchase, so I can name a specific used model and a "verify before you pay"
  checklist for that listing.
- If the Spark turns out to be MediaTek-based and you later buy a second cheap phone, a used Pixel 7a or 8a is
  still the recommendation for the *first* build: official self-service unlock, published factory images, and a
  recovery path that does not depend on a vendor account.
