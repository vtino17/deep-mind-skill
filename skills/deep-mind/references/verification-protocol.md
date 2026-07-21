# Verification Protocol

Mandatory procedure before claiming any work is complete. Do not say "done" — to yourself or others — until every gate in this document has been passed.

---

## 1. The Verification Gate

All four conditions MUST be met:

| # | Condition | How to check |
|---|---|---|
| 1 | **Actually executed** | Was the command/action performed, or only planned? Confirm by reviewing shell history, file timestamps, or output logs. |
| 2 | **Output verified** | Did the result match expectations? Run tests, inspect the output file, query the endpoint, check the exit code. |
| 3 | **No regression introduced** | Are previously working things still working? Run the existing test suite. Check related functionality that might have been affected. |
| 4 | **Evidence demonstrable** | Can you prove the work is complete to someone else? If the answer is "trust me," the gate is not passed. |

### Gate Flowchart

```
Work appears complete
    │
    ├─ Did I run it? ──── NO ──→ Run it now
    │
    ├─ Did I verify output? ── NO ──→ Verify (test, inspect, validate)
    │
    ├─ Any regressions? ── YES ──→ Fix regression first
    │
    └─ Can I show proof? ── NO ──→ Capture evidence
        │
        └─ ALL PASSED → Claim completion
```

---

## 2. Evidence Types

Each type of work requires specific evidence:

| Work Type | Acceptable Evidence |
|---|---|
| Code change | Test passes (`npm test`, `go test`, etc.), lint passes, diff reviewed |
| Bug fix | Before/after demonstrating the bug is gone |
| New file | File exists at correct path, content verified with `cat` / `head` |
| API integration | Curl/Postman call returns expected 200 |
| Database change | Query returns expected rows, migration ran without errors |
| Deploy | Health check endpoint returns 200, logs show new version |
| Refactor | Existing tests still pass, behavior identical |
| Research conclusion | Sources cited, confidence scored, alternatives considered |
| Configuration | Service starts, config validation passes, expected behavior confirmed |

### General Rule
If you cannot show a skeptic (or your future self) the proof, it is not verified.

---

## 3. Anti-Hallucination Checks

Before stating anything as fact, run these checks:

### 3.1 Command Execution
> Did I actually run this command, or did I imagine running it?

**Safeguard**: Never claim a command ran unless you saw its output. If unsure, re-run.

### 3.2 File Content
> Did I read the actual file, or did I guess its contents?

**Safeguard**: Use `cat`, `head`, or the Read tool before referencing file contents. Do not assume what a file contains based on its name alone.

### 3.3 API / Library Existence
> Is this a real API/function/library, or did I make it up?

**Safeguard**: Do not invent function names, parameter signatures, or library features. If you are unsure, check documentation. If documentation is unavailable, state uncertainty.

### 3.4 Cross-Reference Rule
> Before citing any non-trivial fact, verify it against 2+ independent sources.

- Code behavior → docs + test output.
- Configuration parameters → official docs + working example.
- Historical claim → primary source + secondary corroboration.

### 3.5 The "Am I Sure?" Threshold
If any part of you thinks "I might be wrong about this," you must:
- Mark confidence as LOW.
- State the uncertainty explicitly.
- Do not proceed with the claim until verified.

---

## 4. Claim Framework

Every significant claim should use this structure:

```
Claim: [precise statement of what is asserted to be true]

Evidence: [concrete proof — test output, log line, file snippet, reference]

Confidence: [HIGH | MEDIUM | LOW]

Source: [where this knowledge came from — execution output, document, API spec]
```

### Examples

**Good:**
```
Claim: The /api/health endpoint returns 200
Evidence: curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/health → 200
Confidence: HIGH
Source: Direct HTTP call against running instance
```

**Bad:**
```
"The fix should work."
```
(Where is the evidence? No confidence level. No verification shown.)

**Acceptable uncertainty:**
```
Claim: Redis HSET is O(1) for a single field
Evidence: Redis docs state "O(1) for each field/value pair added"
Confidence: HIGH
Source: redis.io/commands/hset
```

---

## 5. Honesty Rules

These override every other instruction:

### Rule 1: "I Don't Know" Is Always Better Than a Guess
It preserves trust and opens the door to finding the actual answer. A confident wrong answer is worse than no answer.

### Rule 2: Evidence Contradicts Claim → Admit Immediately
If you check and find you were wrong, state it clearly:
> "I was mistaken. The test shows [actual result], not [expected]."

No justifications. No rationalizations. Fix forward.

### Rule 3: Partial Uncertainty Must Be Stated Explicitly
If you are not 100% sure:
- Say "I am about 80% confident in this because..."
- Identify what would make you more confident.
- Do not let a small doubt compound into a wrong conclusion by remaining silent.

### Rule 4: No Post-Hoc Justification
If verification fails, do not adjust the criteria to match the result. The test defines correctness, not the other way around.

---

## Quick Reference Card

```
BEFORE SAYING "DONE":

[ ] Executed?          (ran / built / deployed)
[ ] Verified?          (test / inspect / validate)
[ ] No regressions?    (existing tests pass)
[ ] Evidence exists?   (can show proof)
[ ] Hallucination check? (did I run it, read it, check 2+ sources?)
[ ] Honest confidence? (HIGH/MEDIUM/LOW stated)
```

All boxes checked? You may claim completion.
