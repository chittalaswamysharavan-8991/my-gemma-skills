# my-gemma-skills — legacy generic example

> Status: legacy and non-canonical. This repository is retained as a small,
> generic text-only daily-assistant example; it is not a source of personal
> context, product policy, or operational instructions.

## What is here

`SKILL.md` demonstrates a privacy-aware assistant that can help a person plan
their day, reflect on habits they explicitly share, and choose next actions.
It deliberately contains no person-specific profile, location, work history,
relationships, projects, schedules, or tracked data.

## Sharva guidance

For Sharva-specific guidance, `/SharvaOS/CHATGPT.md` is authoritative. Do not
copy, extend, or treat this legacy example as a replacement for that contract.

## Validation

Run the lightweight privacy/governance check before publishing changes:

```sh
bash scripts/validate-privacy-governance.sh
```

The check rejects known direct identifiers and private-context markers in the
published assistant example and repository overview.
