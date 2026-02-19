---
name: pr-review
description: Review pull requests using only `git diff origin/main` as the diff command (run exactly that, no other diff variants). Use to critique changes for clean code issues (overengineering, SRP/DRY/KISS violations, nested conditionals, null-safety misuse, poor naming), plus framework/language misconceptions by cross-checking repository docs (README, conventions) and the surrounding code context. Use when a user asks to review a PR and may provide an intended goal via a `#blabla` placeholder to replace.
---

# PR Clean Code Review

## Inputs

- Run `git diff origin/main` and review the resulting diff.
- If the user provides a goal to replace `#blabla`, include it verbatim in the review.
- If the user uses `#blabla` but provides no replacement, ask one short question for the intended goal; if it is still unknown, omit any mention of `#blabla`.

## Command Policy

- Run exactly `git diff origin/main` for the diff. Do not run any other `git diff` command.
- If the user explicitly says “no other command”, treat it as “no other git commands”; for additional context (README/framework conventions), ask the user to paste the relevant files/sections instead of running more commands.

## Review Workflow

1. Read the diff end-to-end once, then re-read focusing on architecture and maintainability.
2. Identify change intent per file: what problem it tries to solve and what new responsibilities it introduces.
3. Flag clean code issues:
   - Overengineering: unnecessary abstractions, indirection, premature generalization, speculative extensibility.
   - SRP: functions/classes/modules doing multiple jobs, cross-layer coupling, leaky boundaries.
   - DRY: duplicated logic or near-duplicates that should be extracted.
   - KISS: complexity that can be simplified without losing correctness.
   - Conditionals: deeply nested branching, negative conditionals, complex predicates (encapsulate intent).
   - Null-safety: misuse of optionality, defensive programming hiding real invariants, unclear ownership/lifetimes.
   - Naming: unclear, inconsistent, or misleading names; ambiguous domain language.
4. Check framework/language alignment:
   - Compare patterns in the diff to repo conventions and framework idioms.
   - Call out “goal misunderstandings” where the change fights the framework or repository direction.
5. Produce actionable suggestions with concrete, minimal refactors and examples anchored to the diff hunks.

## Output Format

- Intended PR Goal: <only include if user provided a goal to replace `#blabla`>
- Summary: 2–5 bullets of what changed and overall risk.
- Major Findings: high-impact issues first (design/architecture/bugs).
- Clean Code Findings: grouped by SRP/DRY/KISS/conditionals/null-safety/naming.
- Framework/Repo Alignment: misconceptions, guideline mismatches, missing conventions.
- Suggested Refactors: small steps, ordered, with expected impact.
- Questions: 3–8 crisp questions to clarify requirements or hidden constraints.

## Example Prompts

- Run `git diff origin/main`, no other diff command, and review this PR for SRP/DRY/KISS and overengineering.
- Run `git diff origin/main`, review this PR. This PR is supposedly to do: Improve task retry semantics for Airflow DAGs.
- Run `git diff origin/main`, review this PR. This PR is supposedly to do: #blabla
