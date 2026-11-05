# Global Instructions

- Keep comments terse; add them only where necessary.
- Prefer functional and declarative code patterns.
- Prefer modern language features, checking the newest version supported by the project.
- Do not blindly assume intent. Ask for clarification and feedback often.
- Keep changes to the minimum. Do not fix e.g. linter warning outside the main task.
- Do not use decorative section-separator comments. Prefer splitting code into more functions, classes, or files.
- Always check the project for linters, formatters, and similar tooling, and use them, preferably through `make`, `just`, or another project runner.
- Do not run `find` or similar commands on `/`; it will take ages. Prefer a small-scope `find`, or ask for the location.
- If the task would benefit from a library, ask me to install it.
- For larger tasks, create small commits often. Match the style from `git log`, always with single-line messages.
- Prefer built-in tools over shell commands.
- When running a script using `python - <<PY` for a second time, save it into a file instead of repeating.
