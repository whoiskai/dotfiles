---
name: todo
description: Add, list, complete or delete tasks and reminders in the user's Microsoft To Do with the local `todo` CLI. Use whenever the user says "remind me", asks to add a task or to-do, wants a follow-up for a future date, or asks what's on their task list. Never use cloud routines or Apple Reminders for reminders.
---

# Microsoft To Do via `todo`

The user's reminders live in Microsoft To Do, which they see on their Mac mini, MacBook Air and Android devices.
`~/.local/bin/todo` talks to it through Microsoft Graph. Run `todo --help` for the full syntax.

Don't create cloud routines (RemoteTrigger / schedule skill) or Apple Reminders for reminders. The user declined both:
they want reminders local, and Apple Reminders doesn't reach their Android devices.

## Commands

```bash
todo lists                                  # list names; the default list is "Tasks"
todo ls [--list NAME] [--all]               # open tasks (--all includes completed), with 6-char IDs
todo add "title" [--list NAME] [--due YYYY-MM-DD] [--remind "YYYY-MM-DD HH:MM"] [--notes TEXT | --notes -]
todo done ID [--list NAME]
todo rm ID [--list NAME]
```

- Times are local (Asia/Singapore). Resolve "next Monday 9am" against `date` before calling `todo add`.
- `--list` matches names without their leading emoji: `--list Homelab` finds "🧪 Homelab".
- Pass multi-line notes on stdin with `--notes -` and a quoted heredoc.

## How to add a reminder

1. Pick the list. Homelab and infrastructure items go in "🧪 Homelab"; otherwise use the default "Tasks" unless an
   existing list clearly fits (`todo lists`). Don't create lists.
2. Run `todo ls --list NAME` first and don't add a duplicate.
3. Set both `--due` and `--remind`. Without `--remind` no notification fires. Default to 09:00–10:00 if the user gives
   no time.
4. Write the notes for the user reading them weeks later: exact commands, file paths, what "done" looks like.
5. Echo the resulting `todo ls` line back to the user.

Ask before `todo rm` or `todo done` on a task Claude didn't create. Don't list unrelated personal lists (food, travel,
etc.) just to test something; use the Homelab list.

## Sign-in

The login (MSAL token cache) is in the macOS Keychain, service `claude-todo`. Never read or print it.
If `todo` says "not signed in", run `todo login` in the background, read its output, and give the user the URL and
code. It stays signed in as long as it's used at least once every ~90 days.

The app registration `claude-todo` is in the user's own Entra directory (personal Microsoft accounts only,
`Tasks.ReadWrite`). The client ID is in the script and isn't a secret.
