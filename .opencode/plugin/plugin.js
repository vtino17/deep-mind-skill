// deep-mind — opencode plugin
//
// Intercepts slash commands and natural-language triggers for critical
// thinking, deep reasoning, and verification. Injects the deep-mind
// skill instructions into the system prompt when activated.
//
// Commands:
//   /think-deeper   — Full 5-stage critical reasoning pipeline
//   /critical       — Adversarial review of claims and decisions
//   /verify         — Evidence gate: prove it or flag it
//   /deep-dive      — Root cause analysis with tracing
//   /research       — Structured research with source verification
//   /first-principles — Break down from fundamentals
//   /root-cause     — Trace symptoms to origin
//   /reason         — Step-by-step logical deduction
//   /analisa        — Indonesian: analisa mendalam

import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { readFileSync } from 'node:fs';

const here = dirname(fileURLToPath(import.meta.url));

const DEEP_MIND_SKILL_PATH = join(here, '..', 'skills', 'deep-mind', 'SKILL.md');

const COMMANDS = {
  '/think-deeper': 'Full 5-stage critical reasoning pipeline',
  '/critical': 'Adversarial review of claims and decisions',
  '/verify': 'Evidence gate: prove it or flag it',
  '/deep-dive': 'Root cause analysis with tracing',
  '/research': 'Structured research with source verification',
  '/first-principles': 'Break down from fundamentals',
  '/root-cause': 'Trace symptoms to origin',
  '/reason': 'Step-by-step logical deduction',
  '/analisa': 'Analisa mendalam dalam Bahasa Indonesia',
};

const TRIGGER_PHRASES = [
  'think deeper', 'critical analysis', 'reason about', 'first principles',
  'deep dive', 'analisa mendalam', 'pikir kritis', 'root cause',
  'verify this', 'research this', 'cari tahu', 'deep reasoning',
  'apakah benar', 'prove it', 'tracing through', 'break this down',
  'investigate',
];

function loadSkillContent() {
  try {
    return readFileSync(DEEP_MIND_SKILL_PATH, 'utf8');
  } catch {
    return null;
  }
}

function isCommandMatch(prompt) {
  const trimmed = (prompt || '').trim().toLowerCase();
  for (const [cmd] of Object.entries(COMMANDS)) {
    if (trimmed.startsWith(cmd)) return cmd;
  }
  return null;
}

function isTriggerMatch(prompt) {
  const lower = (prompt || '').toLowerCase();
  for (const phrase of TRIGGER_PHRASES) {
    if (lower.includes(phrase)) return phrase;
  }
  return false;
}

function buildSkillInjection(cmd) {
  const description = cmd
    ? COMMANDS[cmd] || 'Critical thinking and reasoning'
    : 'Critical thinking triggered by natural language';
  return [
    '',
    '--- deep-mind skill activated ---',
    `Trigger: ${cmd || 'natural language'} (${description})`,
    '',
    'Apply the 5-Stage Reasoning Pipeline:',
    '1. VERIFY — Check the request against known facts.',
    '2. GROUND — Anchor every claim to concrete sources.',
    '3. REASON — Step-by-step logical deduction, no leaps.',
    '4. CHALLENGE — Stress-test the conclusion for counter-evidence.',
    '5. DECIDE — Output only what survives all gates.',
    '',
    'Anti-hallucination: Do not fabricate APIs, libraries, or facts.',
    'Evidence gate: Every claim must cite real sources.',
    'Anti-sycophancy: Do not agree reflexively. Disagree professionally.',
    '',
    'If doubt remains: say "I do not know" rather than guess.',
    '--- deep-mind skill end ---',
    '',
  ].join('\n');
}

export const DeepMindPlugin = async () => {
  return {
    'chat.message': async ({ prompt, abort, append }) => {
      const cmd = isCommandMatch(prompt);
      const trigger = cmd || isTriggerMatch(prompt);
      if (!trigger) return;

      const skill = loadSkillContent();
      const injection = buildSkillInjection(cmd);

      if (skill) {
        append.system(skill);
      }
      append.system(injection);
    },
  };
};
