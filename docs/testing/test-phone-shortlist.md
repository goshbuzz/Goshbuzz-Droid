# Test phone shortlist (T0.5) — draft

Status: **draft, incomplete on cost.** The technical research is done; the purchase decision needs three
answers from the owner (see §6). Prices are deliberately omitted: they vary wildly by country and by second-hand
condition, and a number I cannot verify today is worse than no number.

Costs nothing to start: **Phase 1's first build can target the Android emulator** (see §2). Do not buy anything
until you have built and booted once on the emulator.

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

## 6. Open questions for the owner

1. **Budget ceiling** for a test device, in your local currency.
2. **Where you will buy** (local market, online marketplace, grey import). This changes both price and whether
   the unit is the correct region variant.
3. **Do you already own a phone you can sacrifice**, and if so which exact model? If it is a Pixel 6 or newer,
   we may not need to buy anything for Phase 1.

When I have those three answers I will finish this document: a concrete buy recommendation, a "how to verify
before you pay" checklist for that exact listing, and a cost estimate.
