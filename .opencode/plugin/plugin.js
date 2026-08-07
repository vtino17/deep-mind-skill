// deep-mind — opencode plugin
//
// Intercepts slash commands and natural-language triggers for critical
// thinking, deep reasoning, and verification. Injects the deep-mind
// skill instructions into the system prompt when activated.
//
// Commands:
//   /think-deeper   — Full 8-stage critical reasoning pipeline
//   /critical       — Adversarial review of claims and decisions
//   /verify         — Evidence gate: prove it or flag it
//   /deep-dive      — Root cause analysis with tracing
//   /research       — Structured research with source verification
//   /first-principles — Break down from fundamentals
//   /root-cause     — Trace symptoms to origin
//   /reason         — Step-by-step logical deduction

import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { readFileSync } from 'node:fs';

const here = dirname(fileURLToPath(import.meta.url));

const DEEP_MIND_SKILL_PATH = join(here, '..', 'skills', 'deep-mind', 'SKILL.md');

const COMMANDS = {
  '/think-deeper': 'Full 8-stage critical reasoning pipeline',
  '/critical': 'Adversarial review of claims and decisions',
  '/verify': 'Evidence gate: prove it or flag it',
  '/deep-dive': 'Root cause analysis with tracing',
  '/research': 'Structured research with source verification',
  '/first-principles': 'Break down from fundamentals',
  '/root-cause': 'Trace symptoms to origin',
  '/reason': 'Step-by-step logical deduction',
};

const TRIGGER_PHRASES = [
  'think deeper', 'critical analysis', 'reason about', 'first principles',
  'deep dive', 'root cause', 'verify this', 'research this',
  'deep reasoning', 'prove it', 'tracing through', 'break this down',
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

function buildActivationNotice(cmd) {
  const description = cmd
    ? COMMANDS[cmd] || 'Critical thinking and reasoning'
    : 'Critical thinking triggered by natural language';
  return [
    '',
    '--- deep-mind skill activated ---',
    `Trigger: ${cmd || 'natural language'} (${description})`,
    '',
    'Follow the loaded deep-mind SKILL.md as the single source of instructions.',
    '--- deep-mind skill end ---',
    '',
  ].join('\n');
}

export const DeepMindPlugin = async () => {
  return {
    'chat.message': async ({ prompt, append }) => {
      const cmd = isCommandMatch(prompt);
      const trigger = cmd || isTriggerMatch(prompt);
      if (!trigger) return;

      const skill = loadSkillContent();
      const notice = buildActivationNotice(cmd);

      if (skill) {
        append.system(skill);
      } else {
        append.system('deep-mind activation failed: SKILL.md could not be loaded.');
      }
      append.system(notice);
    },
  };
};
