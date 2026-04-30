---
name: capability-proof-checker
description: Assess what is possible in a software project and provide evidence-backed answers. Use when users ask what can be done, how specific business rules behave, how code will react to a payload, or when behavior is uncertain and must be validated by call-chain backtracking or automated tests instead of code reading alone.
---

# Capability Proof Checker

## Goal

Determine whether a requested behavior is currently supported, can be implemented safely, or is impossible with current constraints, and prove conclusions with concrete evidence.

## Workflow

1. Restate the requested capability in a testable form.
2. Find the execution path in code by tracing entry points to side effects.
3. Estimate confidence from static reading.
4. Choose proof mode:
- Use code backtracking evidence when confidence is high and behavior is deterministic.
- Run or add a minimal automated test when confidence is medium or low, branching is complex, or runtime/data-dependent behavior is involved.
5. Return verdict and evidence:
- `supported`
- `supported with conditions`
- `not supported`
- `uncertain` (only if blocked from required validation)
6. Propose the smallest safe change when unsupported.

## Evidence Rules

- Cite exact files and lines for every important claim.
- Prefer real execution evidence over speculation.
- State assumptions explicitly (feature flags, env vars, data shape, auth context).
- If tests cannot be executed, explain the blocker and provide the exact test that should be run.

## Backtracking Method

1. Identify entry point:
- Rails: route/controller, GraphQL resolver, job, rake task.
- Flutter: widget event, bloc/cubit action, repository method, API client.
2. Trace transforms and guards:
- validation
- authorization
- conditional branches
- data mapping
- persistence/network side effects
3. Record stop conditions and failure modes.
4. Summarize behavior as `given -> when -> then`.

## Test-First Proof Method

Use a minimal proof test when static reading is not enough.

1. Write one focused test for the exact user scenario.
2. Keep fixtures/data small and explicit.
3. Assert user-visible outcome and critical side effects.
4. Run only targeted tests first, then broader scope if needed.

## Output Format

- `Capability`: one-sentence restatement.
- `Verdict`: one of the four statuses.
- `Evidence`: bullets with file refs and/or test results.
- `Conditions/Risks`: only if applicable.
- `Next step`: minimal change or command to verify further.

## References

- For concrete Rails and Flutter proof recipes, read `references/proof-playbook.md`.
