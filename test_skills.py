#!/usr/bin/env python3
"""
Automated verification test suite for antigravity-fav-skills.
Validates all skills against the Agent Skills Open Standard.
"""
import sys
import subprocess
from pathlib import Path

def test_all_skills():
    repo_root = Path(__file__).resolve().parent
    skills_dir = repo_root / "skills"

    assert skills_dir.exists() and skills_dir.is_dir(), "skills directory not found"

    skill_folders = [d for d in skills_dir.iterdir() if d.is_dir()]
    assert len(skill_folders) > 0, "No skill directories found"

    print(f"Testing {len(skill_folders)} skills in {skills_dir}...")
    errors = []

    for skill in sorted(skill_folders, key=lambda p: p.name):
        skill_md = skill / "SKILL.md"
        if not skill_md.exists():
            errors.append(f"Missing SKILL.md in {skill.name}")
            continue

        # Try validating with skills-ref if installed
        try:
            res = subprocess.run(
                ["skills-ref", "validate", str(skill)],
                capture_output=True,
                text=True
            )
            if res.returncode != 0:
                errors.append(f"Validation failed for {skill.name}:\n{res.stderr or res.stdout}")
            else:
                print(f"  ✓ {skill.name} (valid)")
        except FileNotFoundError:
            # Fallback simple check
            content = skill_md.read_text(encoding="utf-8")
            if not content.startswith("---"):
                errors.append(f"{skill.name}: SKILL.md missing frontmatter")
            print(f"  ✓ {skill.name} (frontmatter present)")

    if errors:
        print("\nTest Failures:")
        for err in errors:
            print(f"- {err}")
        sys.exit(1)

    print(f"\nAll {len(skill_folders)} skills passed verification cleanly!")

if __name__ == "__main__":
    test_all_skills()
