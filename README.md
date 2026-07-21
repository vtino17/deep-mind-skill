# deep-mind 🧠 — Critical Thinking Engine for AI Coding Agents

<p align="center">
  <img src="https://img.shields.io/github/stars/vtino17/deep-mind-skill?style=flat-square&label=Stars&color=ffd700" alt="Stars">
  <img src="https://img.shields.io/github/license/vtino17/deep-mind-skill?style=flat-square&label=License&color=blue" alt="License">
  <img src="https://img.shields.io/badge/agents-11%2B-brightgreen?style=flat-square" alt="Agents">
  <img src="https://img.shields.io/badge/mode-caveman-important?style=flat-square" alt="Caveman Mode">
  <img src="https://img.shields.io/badge/hallucination-no-red?style=flat-square" alt="No Hallucination">
</p>

---

> **Makes AI agents think critically, reason deeply, and act with integrity.**  
> No hallucination. No excuses. No sycophancy.

`deep-mind` is a skill pack for AI coding agents (Claude Code, Codex, Cursor, and others) that installs a rigorous **critical-thinking pipeline** before every task execution. It forces agents to verify claims, question assumptions, check evidence, and produce only what they can prove.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🧠 **5-Stage Reasoning** | Verify → Ground → Reason → Challenge → Decide |
| 🚫 **Anti-Hallucination** | Blocks fabricated code, fake APIs, and imaginary libraries |
| 🔍 **Evidence Gate** | Every claim must cite real files, docs, or runtime output |
| 🙅 **Anti-Sycophancy** | Rejects user flattery and leading suggestions — tells the truth |
| 🏛️ **Integrity Core** | Refuses to cut corners, skip tests, or silence warnings |
| 📦 **Zero Dependencies** | Pure markdown skill — nothing to `pip install` or `npm i` |
| 🌐 **Agent-Agnostic** | Works with Claude Code, Codex, Cursor, Windsurf, Aider, and more |
| ⚡ **Caveman Mode** | Ultra-compressed output — 65% less token waste |
| 🔄 **Self-Audit** | After each task, reviews own output for correctness |
| 🌏 **Bilingual** | English primary, with Indonesian support for lokal |

---

## 🚀 Quick Install

### One-liner (bash)

```bash
git clone https://github.com/vtino17/deep-mind-skill.git ~/.agents/skills/deep-mind
```

### One-liner (PowerShell)

```powershell
git clone https://github.com/vtino17/deep-mind-skill.git "$env:USERPROFILE\.agents\skills\deep-mind"
```

---

## 🛠️ Interactive Installer

### Bash

```bash
bash <(curl -sL https://raw.githubusercontent.com/vtino17/deep-mind-skill/main/install.sh)
```

### PowerShell

```powershell
iwr -useb https://raw.githubusercontent.com/vtino17/deep-mind-skill/main/install.ps1 | iex
```

---

## 📋 Manual Install

1. Clone the repo into your agent skills directory:

   ```bash
   git clone https://github.com/vtino17/deep-mind-skill.git
   ```

2. Copy the skill file to your agent's skills folder:

   | Agent | Path |
   |---|---|
   | Claude Code | `~/.claude/skills/deep-mind/` |
   | Codex CLI | `~/.codex/skills/deep-mind/` |
   | Cursor | `.cursor/skills/deep-mind/` |
   | Windsurf | `~/.windsurf/skills/deep-mind/` |
   | Aider | `~/.aider/skills/deep-mind/` |

3. Activate the skill in your agent config. Refer to your agent's docs for the exact config key.

   Example for Claude Code — add to `~/.claude/settings.json`:

   ```json
   {
     "skills": ["deep-mind"]
   }
   ```

4. Restart your agent session. deep-mind loads automatically on next task.

---

## ❌ Uninstall

### Bash

```bash
rm -rf ~/.agents/skills/deep-mind
```

### PowerShell

```powershell
Remove-Item -Recurse -Force "$env:USERPROFILE\.agents\skills\deep-mind"
```

Then remove the `deep-mind` entry from your agent's skill configuration file.

---

## 🧩 How It Works — 5-Stage Reasoning Pipeline

Every time your agent receives a task, deep-mind intercepts and runs it through five stages:

```
 ┌─────────────┐
 │  1. VERIFY  │  Check the request against known facts.
 │             │  "Does this package exist? Is this API real?"
 └──────┬──────┘
        ↓
 ┌─────────────┐
 │  2. GROUND  │  Anchor every claim to concrete sources.
 │             │  "Cite the file, the docs, or the runtime."
 └──────┬──────┘
        ↓
 ┌─────────────┐
 │  3. REASON  │  Step-by-step logical deduction.
 │             │  No leaps. No assumptions.
 └──────┬──────┘
        ↓
 ┌─────────────┐
 │  4. CHALLENGE│  Stress-test the conclusion.
 │             │  "What if this is wrong? What's the counter-evidence?"
 └──────┬──────┘
        ↓
 ┌─────────────┐
 │  5. DECIDE  │  Output only what survives all gates.
 │             │  If doubt remains → say "I don't know."
 └─────────────┘
```

If any stage fails, the agent reports the gap instead of guessing.

---

## 🤖 Supported AI Agents

deep-mind works with any agent that supports skill/instruction injection. Tested on:

| Agent | Status |
|---|---|
| **Claude Code** (Anthropic) | ✅ Full support |
| **Codex CLI** (OpenAI) | ✅ Full support |
| **Cursor** | ✅ Full support |
| **Windsurf** | ✅ Full support |
| **Aider** | ✅ Full support |
| **Cline** | ✅ Full support |
| **Continue** | ✅ Full support |
| **Roo Code** | ✅ Full support |
| **Gemini CLI** (Google) | ✅ Supported |
| **Copilot CLI** (GitHub) | ✅ Supported |
| **Augment** | ✅ Supported |
| **Any Agent Skills–compatible agent** | ✅ Should work |

---

## 📸 Demo

```
> Coming soon — terminal recording showing deep-mind blocking a hallucinated
  API call and demanding evidence before generating code.
```

---

## 👨‍💻 Contributing

Contributions are welcome. A few ground rules:

1. **No fluff** — every line must add signal. Readability > cleverness.
2. **No sycophancy** — reviews must be honest, not nice.
3. **Test it** — run the skill against a real agent before submitting a PR.
4. **Keep it agent-agnostic** — avoid agent-specific hacks.

**PR process:**

1. Fork the repo
2. Create a feature branch (`git checkout -b feat/my-idea`)
3. Commit your changes (`git commit -m 'feat: add ...'`)
4. Push (`git push origin feat/my-idea`)
5. Open a Pull Request

---

## 📄 License

MIT © 2026 [Valentino Saputra](https://github.com/vtino17)

---

## 👤 Author

**Valentino Saputra** — _vtino17_  
📍 Sungailiat, Bangka Belitung, Indonesia  
🔗 [GitHub](https://github.com/vtino17)  

> _Network Engineering · Cybersecurity · AI · IoT_  
> _Bikin AI agent jadi mikir dulu sebelum ngomong._  
> _(Making AI agents think before they speak.)_
