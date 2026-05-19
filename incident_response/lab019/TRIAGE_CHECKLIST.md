# Triage Checklist — Lab 019

## Initial triage

- [ ] Confirm case is synthetic/local.
- [ ] Confirm no real credentials are present.
- [ ] Confirm event source file path.
- [ ] Confirm event count.
- [ ] Confirm time range.
- [ ] Identify event types.
- [ ] Identify status code distribution.
- [ ] Identify sources.
- [ ] Identify high-signal patterns.
- [ ] Build timeline.

## Evidence review

- [ ] Review raw JSONL events.
- [ ] Review metadata.
- [ ] Review analysis output.
- [ ] Review timeline.
- [ ] Review final report.

## Containment reasoning

- [ ] If this were real, identify exposed service.
- [ ] If this were real, verify authentication layer.
- [ ] If this were real, check reverse proxy logs.
- [ ] If this were real, check API logs.
- [ ] If this were real, check metrics and alert state.
- [ ] If this were real, preserve evidence before cleanup.

## Publication safety

- [ ] Do not commit private real logs.
- [ ] Do not commit credentials.
- [ ] Review generated reports before publishing.
- [ ] Keep synthetic case data clearly labeled.
