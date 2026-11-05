# Antigravity Favorite Skills

A curated, battle-tested collection of **35 essential skills** for **Antigravity** and any AI coding assistant implementing the [Agent Skills Open Standard](https://agentskills.io).

---

## Quick Install

### 1. One-Liner (macOS & Linux)
```bash
git clone https://github.com/Vamshidathrika/antigravity-fav-skills.git
cd antigravity-fav-skills
./install.sh
```

### 2. Windows
```cmd
git clone https://github.com/Vamshidathrika/antigravity-fav-skills.git
cd antigravity-fav-skills
install.bat
```

### 3. Manual Installation
Copy the directories inside `skills/` directly to your global Antigravity skills directory:
- **macOS / Linux**: `~/.gemini/config/skills/`
- **Windows**: `%USERPROFILE%\.gemini\config\skills\`

Antigravity uses **Progressive Disclosure** and will automatically index and load skills on-demand.

---

## Included Skills

### Agent Architecture, Loops & Evals
| Skill | Description |
| :--- | :--- |
| **`agentskills`** | Official open format specification, reference docs, and `skills-ref` CLI integration. |
| **`agent-harness-construction`** | Designing and optimizing AI agent action spaces, tool schemas, and observation formatting. |
| **`agent-introspection-debugging`** | Systematic self-debugging, root-cause diagnosis, and recovery workflows for agent failures. |
| **`agent-eval`** | Head-to-head benchmarking of coding agents on custom tasks with pass rate, cost, and time metrics. |
| **`continuous-agent-loop`** | Robust autonomous loops with quality gates, evals, and self-healing controls. |
| **`team-agent-orchestration`** | Squad-based multi-agent orchestration with work units, ownership, and merge gates. |
| **`council`** | Structured multi-perspective council for ambiguous architectural and engineering decisions. |

### Testing, TDD & Verification
| Skill | Description |
| :--- | :--- |
| **`tdd-workflow`** | Test-driven development enforcement ensuring 80%+ test coverage across unit, integration, and E2E. |
| **`all-in-one-testing`** | Comprehensive testing strategies (Smoke, Unit, Integration, Regression, and Playwright E2E). |
| **`browser-qa`** | Automated browser visual testing and UI interaction verification. |
| **`e2e-testing`** | Production Playwright patterns with Page Object Models, zero-flake fixtures, and artifact tracing. |
| **`canary-watch`** | Post-deploy smoke testing and regression verification on live endpoints and SSE streams. |
| **`verification-loop`** | Rigorous verification loop for agent sessions before claiming completion. |

### Design, UI & Motion
| Skill | Description |
| :--- | :--- |
| **`hallmark`** | Anti-AI-slop design system for distinctive, non-generic typography, layouts, and aesthetics. |
| **`high-end-visual-design`** | High-end visual craft: custom spacing scales, refined borders, shadows, and luxury finishes. |
| **`minimalist-ui`** | Clean editorial interfaces, warm monochrome palettes, typographic contrast, and flat bento grids. |
| **`design-system`** | Generating and auditing component tokens, color hierarchies, and visual consistency. |
| **`motion-ui`** | Production-ready motion design and micro-interactions for modern web apps. |
| **`12-principles-of-animation`** | Auditing and implementing animation against the classic 12 principles adapted for UI. |
| **`css-animations`** | Deterministic CSS keyframe timing and animation adapter patterns. |

### Full-Stack, Backend & Databases
| Skill | Description |
| :--- | :--- |
| **`backend-patterns`** | Node.js, Express, and Next.js server-side best practices, data access, and API design. |
| **`frontend-patterns`** | React and Next.js state management, render optimizations, and component architecture. |
| **`api-design`** | Production RESTful API patterns: idempotency, filtering, pagination, and error envelopes. |
| **`postgres-patterns`** | PostgreSQL query optimization, schema indexing, transactions, and security best practices. |
| **`neon-postgres`** | Serverless Postgres patterns, branching workflows, pooling, and serverless drivers. |
| **`nextjs-turbopack`** | Next.js incremental bundling, filesystem caching, and performance optimizations. |

### Video & Media Production
| Skill | Description |
| :--- | :--- |
| **`remotion`** | React-based programmatic video creation, transitions, and shared timeline components. |
| **`remotion-best-practices`** | Performance optimization and best practices for rendering Remotion compositions. |
| **`ffmpeg`** | Video and audio transcoding, compression, audio extraction, and asset preparation. |
| **`video-toolkit`** | Autonomous explainer video generation with voiceover, images, and audio composition. |
| **`demo-video`** | Automated generation of walkthroughs, feature showcases, and product demos. |
| **`ui-demo`** | High-fidelity screen recording and interaction demonstrations using browser automation. |

### Growth, Marketing & Content
| Skill | Description |
| :--- | :--- |
| **`content-engine`** | Platform-native content adaptation across multiple communication channels. |
| **`seo`** | Technical SEO audits, Core Web Vitals, JSON-LD structured data, and keyword architecture. |
| **`gtm-strategy`** | Go-to-market planning, channel prioritization, and messaging framework design. |

---

## Validation & Testing

Every skill in this repository is strictly validated against the official Agent Skills specification:

```bash
# Validate all skills
python3 test_skills.py
```

## License

Apache-2.0. Individual skills may define specific licenses within their `SKILL.md` frontmatter.
