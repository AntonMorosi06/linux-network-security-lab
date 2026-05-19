# Threat Modeling and Hardening Notes

Threat modeling is a structured way to reason about what can go wrong in a system.

Core questions:

```text
What are the assets?
What are the entry points?
Where are the trust boundaries?
What data flows exist?
What threats apply?
What mitigations exist?
What evidence proves the mitigations?
```

Hardening means reducing unnecessary exposure and making failure safer. Examples include binding local services to `127.0.0.1`, validating input, using API keys for protected routes, avoiding committed secrets, stopping containers after tests and running CI before push.
