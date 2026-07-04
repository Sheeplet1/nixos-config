# AGENTS.md

## Creating Plans

Plans must be specific enough to hand off to implementation or review agents. Include relevant file
paths, symbols, and line references so the agent can locate the exact code being discussed.

Document which agents will be completing each task according to 'Picking the right models for the
workflows and subagents'.

## Picking the right models for workflows and subagents

Rankings, higher = better. Cost reflects what I actually pay (OpenAI has really generous limits), not list price. Intelligence is how hard a problem you can hand the model unsupervised. Taste covers UI/UX, code quality, API design, and copy.

| model    | cost | intelligence | taste |
| -------- | ---- | ------------ | ----- |
| gpt-5.5  | 9    | 8            | 5     |
| sonnet-5 | 5    | 5            | 7     |
| opus-4.8 | 4    | 7            | 8     |
| fable-5  | 2    | 9            | 9     |

How to apply:

- These are defaults, not limits. You have standing permission to override them: if a cheaper model's output doesn't meet the bar, rerun or redo the work with a smarter model without asking. Judge the output, not the price tag. Escalating costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships, intelligence > taste > cost.
- Bulk/mechanical work (clear-spec implementation, data analysis, migrations): gpt-5.5 — it's effectively free.
- Anything user-facing (UI, copy, API design) needs taste ≥ 7.
- Reviews of plans/implementations: fable-5 or opus-4.8, and gpt-5.5 as an extra independent perspective.
- Never use Haiku.
- Mechanics: gpt-5.5 is only reachable through the Codex CLI — `codex exec` / `codex review` (my `~/.codex/config.toml` defaults to gpt-5.5). Prefer the plugin commands: `/codex:rescue` for implementation, fixes, and delegation; `/codex:review` for standard code review; `/codex:adversarial-review` for challenge review. Fall back to `codex exec -s read-only` directly only for raw investigation or data analysis that the plugin commands don't cover.
- Claude models (sonnet-5, opus-4.8, fable-5) run via the Agent/Workflow model parameter.

Using gpt-5.5 inside workflows and subagents:

- The codex plugin handles this natively. `/codex:rescue` spawns a `codex:codex-rescue` subagent that forwards to the companion script (`codex-companion.mjs`), which calls the Codex CLI. No wrapper agent needed.

## Documenting code

Use documentation-dense comments: comments should explain intent, contracts,
constraints, and edge cases, not narrate the code.

- Doc-comment every non-boilerplate declaration using the language's conventional
  documentation comment form. This includes declarations at all visibility levels:
  types, fields, constants, functions, methods, constructors, helpers, and view or
  component declarations.
- Start doc comments with a one-sentence summary. Add paragraphs only when they carry
  useful reasoning: invariants, preconditions, lifetime or ownership rules, edge cases,
  rejected alternatives, or what would break if the code changed.
- Prefer accurate observable constraints over invented rationale. If the original intent
  is unclear, document what the code guarantees and the cases it handles.
- For non-trivial function bodies, add inline comments at logical steps explaining why
  that step exists. Do not comment obvious statements.
- Write full sentences: capitalized, punctuated, period-terminated, and wrapped for
  readability around 100 columns.
- Keep TODOs. Do not delete them during comment or style passes.
- Keep comments adjacent to what they describe and update them with the code. A stale
  comment is worse than no comment.
- Tests should have a suite-level doc comment describing what behavior the suite covers.
  Use inline test comments only for non-obvious scenarios. Generated or untouched
  framework boilerplate is exempt.

## Conclusion

After every completion:

- Provide a summary of which agents completed which tasks.
- Always lint and format after as well.
