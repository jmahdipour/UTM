#!/usr/bin/env python3
"""Validate the ISO 6892-1:2019 Clauses 1-10 atomic traceability package."""

from __future__ import annotations

import re
import sys
from collections import Counter
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RTM = ROOT / "SCIENTIFIC/ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_RTM.md"
PARAMETERS = ROOT / "SCIENTIFIC/ISO_6892_1_2019_CLAUSES_01_10_PARAMETERS.md"
ACCEPTANCE = ROOT / "SCIENTIFIC/ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_ACCEPTANCE.md"

EXPECTED_BY_CLAUSE = {
    "C01": 2,
    "C02": 4,
    "C03": 42,
    "C04": 46,
    "C05": 7,
    "C06": 23,
    "C07": 5,
    "C08": 10,
    "C09": 3,
    "C10": 49,
}
EXPECTED_PARAMETER_COUNT = 53
EXPECTED_VARIANT_COUNT = 30


def table_rows(text: str, prefix: str) -> list[str]:
    return [line for line in text.splitlines() if line.startswith(f"| `{prefix}")]


def ids(text: str, pattern: str) -> list[str]:
    return re.findall(pattern, text)


def main() -> int:
    errors: list[str] = []
    rtm_text = RTM.read_text(encoding="utf-8")
    parameter_text = PARAMETERS.read_text(encoding="utf-8")
    acceptance_text = ACCEPTANCE.read_text(encoding="utf-8")

    atomic_rows = table_rows(rtm_text, "ISO19-")
    atomic_ids = [item for row in atomic_rows for item in ids(row, r"`(ISO19-C\d{2}(?:-T\d{2})?-\d{3})`")]
    duplicates = sorted(item for item, count in Counter(atomic_ids).items() if count != 1)
    if duplicates:
        errors.append(f"Atomic source IDs are duplicated or malformed: {duplicates}")

    expected_total = sum(EXPECTED_BY_CLAUSE.values())
    if len(atomic_rows) != expected_total or len(set(atomic_ids)) != expected_total:
        errors.append(
            f"Expected {expected_total} atomic source rows/IDs; found "
            f"{len(atomic_rows)} rows and {len(set(atomic_ids))} unique IDs"
        )

    for clause, expected in EXPECTED_BY_CLAUSE.items():
        actual = sum(1 for item in set(atomic_ids) if item.startswith(f"ISO19-{clause}"))
        if actual != expected:
            errors.append(f"{clause} expected {expected} source items; found {actual}")

    scientific_rtm = (ROOT / "SCIENTIFIC/REQUIREMENTS_TRACEABILITY.md").read_text(encoding="utf-8")
    scientific_tests = (ROOT / "SCIENTIFIC/ACCEPTANCE_TESTS.md").read_text(encoding="utf-8")
    known_sci = set(ids(scientific_rtm, r"`(SCI-\d{3})`"))
    known_sat = set(ids(scientific_tests, r"`(SAT-\d{3})`"))
    for row in atomic_rows:
        row_id_match = re.search(r"`(ISO19-[^`]+)`", row)
        row_id = row_id_match.group(1) if row_id_match else "UNKNOWN"
        row_sci = ids(row, r"`(SCI-\d{3})`")
        row_sat = ids(row, r"`(SAT-\d{3})`")
        row_iat = ids(row, r"`(IAT-[A-Z0-9-]+)`")
        if not row_sci or any(item not in known_sci for item in row_sci):
            errors.append(f"{row_id} has missing/unknown SCI routing: {row_sci}")
        if not row_sat or any(item not in known_sat for item in row_sat):
            errors.append(f"{row_id} has missing/unknown SAT routing: {row_sat}")
        if len(row_iat) != 1:
            errors.append(f"{row_id} must name exactly one atomic acceptance variant: {row_iat}")
        if not re.search(r"PDFs? \d+", row):
            errors.append(f"{row_id} lacks controlled PDF locator")
        if "EXTRACTED / REVIEW-PENDING" not in row:
            errors.append(f"{row_id} has an invalid evidence status")

    parameter_rows = table_rows(parameter_text, "IP-")
    parameter_ids = [item for row in parameter_rows for item in ids(row, r"`(IP-[A-Z0-9-]+)`")]
    parameter_defined = set(parameter_ids)
    parameter_referenced = set(ids(rtm_text, r"`(IP-[A-Z0-9-]+)`"))
    if len(parameter_rows) != EXPECTED_PARAMETER_COUNT or len(parameter_defined) != EXPECTED_PARAMETER_COUNT:
        errors.append(
            f"Expected {EXPECTED_PARAMETER_COUNT} unique parameter rows; found "
            f"{len(parameter_rows)} rows and {len(parameter_defined)} unique IDs"
        )
    if parameter_defined != parameter_referenced:
        errors.append(
            "Parameter routing mismatch; "
            f"unreferenced={sorted(parameter_defined - parameter_referenced)}, "
            f"undefined={sorted(parameter_referenced - parameter_defined)}"
        )
    for row in parameter_rows:
        if "EXTRACTED / INDEPENDENT-REVIEW-PENDING" not in row:
            errors.append(f"Parameter row does not retain review-pending status: {row[:80]}")

    variant_rows = table_rows(acceptance_text, "IAT-")
    variant_ids = [item for row in variant_rows for item in ids(row, r"`(IAT-[A-Z0-9-]+)`")]
    variant_defined = set(variant_ids)
    variant_referenced = set(ids(rtm_text, r"`(IAT-[A-Z0-9-]+)`"))
    if len(variant_rows) != EXPECTED_VARIANT_COUNT or len(variant_defined) != EXPECTED_VARIANT_COUNT:
        errors.append(
            f"Expected {EXPECTED_VARIANT_COUNT} unique acceptance variants; found "
            f"{len(variant_rows)} rows and {len(variant_defined)} unique IDs"
        )
    if variant_defined != variant_referenced:
        errors.append(
            "Acceptance routing mismatch; "
            f"unreferenced={sorted(variant_defined - variant_referenced)}, "
            f"undefined={sorted(variant_referenced - variant_defined)}"
        )
    for row in variant_rows:
        if not ids(row, r"`SAT-\d{3}`"):
            errors.append(f"Acceptance variant lacks a parent SAT: {row[:80]}")
        if "SPECIFIED / FIXTURE-PENDING / NOT-RUN" not in row:
            errors.append(f"Acceptance variant has invalid execution status: {row[:80]}")

    for token in (
        "Atomic source items: **191**",
        "Parameter/formula records: **53**",
        "Atomic acceptance variants: **30**",
    ):
        if token not in rtm_text + parameter_text + acceptance_text:
            errors.append(f"Package count statement missing: {token}")

    if errors:
        print("ISO CLAUSES 01-10 ATOMIC TRACEABILITY: FAIL")
        for error in errors:
            print(f"- {error}")
        return 1

    print("ISO CLAUSES 01-10 ATOMIC TRACEABILITY: PASS")
    print(f"- atomic source items: {expected_total}")
    print(f"- reviewed-parameter candidates: {EXPECTED_PARAMETER_COUNT} (review pending)")
    print(f"- atomic acceptance variants: {EXPECTED_VARIANT_COUNT} (not run)")
    print("- clauses: 1 through 10; printed pages 1-15; PDF pages 7-21")
    return 0


if __name__ == "__main__":
    sys.exit(main())
