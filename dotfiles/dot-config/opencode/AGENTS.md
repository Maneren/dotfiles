# Global Instructions

- Try to maintain short feedback loop with the user, avoid falling into long rabbit-holes that may turn out to be dead-ends. Always confirm with the user when the task seems harder than initially expected.
- Do not blindly assume intent. Ask for clarification and feedback often.
- Keep changes to the minimum–do not fix preexisting warnings or errors outside the main task. Notify user in the final message.
- Always check the project for linters, formatters, and similar tooling, and use them. Ideally through `make`, `just`, or other chosen command runner.
- Prefer modern language features, checking the newest version supported by the project.
- Prefer built-in tools over shell commands. Prefer `ast-grep` over regex-based search-and-replace.
- Do not run `find` or similar commands on `/`, `/home`, or other large directories. Prefer a small-scope `find`, or ask for the location.
- When running a script using `python - <<PY` for a second time, save it into a file instead of repeating.
- Keep code comments terse; add them only where necessary.
- Do not use decorative section-separator comments. Prefer splitting code into more functions, classes, or files.
- Prefer functional and declarative code patterns.
- If the task would be simpler with a library, ask the user to install it.
- For larger tasks, create small commits often. Match the existing style from `git log`, usually with single-line messages.
  - Make sure, the code is linted and formatted before each commit.

## Tooling and LSP

- Prefer configured LSP servers for diagnostics, syntax/type feedback, and code understanding over manually reading files or running equivalent CLI commands.
- Fall back to CLI linters, type checkers, and tests when no LSP covers the language, when its diagnostics are insufficient, or when the project documents a required workflow.
