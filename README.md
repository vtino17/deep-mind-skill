# deep-mind — Critical Thinking Engine for AI Coding Agents

[![Stars](https://img.shields.io/github/stars/vtino17/deep-mind-skill?style=flat-square&label=Stars&color=ffd700)](https://github.com/vtino17/deep-mind-skill/stargazers)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![Agents](https://img.shields.io/badge/packaging-multi--agent-brightgreen?style=flat-square)]()
[![Install](https://img.shields.io/badge/install-npx%20skills-8A2BE2?style=flat-square)]()
[![OpenCode](https://img.shields.io/badge/OpenCode-plugin-purple?style=flat-square)]()

Makes AI coding agents think critically, reason deeply, and act with integrity. No hallucination. No excuses. No sycophancy.

## Quick Install

```bash
npx skills add vtino17/deep-mind-skill
```

For Claude Code:

```bash
/plugin marketplace add vtino17/deep-mind-skill
```

## Usage

Once installed, just include any of these in your prompt:

**Commands:**
- `/think-deeper <question>` — Full 8-stage reasoning
- `/critical <claim>` — Adversarial review
- `/verify <statement>` — Evidence gate
- `/deep-dive <problem>` — Root cause analysis
- `/first-principles <concept>` — Break down from fundamentals

**Natural language:**
- "think deeper: why does this keep failing?"
- "critical analysis: is this architecture correct?"
- "verify: does this library support Python 3.13?"

## Demo

```
User: /think-deeper why is port 443 open on 10.0.0.1?

Agent:
[DEEP-MIND] Applying the reasoning pipeline...

1. VERIFY — Port 443 open means HTTPS service running
2. GROUND — Nmap scan result: 443/tcp open https
3. REASON — HTTPS requires TLS certificate + web server
4. CHALLENGE — Could be non-HTTP service masquerading on 443
5. DECIDE — Confirmed: TLS handshake successful, subject: *.example.com
```

## Features

- 8-Stage Reasoning: research, clarify, deconstruct, analyze, synthesize, verify, self-correct, challenge
- Anti-Hallucination: Blocks fabricated code and imaginary APIs
- Evidence Gate: Every claim must cite real sources
- Anti-Sycophancy: Rejects user flattery, tells the truth
- Zero Dependencies: Pure markdown, no pip/npm install needed
- Agent-Agnostic: Works with Claude Code, Codex, Cursor, Windsurf, Aider, Cline, Continue, Roo Code, Gemini CLI, Copilot CLI, OpenCode
- Plugin support: OpenCode slash commands

## How It Works

When the skill is selected, it applies eight stages:

```
0. RESEARCH      Verify uncertain and time-sensitive facts
1. CLARIFY       Bound the request and expose assumptions
2. DECONSTRUCT   Split the problem into testable parts
3. ANALYZE       Compare evidence, risks, and alternatives
4. SYNTHESIZE    Build a coherent answer from verified parts
5. VERIFY        Test claims, outputs, and edge cases
6. SELF-CORRECT  Review and repair material weaknesses
7. CHALLENGE     Apply the strongest credible counterargument
```

If any stage fails, the agent reports the gap instead of guessing.

## Supported AI Agents

| Agent | Distribution included | Invocation |
|-------|-----------------------|------------|
| Claude Code | Yes | Skill or slash commands |
| Cursor | Yes | Skill reference |
| OpenCode | Yes | Plugin commands and skill reference |
| Codex CLI | Generic skill copy | Skill reference |
| Windsurf, Copilot CLI, Cline, Continue, Aider, Roo Code | Installer target | Manual skill reference; verify against the installed agent version |

Packaging support does not guarantee identical runtime behavior across agents.

## Repositories

| Repo | Stars | Description |
|------|-------|-------------|
| [kage](https://github.com/vtino17/kage) | AI-powered security scanner |
| [tools](https://github.com/vtino17/tools) | 85+ penetration testing tools |
| [taskcapsule](https://github.com/vtino17/taskcapsule) | Task context manager |
| [network-security-lab](https://github.com/vtino17/network-security-lab) | Enterprise network security lab |
| [mikrotik-hardening](https://github.com/vtino17/mikrotik-hardening) | RouterOS security configs |
| [incident-response-playbooks](https://github.com/vtino17/incident-response-playbooks) | IR playbooks and scripts |
| [vuln-scanner](https://github.com/vtino17/vuln-scanner) | Vulnerability scanner |
| [pcap-forensics](https://github.com/vtino17/pcap-forensics) | PCAP analysis tool |
| [network-automation-toolkit](https://github.com/vtino17/network-automation-toolkit) | Multi-vendor automation |

## License

MIT — use, modify, share freely.
