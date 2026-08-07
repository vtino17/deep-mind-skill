import { DeepMindPlugin } from './plugin.js';

const plugin = await DeepMindPlugin();
const appended = [];
const append = { system: (value) => appended.push(value) };

await plugin['chat.message']({ prompt: '/think-deeper verify this', append });
if (appended.length !== 2) throw new Error('expected skill and activation notice');
if (!appended[0].includes('## Core Framework — 8-Stage')) {
  throw new Error('plugin did not load the canonical skill');
}
if (!appended[1].includes('single source of instructions')) {
  throw new Error('activation notice duplicated or omitted the skill contract');
}

appended.length = 0;
await plugin['chat.message']({ prompt: 'hello', append });
if (appended.length !== 0) throw new Error('non-trigger prompt activated the skill');
