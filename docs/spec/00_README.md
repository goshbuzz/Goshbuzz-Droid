# GoshBuzz OS: Agent Pack

A set of system and spec files for an AI agent (for example on Arena.ai) that will help build **GoshBuzz**, a free, open-source, privacy-first Android-based ROM.

## How to use this pack

1. Paste the full contents of `01_SYSTEM_PROMPT.md` into the agent's **system prompt** (or "instructions") field.
2. Attach or paste the other files as **context/knowledge** files:
   - `02_PROJECT_SPEC.md`: what we are building and every decision made so far
   - `03_ARCHITECTURE.md`: how it is built
   - `04_INSTALLER_SPEC.md`: the "install like a theme" experience
   - `05_ROADMAP.md`: phases and exit criteria
   - `06_TASK_BACKLOG.md`: first tasks with acceptance criteria
   - `07_LEGAL_AND_RISKS.md`: legal rules, risks, and hard limits
3. Start the session with: "Read all context files. Summarize the current phase and propose the next 3 tasks from the backlog."
4. Keep the files updated. When a decision changes, edit `02_PROJECT_SPEC.md` (decision log) first, then tell the agent.

## Working name
GoshBuzz OS (the word "Android" must not appear in the product name; describe it as "based on the Android Open Source Project").

## Owner profile (for the agent)
- Solo developer, self-funded, open-source community project.
- Has installed custom ROMs as a user, but has never built a ROM or AOSP before.
- Wants clear, step-by-step guidance, exact commands, and warnings before anything risky.

## Version
Pack v1.0, October 2026. Verify any version numbers, URLs and tool names against current official documentation before using them.
