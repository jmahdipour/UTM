from pathlib import Path
from collections import Counter
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
FILES = [
    ROOT / "EDR" / "EDR-0009-HARDWARE-INDEPENDENT-DRIVER-AND-PLC-MAP.md",
    ROOT / "ARCHITECTURE" / "DRIVER_PLC_ARCHITECTURE.md",
    ROOT / "DRIVER" / "DRIVER_CONTRACT.md",
    ROOT / "DRIVER" / "HARDWARE_MAP.md",
    ROOT / "DRIVER" / "SIMULATOR_AND_FAULT_INJECTION.md",
    ROOT / "DRIVER" / "COMMISSIONING_AND_ACTIVATION_GATES.md",
    ROOT / "DRIVER" / "REQUIREMENTS_TRACEABILITY.md",
    ROOT / "DRIVER" / "ACCEPTANCE_TESTS.md",
]

STATUSES = ("PASS-DOC", "PENDING-CODE", "BLOCKED-HARDWARE")
EXPECTED_STATUS_COUNTS = {
    "PASS-DOC": 10,
    "PENDING-CODE": 26,
    "BLOCKED-HARDWARE": 9,
}


def require(condition, message, errors):
    if not condition:
        errors.append(message)


def parse_rtm_rows(text, errors):
    rows = {}
    for line in text.splitlines():
        if not re.match(r"^\| DRV-\d{3} \|", line):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) != 6:
            errors.append("invalid RTM row shape: {0}".format(line))
            continue
        requirement_id, _, _, _, test_id, status = cells
        if requirement_id in rows:
            errors.append("duplicate RTM ID: {0}".format(requirement_id))
            continue
        rows[requirement_id] = {"test_id": test_id, "status": status}
    return rows


def parse_test_rows(text, errors):
    rows = {}
    status_pattern = re.compile(r"(?:^|;\s*)({0})$".format("|".join(STATUSES)))
    for line in text.splitlines():
        if not re.match(r"^\| DAT-\d{3} \|", line):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) != 3:
            errors.append("invalid acceptance-test row shape: {0}".format(line))
            continue
        test_id, _, evidence_and_result = cells
        match = status_pattern.search(evidence_and_result)
        status = match.group(1) if match else None
        if test_id in rows:
            errors.append("duplicate test ID: {0}".format(test_id))
            continue
        rows[test_id] = {"status": status}
    return rows


def parse_summary(text, heading, total_label, errors):
    match = re.search(
        r"^## {0}\s*$([\s\S]*?)(?=^## |\Z)".format(re.escape(heading)),
        text,
        flags=re.MULTILINE,
    )
    if not match:
        errors.append("missing summary heading: {0}".format(heading))
        return None, {}

    block = match.group(1)
    total_match = re.search(
        r"^- {0}: (\d+)\s*$".format(re.escape(total_label)),
        block,
        flags=re.MULTILINE,
    )
    total = int(total_match.group(1)) if total_match else None
    if total is None:
        errors.append("missing summary total: {0}".format(total_label))

    counts = {}
    for status in STATUSES:
        status_match = re.search(
            r"^- `{0}`: (\d+)\s*$".format(re.escape(status)),
            block,
            flags=re.MULTILINE,
        )
        if status_match:
            counts[status] = int(status_match.group(1))
        else:
            errors.append("missing summary status: {0} in {1}".format(status, heading))
    return total, counts


def main():
    errors = []
    texts = {}
    for path in FILES:
        require(path.exists(), "missing file: {0}".format(path), errors)
        if path.exists():
            texts[path.name] = path.read_text(encoding="utf-8")

    if errors:
        print("FAIL")
        print("\n".join(errors))
        return 1

    edr = texts["EDR-0009-HARDWARE-INDEPENDENT-DRIVER-AND-PLC-MAP.md"]
    hardware = texts["HARDWARE_MAP.md"]
    rtm = texts["REQUIREMENTS_TRACEABILITY.md"]
    tests = texts["ACCEPTANCE_TESTS.md"]

    require("status: FROZEN" in edr, "EDR must be FROZEN after owner approval", errors)
    require("physical_adapter_status: BLOCKED-HARDWARE" in hardware,
            "physical map must remain BLOCKED-HARDWARE", errors)
    require("WRITE-DISABLED" in hardware, "legacy writes must be disabled", errors)
    require("SetRegister" in edr and "generic Read/Write register" in edr,
            "generic native write rejection is missing", errors)
    require("1 kgf = 9.80665 N" in edr, "exact kgf provenance rule is missing", errors)
    require("no software clutch" in edr.lower(), "software clutch prohibition is missing", errors)

    required_points = [
        "X14", "M20", "M6", "R25", "R26", "R32", "M41", "R20/R21",
        "M40", "R37", "M42", "T55", "M61/M62", "M63/M64", "M4", "M0",
        "M1941", "M31", "M30", "M50", "M51", "M52", "M60", "R500", "M10/M11",
    ]
    for point in required_points:
        require("`{0}`".format(point) in hardware, "legacy point missing: {0}".format(point), errors)

    rtm_rows = parse_rtm_rows(rtm, errors)
    test_rows = parse_test_rows(tests, errors)
    expected_rtm_ids = {"DRV-{0:03d}".format(index) for index in range(1, 46)}
    expected_test_ids = {"DAT-{0:03d}".format(index) for index in range(1, 46)}

    require(len(rtm_rows) == 45, "expected 45 RTM rows, got {0}".format(len(rtm_rows)), errors)
    require(len(test_rows) == 45, "expected 45 test rows, got {0}".format(len(test_rows)), errors)
    require(set(rtm_rows) == expected_rtm_ids, "RTM ID sequence/coverage mismatch", errors)
    require(set(test_rows) == expected_test_ids, "test ID sequence/coverage mismatch", errors)

    referenced_tests = {row["test_id"] for row in rtm_rows.values()}
    require(referenced_tests == set(test_rows), "RTM/test ID coverage mismatch", errors)

    for requirement_id, row in sorted(rtm_rows.items()):
        expected_test_id = "DAT-" + requirement_id.split("-", 1)[1]
        require(row["test_id"] == expected_test_id,
                "{0} must reference {1}, got {2}".format(
                    requirement_id, expected_test_id, row["test_id"]), errors)
        require(row["status"] in STATUSES,
                "{0} has missing/invalid status: {1}".format(
                    requirement_id, row["status"]), errors)
        test_status = test_rows.get(row["test_id"], {}).get("status")
        require(test_status in STATUSES,
                "{0} has missing/invalid result: {1}".format(
                    row["test_id"], test_status), errors)
        require(row["status"] == test_status,
                "status mismatch: {0}={1}, {2}={3}".format(
                    requirement_id, row["status"], row["test_id"], test_status), errors)

    rtm_counts = Counter(row["status"] for row in rtm_rows.values())
    test_counts = Counter(row["status"] for row in test_rows.values())
    require(dict(rtm_counts) == EXPECTED_STATUS_COUNTS,
            "RTM status distribution mismatch: expected {0}, got {1}".format(
                EXPECTED_STATUS_COUNTS, dict(rtm_counts)), errors)
    require(dict(test_counts) == EXPECTED_STATUS_COUNTS,
            "test status distribution mismatch: expected {0}, got {1}".format(
                EXPECTED_STATUS_COUNTS, dict(test_counts)), errors)

    rtm_total, rtm_summary = parse_summary(
        rtm, "Coverage summary", "total requirements", errors)
    test_total, test_summary = parse_summary(
        tests, "Result summary", "total tests", errors)
    require(rtm_total == len(rtm_rows),
            "RTM summary total mismatch: declared {0}, actual {1}".format(
                rtm_total, len(rtm_rows)), errors)
    require(test_total == len(test_rows),
            "test summary total mismatch: declared {0}, actual {1}".format(
                test_total, len(test_rows)), errors)
    require(rtm_summary == dict(rtm_counts),
            "RTM summary distribution mismatch: declared {0}, actual {1}".format(
                rtm_summary, dict(rtm_counts)), errors)
    require(test_summary == dict(test_counts),
            "test summary distribution mismatch: declared {0}, actual {1}".format(
                test_summary, dict(test_counts)), errors)

    if errors:
        print("FAIL")
        print("\n".join(errors))
        return 1

    print("PASS")
    print("files=8")
    print("requirements=45")
    print("tests=45")
    print("status_distribution=PASS-DOC:10,PENDING-CODE:26,BLOCKED-HARDWARE:9")
    print("legacy_points=25")
    print("physical_adapter=BLOCKED-HARDWARE")
    return 0


if __name__ == "__main__":
    sys.exit(main())
