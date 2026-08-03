#!/usr/bin/env python3
"""Static acceptance checks for the Frozen EDR-0008 documentation package."""

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
FILES = [
    ROOT / "EDR/EDR-0008-APPLICATION-AND-API-CONTRACTS.md",
    ROOT / "ARCHITECTURE/APPLICATION_API_CONTRACTS.md",
    ROOT / "DOMAIN/APPLICATION_COMMAND_QUERY_CATALOG.md",
    ROOT / "DOMAIN/REASON_CODE_CATALOG.md",
    ROOT / "APPLICATION/PORTS_AND_TRANSACTION_BOUNDARIES.md",
    ROOT / "APPLICATION/REQUIREMENTS_TRACEABILITY.md",
    ROOT / "APPLICATION/ACCEPTANCE_TESTS.md",
]


def fail(message: str) -> None:
    raise AssertionError(message)


def main() -> int:
    for path in FILES:
        if not path.is_file():
            fail(f"missing required file: {path.relative_to(ROOT)}")

    text = {path: path.read_text(encoding="utf-8") for path in FILES}
    combined = "\n".join(text.values())

    edr = text[FILES[0]]
    if "status: FROZEN" not in edr:
        fail("EDR-0008 must be FROZEN after owner approval")
    if "No public HTTP, REST, gRPC, socket, scripting or remote-motion API" not in edr:
        fail("external transport prohibition is missing")
    if "1 kgf = 9.80665 N" not in edr:
        fail("Frozen kgf conversion is missing")

    catalog = text[FILES[2]]
    command_ids = re.findall(r"`([A-Z]{3}\.[A-Z0-9_]+)`\s*\|\s*1\s*\|", catalog)
    if len(command_ids) < 40:
        fail(f"expected at least 40 versioned commands, found {len(command_ids)}")
    if len(command_ids) != len(set(command_ids)):
        fail("duplicate command ID found")

    reasons = re.findall(
        r"^\| `([A-Z]+\.[A-Z0-9_]+)` \|",
        text[FILES[3]],
        flags=re.MULTILINE,
    )
    if len(reasons) < 50:
        fail(f"expected at least 50 stable reason codes, found {len(reasons)}")
    if len(reasons) != len(set(reasons)):
        fail("duplicate reason code found")

    rtm = text[FILES[5]]
    tests = text[FILES[6]]
    req_ids = set(re.findall(r"`(APP-\d{3})`", rtm))
    rtm_test_ids = set(re.findall(r"`(AT-APP-\d{3})`", rtm))
    acceptance_ids = set(re.findall(r"`(AT-APP-\d{3})`", tests))
    if len(req_ids) != 40:
        fail(f"expected 40 unique requirements, found {len(req_ids)}")
    if rtm_test_ids != acceptance_ids:
        fail("RTM and acceptance-test IDs are not bidirectionally complete")

    rows = [line for line in rtm.splitlines() if re.match(r"\| `APP-\d{3}`", line)]
    if any("|  |" in row or not re.search(r"(DESIGN-PASS|IMPLEMENTATION-PENDING|HARDWARE-BLOCKED)", row) for row in rows):
        fail("a requirement row has an empty/invalid status")

    test_rows = [line for line in tests.splitlines() if re.match(r"\| `AT-APP-\d{3}`", line)]
    if any(not re.search(r"(PASS-STATIC|PENDING-CODE|PENDING-HARDWARE)", row) for row in test_rows):
        fail("an acceptance row has no result status")

    forbidden_placeholders = ["TODO", "TBD", "FIXME", "???"]
    for marker in forbidden_placeholders:
        if marker in combined:
            fail(f"unresolved placeholder present: {marker}")

    required_phrases = [
        "Re-Analyze",
        "ExpectedRevision",
        "InterlockSnapshot",
        "RequestId",
        "TimedOut",
        "JOG",
        "display decimation",
        "post-commit",
    ]
    for phrase in required_phrases:
        if phrase not in combined:
            fail(f"required contract concept missing: {phrase}")

    print("EDR-0008 contract package: PASS")
    print(f"files={len(FILES)} commands={len(command_ids)} reason_codes={len(reasons)} requirements={len(req_ids)} tests={len(acceptance_ids)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(f"EDR-0008 contract package: FAIL: {exc}", file=sys.stderr)
        raise SystemExit(1)
