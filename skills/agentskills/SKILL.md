---
name: agentskills
description: Official Agent Skills open format specification and tooling. Use when creating, authoring, auditing, optimizing descriptions for, or validating Agent Skills using the skills-ref reference CLI.
metadata:
  repository: https://github.com/agentskills/agentskills
  standard: Agent Skills Open Standard
---

# Agent Skills Open Standard

The Agent Skills standard is an open, portable, and client-neutral format for packaging domain knowledge, multi-step procedures, and scripts for AI agents. Antigravity discovers and executes skills following this specification.

## Core Structure

A skill directory must follow this layout:

```text
<skill-name>/
├── SKILL.md          # Required: Frontmatter metadata + procedural instructions
├── scripts/          # Optional: Executable automation scripts
├── references/       # Optional: In-depth documentation & domain references
└── assets/           # Optional: Templates, prompts, and static resources
```

## `SKILL.md` Specifications

The `SKILL.md` file must contain YAML frontmatter followed by Markdown content:

### Frontmatter Fields

- **`name`** (required): 1–64 characters. Lowercase alphanumeric and hyphens only (`a-z`, `0-9`, `-`). Must not start/end with hyphens or have consecutive hyphens (`--`). Must match the parent directory name.
- **`description`** (required): 1–1024 characters. Clear description of what the skill does and specific triggers for when the agent should activate it.
- **`license`** (optional): License identifier or reference.
- **`compatibility`** (optional): Max 500 characters describing environment requirements (packages, network, OS).
- **`metadata`** (optional): Key-value dictionary for versioning, authorship, or tags.
- **`allowed-tools`** (optional): Space-separated list of allowed tools.

## Validation & Tooling

The reference implementation CLI `skills-ref` is installed locally on the system.

### Common Commands

- **Validate a skill directory:**
  ```bash
  skills-ref validate <path/to/skill>
  ```
  Or run the helper script: [validate-skill.sh](./scripts/validate-skill.sh) `<path/to/skill>`

- **Inspect skill properties:**
  ```bash
  skills-ref read-properties <path/to/skill>
  ```

- **Generate prompt XML block:**
  ```bash
  skills-ref to-prompt <path/to/skill-1> <path/to/skill-2>
  ```

## Reference Documentation

- [Full Specification](./references/specification.md): Complete formal rules for directory structure, frontmatter, and skill execution.
- [Best Practices](./references/best-practices.md): Designing concise runbooks, validation steps, and progressive disclosure.
- [Optimizing Descriptions](./references/optimizing-descriptions.md): Crafting trigger-rich descriptions for high activation precision.
- [Evaluating Skills](./references/evaluating-skills.md): Testing and benchmarking skill discovery and invocation across models.
- [Using Scripts](./references/using-scripts.md): Packaging deterministic executable code and tools within skills.
- [Adding Skills Support](./references/adding-skills-support.md): Client-side skill discovery and activation pipelines.
