# AGENTS.md

## Creating Plans

Plans must be specific enough to hand off to implementation or review agents. Include relevant file
paths, symbols, and line references so the agent can locate the exact code being discussed.

## Documenting code

- Doc comments should have a one-sentence summary.
- If the decision behind code is not immediately obvious, then there should be an accompanying comment that
  explains why this decision was chosen.
- Comments must be precise but follow prose.
- Keep TODOS. Do not delete them during comment or style passes.
- If the test's name cannot explain the behaviour concisely, then add an accompanying doc comment
  to describe what it is testing.

## Conclusion

After every completion:

- Provide a summary of which agents completed which tasks.
- Always lint and format if existing violations were introduced by this change.
