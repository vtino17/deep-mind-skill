# Deep Reasoning Framework

A structured methodology for rigorous analytical thinking. Apply these techniques when solving complex problems, debugging systems, or evaluating trade-offs.

---

## 1. First Principles Thinking

### What It Is
Breaking down a problem into its most fundamental, undeniable truths, then reasoning upward from those foundations. Instead of relying on analogy ("this is how others do it"), you ask "what is the physical/mathematical/logical minimum I need to solve this?"

### How To Apply
1. **Identify assumptions** — list every taken-for-granted belief about the problem.
2. **Strip them away** — discard convention, habit, and "everyone knows."
3. **Rebuild from fundamentals** — construct a solution using only verified truths.

### Example
Bad: "How do I optimize this SQL query?"  
Good: "What is the minimal data I actually need? What is the fastest way to retrieve only that?"  
First principles: data lives on disk >> sequential scan is O(n) >> index is O(log n). Start with the index.

### Pitfalls
- First principles take cognitive effort (System 2). Default is to analogize.
- You can strip away too much — some conventions exist for good reason (safety, compatibility).

---

## 2. Root Cause Analysis

### The 5 Whys
Ask "why" repeatedly until you reach the underlying system failure, not the human error. The real root cause is usually a process gap, not a person.

### Example Chain
1. Production went down. *Why?* → Config change pushed without review.
2. Why was config pushed without review? → CI gate was optional.
3. Why was the gate optional? → Team was in a hurry to ship feature X.
4. Why was the team in a hurry? → Deadline was unrealistic.
5. Why was the deadline unrealistic? → Estimation did not account for testing overhead.

**Root cause**: Estimation process lacks testing buffer.  
**Symptom treatment**: Revert the config change.  
**Actual fix**: Update estimation template to always include a testing/QA multiplier.

### Causal Chain Mapping
Draw cause→effect edges. A single symptom may have 3-4 parallel causal chains. The root cause is the node with the most outgoing edges (highest leverage fix).

### Symptom vs Root Cause
| Symptom | Root Cause |
|---|---|
| Error 500 on checkout | Null pointer in payment service |
| High memory usage | Unbounded cache with no eviction policy |
| Slow page loads | N+1 queries in ORM |
| Team misses sprints | No task breakdown before estimation |

If fixing it once doesn't prevent recurrence, you treated a symptom.

---

## 3. MECE Principle (Mutually Exclusive, Collectively Exhaustive)

### Definition
A categorization framework from McKinsey. Problem components should:
- **Mutually Exclusive** — no overlap between categories.
- **Collectively Exhaustive** — every possibility fits somewhere.

### How to Apply
When breaking down any problem:
1. Brainstorm all possible categories.
2. Check for overlap — merge or redefine where categories intersect.
3. Check for gaps — is there a case that fits nowhere? Add it.

### Example
Decomposing "slow API":
- **Client-side** (network latency, browser rendering)
- **Server-side** (business logic, DB queries)
- **Infrastructure** (load balancer, CDN, DNS)

These are MECE: no overlap, and every source of slowness belongs to one.

### Why It Matters
Non-MECE thinking creates blind spots and double-counts. You either miss a cause or spend twice the effort on one.

---

## 4. Occam's Razor

### The Principle
Among competing explanations, prefer the one with the fewest assumptions. Not the simplest *sounding* — the simplest in terms of entities and ad-hoc hypotheses.

### Nuance
- **Law of parsimony** ≠ "always the simplest answer." The simplest explanation that covers all observed evidence is preferred.
- When new evidence contradicts the simple model, complexity is justified.

### Applied to Debugging
- "A single config typo" is better than "random cosmic ray flipped a bit AND a race condition hid it" — until you have evidence for both.

### Anti-Pattern
Oversimplifying to the point of being wrong. Occam shaves unnecessary assumptions, not necessary ones.

---

## 5. Inversion Thinking

### The Technique
Instead of asking "how do I achieve X?", ask "what would guarantee failure?" Then avoid those things.

### Forms
| Forward | Inverted |
|---|---|
| How to secure this API? | What would make it trivially hackable? |
| How to ship on time? | What would guarantee a missed deadline? |
| How to write clean code? | What makes code unmaintainable? |

### Why It Works
The human brain is better at avoiding threats than pursuing abstract goals. Inversion surfaces concrete failure modes you can act on immediately.

### Work Backwards From Desired Outcome
1. Define the ideal outcome unambiguously.
2. Trace backwards: "What must be true immediately before the outcome?"
3. Repeat until you reach the present moment.

This produces a chain of intermediate conditions, each a checkpoint you can verify.

---

## 6. Feedback Loops & Bayesian Updating

### Core Idea
No analysis is final. Every piece of new evidence updates your confidence in each hypothesis.

### Bayesian Mental Model
- **Prior** — your confidence before seeing evidence.
- **Likelihood** — how probable is this evidence under each hypothesis?
- **Posterior** — updated confidence after evidence.

### In Practice
```
P(hypothesis | evidence) = P(evidence | hypothesis) * P(hypothesis) / P(evidence)
```

You don't need to calculate. Just ask:
- "If my hypothesis were true, how likely is this evidence?"
- "If my hypothesis were false, how likely is this evidence?"
- Update accordingly.

### Example
You believe service A causes the crash (prior 70%). New evidence: service A logs show clean exit. That evidence is very unlikely if A caused the crash, very likely if something else did. Update prior downward to ~20%.

### Principles
- Extraordinary claims require extraordinary evidence.
- A single piece of strong evidence beats many weak ones.
- Non-falsifiable claims have zero value.

---

## 7. Cognitive Model: System 1 vs System 2

### Daniel Kahneman's Framework

| System 1 (Fast) | System 2 (Slow) |
|---|---|
| Automatic, intuitive | Deliberate, analytical |
| Low effort | High effort |
| Pattern matching | Logic chains |
| Prone to bias | More reliable |
| Default mode | Requires activation |

### Instructions for Engaging System 2
When the task is complex, do NOT trust the first answer. Instead:

1. **State the problem explicitly** in writing. Reformulating forces precision.
2. **List 2-3 candidate approaches** before choosing one.
3. **Play devil's advocate** — write the counterargument to your own solution.
4. **Check your confidence** — if it feels too easy, you're probably missing something.
5. **Force a delay** — if time allows, step away and revisit.

### When to Use Each
- **System 1**: routine tasks, known patterns, non-critical decisions.
- **System 2**: novel problems, high stakes, contradictory evidence, trade-off analysis.

The skill is knowing which mode is active and switching deliberately.
