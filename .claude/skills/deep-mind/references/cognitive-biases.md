# Cognitive Biases: Guard Checklist

A systematic reference of cognitive biases that distort reasoning. Before finalizing any significant judgment, review this list and check whether bias may have influenced your conclusion.

---

## 1. Confirmation Bias

**The trap**: Seeking or interpreting evidence in a way that confirms your existing hypothesis. Ignoring evidence that contradicts it.

**Guard**: For each conclusion, explicitly ask: "What evidence would disprove this?" Then look for it.

**Example**: You believe the bug is in module A. You find three log entries that *could* point to A. Did you search for entries that exonerate A?

**Checklist**:
- [ ] Searched for counterevidence, not just supporting evidence.
- [ ] Considered at least one alternative hypothesis.
- [ ] Weighed disconfirming evidence honestly.

---

## 2. Anchoring Bias

**The trap**: Over-relying on the first piece of information encountered. Subsequent judgments are adjusted from that anchor, not made independently.

**Guard**: Generate estimates without looking at any reference values first. Only compare after forming your own judgment.

**Example**: First comment on a PR says "this will take 5 days." Every subsequent estimate is now anchored to 5, even if the task is actually 2 hours.

**Checklist**:
- [ ] Formed independent judgment before reviewing others' opinions.
- [ ] Checked if the first data point I saw is distorting my range.
- [ ] Considered extreme possibilities, not just near-anchor adjustments.

---

## 3. Availability Heuristic

**The trap**: Overestimating the likelihood of events that are recent, vivid, or easily recalled. "Plane crashes feel common because they make headlines" — despite driving being far more dangerous.

**Guard**: Base frequency estimates on actual data, not recall ease.

**Example**: "We always hit bugs in deployment" — check the last 10 deployments. Is it actually 8/10 or just the 1 memorable outage?

**Checklist**:
- [ ] Consulted actual frequency data (not memory).
- [ ] Distinguished "memorable" from "common."
- [ ] Considered base rates before making probability claims.

---

## 4. Dunning-Kruger Effect

**The trap**: Low performers overestimate their ability; experts underestimate theirs (because they know what they don't know).

**Guard**: On unfamiliar topics, assume low competence until proven otherwise. Calibrate by testing.

**Example**: After reading one Redis blog post, you think you understand its internals. You don't. The gap is invisible to you.

**Checklist**:
- [ ] Asked "what do I not know about this topic?" (If nothing comes to mind, that's the bias.)
- [ ] Estimated my skill percentile honestly before and after a quick test.
- [ ] Sought external validation of my understanding.

---

## 5. Sunk Cost Fallacy

**The trap**: Continuing a failing course of action because of already-invested time, money, or effort. The investment is irrecoverable — it should not factor into the forward decision.

**Guard**: Ask: "If I were starting fresh today, would I choose this path?" If no, pivot.

**Example**: Three hours debugging a typo because "I've already spent three hours." The right move at hour 1 was to diff the config.

**Checklist**:
- [ ] Separated past investment from future value.
- [ ] Asked the "fresh start" question.
- [ ] Considered switching cost vs. remaining cost honestly.

---

## 6. Overconfidence Effect

**The trap**: Expressing higher confidence than accuracy warrants. "90% sure" should mean 9 out of 10 times you're right. Most people are overconfident at 70%+.

**Guard**: Calibrate by tracking predictions and their outcomes. Build a personal track record.

**Checklist**:
- [ ] Converted "pretty sure" to a specific percentage.
- [ ] Considered what would need to be true for me to be wrong.
- [ ] Avoided extreme statements ("definitely", "impossible") unless provably certain.

---

## 7. Action Bias

**The trap**: Preferring action over inaction, even when the best move is to think, observe, or wait. "Doing something" feels productive; analysis feels like delay.

**Guard**: Distinguish "doing" from "producing." Analysis, verification, and planning are productive work.

**Example**: Immediately rewriting a module instead of understanding why it was written that way. Three days later, you re-introduce the same edge case the original author had solved.

**Checklist**:
- [ ] Paused before coding to understand the problem.
- [ ] Asked: "Is the fastest path to resolution action or analysis right now?"
- [ ] Respected that diagnosis is work, not delay.

---

## Meta-Checklist

Before any final claim or decision, run:

- [ ] **Confirmation** — did I seek disconfirming evidence?
- [ ] **Anchoring** — did a first impression distort my range?
- [ ] **Availability** — am I using data or memorable anecdotes?
- [ ] **Dunning-Kruger** — do I actually know this topic?
- [ ] **Sunk cost** — am I sticking with a bad approach?
- [ ] **Overconfidence** — is my confidence score calibrated?
- [ ] **Action bias** — am I thinking enough before doing?

If any box is unchecked, re-examine before proceeding.
