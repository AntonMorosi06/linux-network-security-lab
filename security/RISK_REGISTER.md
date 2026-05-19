# Risk Register

| ID | Risk | Impact | Likelihood | Severity | Current controls | Recommended mitigation | Evidence | Status |
|---|---|---:|---:|---:|---|---|---|---|
| R-001 | Local API accidentally exposed beyond localhost | High | Low | Medium | Local bind examples, docs | Inspect listening ports before demos | security_check_local_exposure.sh | Open |
| R-002 | Real secrets accidentally committed | High | Medium | High | .gitignore, safe-use policy | Manual review and secret scanning notes | .gitignore, docs | Open |
| R-003 | Docker containers left running | Medium | Medium | Medium | Cleanup scripts | Add final cleanup checklist | Docker cleanup scripts | Open |
| R-004 | Broken scripts pushed to GitHub | Medium | Low | Medium | CI Bash/Python checks | Run local CI before push | GitHub Actions | Mitigated |
| R-005 | Compose file invalid | Medium | Low | Medium | Compose config CI | Keep Compose files minimal | CI job | Mitigated |
| R-006 | Lab commands run against wrong target | High | Low | Medium | Safety warnings | Keep localhost defaults | Lab docs | Open |
| R-007 | Reports include private local information | Medium | Medium | Medium | Report templates | Review before commit | report docs | Open |
| R-008 | Monitoring target misconfigured | Low | Medium | Low | Prometheus target checks | Add alerting lab later | Lab 012 | Open |
