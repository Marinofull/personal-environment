# Proof Playbook

## Rails API Projects

### Capability discovery checklist

1. Locate entry point (`config/routes.rb`, GraphQL schema/resolvers, controllers, jobs).
2. Find domain model callbacks/concerns affecting behavior.
3. Trace persistence changes and transaction boundaries.
4. Verify auth/permission checks before mutation side effects.

### When to add an automated test

Add a test if any of these apply:
- Rule depends on multiple conditions across files.
- Behavior depends on DB state or callbacks.
- Side effect is async (jobs, mailers, external services).
- Reading code leaves more than low uncertainty.

### Preferred proof style

- Reuse existing spec style and helpers.
- Add one scenario that mirrors the user's real input.
- Assert both primary outcome and critical side effect.

### In this repository

- Use `scripts/rspec_with_mongo.sh spec/path/to_spec.rb` for RSpec runs.
- Do not use raw `rspec` or `bundle exec rspec` in Codex sandbox.

## Flutter Projects

### Capability discovery checklist

1. Trace from UI trigger (widget action) to state layer (Bloc/Cubit/Notifier).
2. Follow repository and service/API client chain.
3. Inspect payload serialization/deserialization.
4. Validate conditional rendering and error-state handling.

### When to add an automated test

Add a test if any of these apply:
- Behavior depends on async timing/state transitions.
- Payload has optional or polymorphic fields.
- UI output changes by state combination.
- Nullability/defaults can alter branch outcomes.

### Preferred proof style

- Unit test for mapper/repository payload behavior.
- Widget test for user-visible behavior under state transitions.
- Keep payload fixtures minimal and explicit.

## Verdict language

- `supported`: code path and evidence confirm requested behavior.
- `supported with conditions`: works only with explicit constraints.
- `not supported`: code path blocks or lacks required behavior.
- `uncertain`: blocked from necessary runtime proof (missing env/deps/access).
