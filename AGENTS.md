# Agent Notes

Use this file as a quick navigation guide. Do not treat it as the source of project truth.

## Where To Look

- Start with `README.md` for registry purpose, layout, and common Terragrunt commands.
- Check `environments/local/README.md` for local bootstrap context.
- Inspect `environments/<env>/terragrunt/env.hcl` for environment-level source settings before changing Terragrunt units.
- Use repository search for details instead of guessing:
  - `rg "<term>" README.md environments domains`
  - `find environments -maxdepth 5 -type f -print`

## Related Repositories

These repositories are related but independently cloned. Do not assume local sibling paths exist. If a path is needed, check it first with `test -d <path>` and confirm the remote with `git -C <path> remote -v` when identity matters.

| Repository | Purpose | Canonical URL | Possible Local Path |
| --- | --- | --- | --- |
| datahive | Architecture, vocabulary, ADRs, platform purpose | git@github.com:DecentraB/datahive.git | `../datahive` |
| datahive-blueprints | Reusable Terraform modules, Helm charts, templates, policies, and bootstrap assets | git@github.com:DecentraB/datahive-blueprints.git | `../datahive-blueprints` |
| datahive-registry | Environments, domains, shared substrate configuration, access policy, and onboarding | git@github.com:DecentraB/datahive-registry.git | `.` |

Use `datahive` for architecture context. Use `datahive-blueprints` for module behavior only after checking whether a local checkout exists or by following the canonical Git source.

## Blueprint Sources

- Blueprint modules are consumed as Git dependencies through `blueprints_repo` and `blueprints_ref` in environment config.
- For local development, Terragrunt may map the canonical blueprint source to a sibling checkout with `--source-map`.
- Keep registry configuration valid when `datahive-blueprints` is available only by Git URL.

## Editing Guidance

- Keep environment configuration under `environments/`.
- Keep tenant-owned product configuration under `domains/<domain>/products/<product>/`.
- Do not make CI, Terragrunt, or product onboarding depend on local sibling paths unless the usage is explicitly documented as local-development-only.
- When changing blueprint module inputs, update registry calls and examples together.
