# Lab 019 — Incident Response Case File and Evidence Bundle

## Objective

The objective of this lab is to build a local incident response case file and evidence bundle using synthetic events.

This lab teaches:

- incident response case structure
- evidence indexing
- triage checklist
- local timeline reconstruction
- finding classification
- containment notes
- lessons learned
- final report generation
- safe evidence packaging
- analyst-style documentation

This lab follows naturally from Lab 018, where synthetic SIEM-style events were generated and analyzed.

## Safety boundary

This lab is defensive, local and synthetic.

It does not collect real logs, does not inspect private user files, does not scan systems and does not interact with unauthorized infrastructure.

All case data is fake and generated for learning.

## Why incident response documentation matters

Detection is only part of security work. After a finding appears, an analyst must document:

```text
what happened
when it happened
what evidence supports it
what systems were involved
what severity it has
what containment actions are appropriate
what lessons were learned
```

This lab turns synthetic SIEM-style findings into an incident response case.

## Files

This lab adds:

```text
incident_response/lab019/CASE_FILE.md
incident_response/lab019/TRIAGE_CHECKLIST.md
incident_response/lab019/EVIDENCE_INDEX.md
incident_response/lab019/CONTAINMENT_NOTES.md
incident_response/lab019/LESSONS_LEARNED.md
data/lab019/ir_case_events.jsonl
data/lab019/ir_case_metadata.json
scripts/ir_lab019_generate_case_events.py
scripts/ir_lab019_analyze_case.py
scripts/ir_lab019_build_case_bundle.sh
scripts/ir_lab019_create_final_report.sh
scripts/ir_lab019_run_workflow.sh
```

## Scenario

The synthetic case simulates a local lab service that produced:

```text
successful status checks
multiple authentication failures
multiple unknown paths
controlled backend errors
an administrative event review
normal Prometheus scrape events
```

The scenario is intentionally local and controlled.

## Step 1 — Generate synthetic case events

```bash
./scripts/ir_lab019_generate_case_events.py
```

Expected output:

```text
[OK] Generated incident response case events:
~/linux_lab/lab019_ir_case/events/ir_case_events.jsonl
```

## Step 2 — Analyze the case

```bash
./scripts/ir_lab019_analyze_case.py
```

This analyzes the repository sample case:

```text
data/lab019/ir_case_events.jsonl
```

To analyze the generated case:

```bash
./scripts/ir_lab019_analyze_case.py ~/linux_lab/lab019_ir_case/events/ir_case_events.jsonl
```

## Step 3 — Build evidence bundle

```bash
./scripts/ir_lab019_build_case_bundle.sh
```

Expected output:

```text
[OK] Evidence bundle created:
~/linux_lab/lab019_ir_case/bundles/ir_case_bundle_YYYYMMDD_HHMMSS
```

The bundle includes:

```text
events
metadata
case file
triage checklist
evidence index
containment notes
lessons learned
analysis output
```

## Step 4 — Create final report

```bash
./scripts/ir_lab019_create_final_report.sh
```

Expected output:

```text
[OK] Final incident response report created:
~/linux_lab/reports/ir_lab019_final_report_YYYYMMDD_HHMMSS.txt
```

## Step 5 — Run full workflow

```bash
./scripts/ir_lab019_run_workflow.sh
```

This runs:

```text
case event generation
case analysis
evidence bundle creation
final report generation
```

## Incident response phases

This lab uses a simplified incident response model:

```text
Preparation
Identification
Triage
Containment
Eradication
Recovery
Lessons learned
```

Because this is a local synthetic lab, eradication and recovery are documented conceptually rather than performed against real systems.

## Evidence handling

Evidence should be:

```text
identified
indexed
timestamped
kept local
reviewed before publication
not mixed with private user data
```

## Defensive interpretation

The synthetic findings may look like an attack pattern, but in this lab they are generated intentionally.

The correct analyst conclusion is:

```text
The local service produced suspicious-looking patterns under controlled lab conditions.
The event sequence is useful for practicing evidence handling and response documentation.
No real external incident occurred.
```

## Common issues

### Python not found

Check:

```bash
python3 --version
```

### Report contains local paths

This is expected. Review generated reports before committing or publishing.

### Bundle missing generated events

Run:

```bash
./scripts/ir_lab019_generate_case_events.py
```

### Evidence should not be committed automatically

Generated evidence bundles are created under:

```text
~/linux_lab/lab019_ir_case/
```

They are not committed by the patch.

## Final conclusion

The core chain is:

```text
synthetic case events
-> analysis
-> case file
-> evidence index
-> bundle
-> final report
-> lessons learned
```

This lab adds a professional incident response documentation layer to the repository.
