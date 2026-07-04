# AGENTS.md

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
- Reviews of plans/implementations: fable-5 or opus-4.8, optionally gpt-5.5 as an extra independent perspective.
- Never use Haiku.
- Mechanics: gpt-5.5 is only reachable through the Codex CLI — `codex exec` / `codex review` (my `~/.codex/config.toml` defaults to gpt-5.5). Prefer the plugin commands: `/codex:rescue` for implementation, fixes, and delegation; `/codex:review` for standard code review; `/codex:adversarial-review` for challenge review. Fall back to `codex exec -s read-only` directly only for raw investigation or data analysis that the plugin commands don't cover.
- Claude models (sonnet-5, opus-4.8, fable-5) run via the Agent/Workflow model parameter.

Using gpt-5.5 inside workflows and subagents:

- The codex plugin handles this natively. `/codex:rescue` spawns a `codex:codex-rescue` subagent that forwards to the companion script (`codex-companion.mjs`), which calls the Codex CLI. No wrapper agent needed.

## Documenting code

Write comments in prose that explain intent and contracts, not a play-by-play of the code.

- Doc-comment every public declaration — types, functions, fields, constants. If it's part of the API surface, it gets a comment.
- Explain _why_, not _what_. The code already shows what it does; the comment carries the reasoning, the tradeoff, and the context that would otherwise require archaeology to recover.
- State invariants and contracts: preconditions, what must hold, memory/resource ownership and lifetimes (who allocates, who frees, who closes), and what the function guarantees on return.
- Call out the non-obvious: edge cases, surprising behavior, and why a rejected alternative was rejected. One "we do X instead of Y because Z" is worth ten comments that restate the code.
- Write full sentences — capitalized, punctuated, ending in a period. Comments are documentation, not shorthand.
- Keep comments adjacent to what they describe and update them with the code. A stale comment is worse than no comment.
