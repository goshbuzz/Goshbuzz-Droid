# Security policy

## Reporting a vulnerability

**Do not open a public issue, and do not post details in chat, on social media, or in a merge request.**

Report privately using GitHub's **Report a vulnerability** button on the Security tab of this repository
(GitHub Private Vulnerability Reporting). If that is unavailable, contact the maintainer through the
project's published contact channel and ask for a private channel before sharing details.

Please include:

- Affected component and version or commit.
- Device and Android version, if device-specific.
- Steps to reproduce, or a proof of concept.
- What an attacker gains, and what access they need (remote, local app, physical, bootloader unlocked).
- Whether you plan to publish, and your preferred timeline.

## What to expect

| Stage | Target |
|---|---|
| Acknowledgement | within 7 days |
| Initial assessment (severity, affected versions) | within 14 days |
| Fix or mitigation for critical issues | as fast as is honestly possible; we will tell you the plan and any delay |
| Public advisory and credit | after a fix is available; we credit you unless you prefer otherwise |

This is a one-person project with no funding. Those targets are intentions, not a contract, and we will say so
plainly if we cannot meet them.

## Scope

In scope:

- Our own code: Privacy Manager, Lite app, installers, OTA server configuration, build and signing scripts.
- Our patches to AOSP and to any bundled app.
- Default configuration that weakens privacy or security compared with upstream AOSP.
- Undocumented network connections.

Out of scope for this project (report upstream instead):

- Vulnerabilities in AOSP itself that also affect stock builds, unless our change makes them worse. Report to
  the upstream project first; tell us too if a GoshBuzz build is affected.
- Vulnerabilities in the closed-source baseband/modem. We cannot patch it; we can only isolate it.
- Bugs in third-party apps we bundle. We will still help coordinate.
- Attacks that require an already fully compromised device, or a physical attack we explicitly state we do not
  defend against in [docs/threat-model.md](docs/threat-model.md).
- Missing hardening on devices we document as best-effort.

## What we will never do

- Ask you to test an exploit against a device you do not own.
- Ship a silent fix without a public advisory for a serious issue.
- Hide a known issue because it is embarrassing.

## Supported versions

There are no releases yet. This table will be filled in at the first release.

| Version | Supported |
|---|---|
| — | none yet |
