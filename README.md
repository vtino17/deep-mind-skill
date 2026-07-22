# deep-mind — Critical Thinking Engine for AI Coding Agents

[![Stars](https://img.shields.io/github/stars/vtino17/deep-mind-skill?style=flat-square&label=Stars&color=ffd700)](https://github.com/vtino17/deep-mind-skill/stargazers)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![Agents](https://img.shields.io/badge/agents-12%2B-brightgreen?style=flat-square)]()
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
- `/think-deeper <question>` — Full 5-stage reasoning
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
[DEEP-MIND] Applying 5-stage reasoning...

1. VERIFY — Port 443 open means HTTPS service running
2. GROUND — Nmap scan result: 443/tcp open https
3. REASON — HTTPS requires TLS certificate + web server
4. CHALLENGE — Could be non-HTTP service masquerading on 443
5. DECIDE — Confirmed: TLS handshake successful, subject: *.example.com
```

## Features

- 5-Stage Reasoning: VERIFY, GROUND, REASON, CHALLENGE, DECIDE
- Anti-Hallucination: Blocks fabricated code and imaginary APIs
- Evidence Gate: Every claim must cite real sources
- Anti-Sycophancy: Rejects user flattery, tells the truth
- Zero Dependencies: Pure markdown, no pip/npm install needed
- Agent-Agnostic: Works with Claude Code, Codex, Cursor, Windsurf, Aider, Cline, Continue, Roo Code, Gemini CLI, Copilot CLI, OpenCode
- Plugin support: OpenCode slash commands

## How It Works

Every time your agent receives a task, deep-mind intercepts and runs it through five stages:

```
1. VERIFY     Check the request against known facts
2. GROUND     Anchor every claim to concrete sources
3. REASON     Step-by-step logical deduction
4. CHALLENGE  Stress-test with counter-evidence
5. DECIDE     Output only what survives all gates
```

If any stage fails, the agent reports the gap instead of guessing.

## Supported AI Agents

| Agent | Status | Commands |
|-------|--------|----------|
| Claude Code | Full | /think-deeper, /critical, /verify |
| Codex CLI | Full | @deep-mind |
| Cursor | Full | /think-deeper |
| OpenCode | Full | /think-deeper, /critical, /verify |
| Windsurf | Full | Manual skill reference |
| Gemini CLI | Full | Manual skill reference |
| Copilot CLI | Supported | AGENTS.md reference |
| Cline, Continue, Aider, Roo Code | Supported | Manual skill reference |

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
