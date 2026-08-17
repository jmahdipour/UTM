#!/usr/bin/env python3
"""Validate controlled ISO 6892-1:2019 atomic traceability packages."""

from __future__ import annotations

import re
import sys
from collections import Counter
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCIENTIFIC = ROOT / "SCIENTIFIC"


@dataclass(frozen=True)
class Package:
    name: str
    rtm: Path
    parameters: Path
    acceptance: Path
    expected_by_clause: dict[str, int]
    expected_parameter_count: int
    expected_variant_count: int
    page_summary: str


PACKAGES = (
    Package(
        name="CLAUSES 01-10",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_01_10_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
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
        },
        expected_parameter_count=53,
        expected_variant_count=30,
        page_summary="clauses 1 through 10; printed pages 1-15; PDF pages 7-21",
    ),
    Package(
        name="CLAUSES 11-16",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_11_16_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_11_16_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_11_16_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "C11": 5,
            "C12": 10,
            "C13": 23,
            "C14": 8,
            "C15": 11,
            "C16": 14,
        },
        expected_parameter_count=13,
        expected_variant_count=21,
        page_summary="clauses 11 through 16 and Figures 2-7; printed pages 15-25; PDF pages 21-31",
    ),
    Package(
        name="CLAUSES 17-23",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_17_23_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_17_23_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_CLAUSES_17_23_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "C03": 4,
            "C10": 11,
            "C17": 11,
            "C18": 7,
            "C19": 6,
            "C20": 27,
            "C21": 12,
            "C22": 17,
            "C23": 8,
        },
        expected_parameter_count=15,
        expected_variant_count=26,
        page_summary="clauses 17 through 23 and Figures 1, 8-10; printed pages 17-28; PDF pages 23-34",
    ),
    Package(
        name="ANNEX A",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_A_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_A_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_A_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AA": 94,
        },
        expected_parameter_count=19,
        expected_variant_count=21,
        page_summary="informative Annex A, Figures A.1-A.2 and Table A.1; printed pages 34-39; PDF pages 40-45",
    ),
    Package(
        name="ANNEX B",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_B_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_B_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_B_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AB": 48,
        },
        expected_parameter_count=19,
        expected_variant_count=14,
        page_summary="normative Annex B, Tables B.1-B.2 and Figure 11; printed pages 29 and 40-42; PDF pages 35 and 46-48",
    ),
    Package(
        name="ANNEX C",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_C_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_C_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_C_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AC": 25,
        },
        expected_parameter_count=10,
        expected_variant_count=10,
        page_summary="normative Annex C, Formula C.1 and Figure 12; printed pages 30 and 43; PDF pages 36 and 49",
    ),
    Package(
        name="ANNEX D",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_D_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_D_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_D_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AD": 64,
        },
        expected_parameter_count=31,
        expected_variant_count=19,
        page_summary="normative Annex D, Formula D.1, Tables D.1-D.3 and Figure 13; printed pages 31 and 44-47; PDF pages 37 and 50-53",
    ),
    Package(
        name="ANNEX E",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_E_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_E_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_E_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AE": 58,
        },
        expected_parameter_count=12,
        expected_variant_count=15,
        page_summary="normative Annex E, Formulas E.1-E.4 and Figures 14-15; printed pages 32-33 and 48-49; PDF pages 38-39 and 54-55",
    ),
    Package(
        name="ANNEX F",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_F_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_F_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_F_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AF": 35,
        },
        expected_parameter_count=3,
        expected_variant_count=8,
        page_summary="informative Annex F and Formulas F.1-F.3; printed pages 50-51; PDF pages 56-57",
    ),
    Package(
        name="ANNEX G",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_G_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_G_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_G_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AG": 153,
        },
        expected_parameter_count=56,
        expected_variant_count=24,
        page_summary="normative Annex G, Formulas G.1-G.8 and Tables G.1-G.3; printed pages 52-59; PDF pages 58-65",
    ),
    Package(
        name="ANNEX H",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_H_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_H_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_H_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AH": 19,
        },
        expected_parameter_count=3,
        expected_variant_count=6,
        page_summary="informative Annex H; printed page 60; PDF page 66",
    ),
    Package(
        name="ANNEX I",
        rtm=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_I_ATOMIC_RTM.md",
        parameters=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_I_PARAMETERS.md",
        acceptance=SCIENTIFIC / "ISO_6892_1_2019_ANNEX_I_ATOMIC_ACCEPTANCE.md",
        expected_by_clause={
            "AI": 35,
        },
        expected_parameter_count=10,
        expected_variant_count=7,
        page_summary="informative Annex I, Formulas I.1-I.2 and Figure I.1; printed pages 61-62; PDF pages 67-68",
    ),
)


def table_rows(text: str, prefix: str) -> list[str]:
    return [line for line in text.splitlines() if line.startswith(f"| `{prefix}")]


def ids(text: str, pattern: str) -> list[str]:
    return re.findall(pattern, text)


def check_package(
    package: Package,
    known_sci: set[str],
    known_sat: set[str],
    known_parameters: set[str],
) -> tuple[list[str], set[str], set[str], set[str], set[str]]:
    errors: list[str] = []
    rtm_text = package.rtm.read_text(encoding="utf-8")
    parameter_text = package.parameters.read_text(encoding="utf-8")
    acceptance_text = package.acceptance.read_text(encoding="utf-8")

    atomic_rows = table_rows(rtm_text, "ISO19-")
    atomic_ids = [
        item
        for row in atomic_rows
        for item in ids(
            row,
            r"`(ISO19-(?:C\d{2}|A[A-L])(?:-[TF][A-Z0-9]+)?-\d{3})`",
        )
    ]
    duplicate_atomic = sorted(item for item, count in Counter(atomic_ids).items() if count != 1)
    if duplicate_atomic:
        errors.append(f"Atomic source IDs are duplicated or malformed: {duplicate_atomic}")

    expected_total = sum(package.expected_by_clause.values())
    if len(atomic_rows) != expected_total or len(set(atomic_ids)) != expected_total:
        errors.append(
            f"Expected {expected_total} atomic source rows/IDs; found "
            f"{len(atomic_rows)} rows and {len(set(atomic_ids))} unique IDs"
        )

    for clause, expected in package.expected_by_clause.items():
        actual = sum(1 for item in set(atomic_ids) if item.startswith(f"ISO19-{clause}"))
        if actual != expected:
            errors.append(f"{clause} expected {expected} source items; found {actual}")

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
    if (
        len(parameter_rows) != package.expected_parameter_count
        or len(parameter_defined) != package.expected_parameter_count
    ):
        errors.append(
            f"Expected {package.expected_parameter_count} unique parameter rows; found "
            f"{len(parameter_rows)} rows and {len(parameter_defined)} unique IDs"
        )
    unreferenced_local = parameter_defined - parameter_referenced
    undefined = parameter_referenced - known_parameters
    if unreferenced_local or undefined:
        errors.append(
            "Parameter routing mismatch; "
            f"unreferenced-local={sorted(unreferenced_local)}, "
            f"undefined-global={sorted(undefined)}"
        )
    for row in parameter_rows:
        if "EXTRACTED / INDEPENDENT-REVIEW-PENDING" not in row:
            errors.append(f"Parameter row does not retain review-pending status: {row[:80]}")
        if not re.search(r"PDFs? \d+", row):
            errors.append(f"Parameter row lacks controlled PDF locator: {row[:80]}")

    variant_rows = table_rows(acceptance_text, "IAT-")
    variant_ids = [item for row in variant_rows for item in ids(row, r"`(IAT-[A-Z0-9-]+)`")]
    variant_defined = set(variant_ids)
    variant_referenced = set(ids(rtm_text, r"`(IAT-[A-Z0-9-]+)`"))
    if (
        len(variant_rows) != package.expected_variant_count
        or len(variant_defined) != package.expected_variant_count
    ):
        errors.append(
            f"Expected {package.expected_variant_count} unique acceptance variants; found "
            f"{len(variant_rows)} rows and {len(variant_defined)} unique IDs"
        )
    if variant_defined != variant_referenced:
        errors.append(
            "Acceptance routing mismatch; "
            f"unreferenced={sorted(variant_defined - variant_referenced)}, "
            f"undefined={sorted(variant_referenced - variant_defined)}"
        )
    for row in variant_rows:
        row_sat = ids(row, r"`(SAT-\d{3})`")
        if not row_sat or any(item not in known_sat for item in row_sat):
            errors.append(f"Acceptance variant has missing/unknown parent SAT: {row_sat}")
        if "SPECIFIED / FIXTURE-PENDING / NOT-RUN" not in row:
            errors.append(f"Acceptance variant has invalid execution status: {row[:80]}")

    for token in (
        f"Atomic source items: **{expected_total}**",
        f"Parameter/formula records: **{package.expected_parameter_count}**",
        f"Atomic acceptance variants: **{package.expected_variant_count}**",
    ):
        if token not in rtm_text + parameter_text + acceptance_text:
            errors.append(f"Package count statement missing: {token}")

    return errors, set(atomic_ids), parameter_defined, parameter_referenced, variant_defined


def main() -> int:
    scientific_rtm = (SCIENTIFIC / "REQUIREMENTS_TRACEABILITY.md").read_text(encoding="utf-8")
    scientific_tests = (SCIENTIFIC / "ACCEPTANCE_TESTS.md").read_text(encoding="utf-8")
    known_sci = set(ids(scientific_rtm, r"`(SCI-\d{3})`"))
    known_sat = set(ids(scientific_tests, r"`(SAT-\d{3})`"))

    parameter_definition_list = [
        item
        for package in PACKAGES
        for row in table_rows(package.parameters.read_text(encoding="utf-8"), "IP-")
        for item in ids(row, r"`(IP-[A-Z0-9-]+)`")
    ]
    known_parameters = set(parameter_definition_list)

    all_errors: list[str] = []
    all_atomic: list[str] = []
    all_parameters: list[str] = []
    all_parameter_references: list[str] = []
    all_variants: list[str] = []

    for package in PACKAGES:
        errors, atomic_ids, parameter_ids, parameter_references, variant_ids = check_package(
            package, known_sci, known_sat, known_parameters
        )
        all_errors.extend(f"{package.name}: {error}" for error in errors)
        all_atomic.extend(atomic_ids)
        all_parameters.extend(parameter_ids)
        all_parameter_references.extend(parameter_references)
        all_variants.extend(variant_ids)

    for label, values in (
        ("atomic source", all_atomic),
        ("parameter", all_parameters),
        ("acceptance variant", all_variants),
    ):
        duplicates = sorted(item for item, count in Counter(values).items() if count != 1)
        if duplicates:
            all_errors.append(f"Cross-package duplicate {label} IDs: {duplicates}")

    globally_unreferenced = known_parameters - set(all_parameter_references)
    if globally_unreferenced:
        all_errors.append(f"Globally unreferenced parameter IDs: {sorted(globally_unreferenced)}")

    if all_errors:
        print("ISO ATOMIC TRACEABILITY: FAIL")
        for error in all_errors:
            print(f"- {error}")
        return 1

    print("ISO ATOMIC TRACEABILITY: PASS")
    for package in PACKAGES:
        print(
            f"- {package.name}: {sum(package.expected_by_clause.values())} source items, "
            f"{package.expected_parameter_count} parameter/formula candidates, "
            f"{package.expected_variant_count} acceptance variants"
        )
        print(f"  {package.page_summary}")
    print(f"- total atomic source items: {len(all_atomic)}")
    print(f"- total parameter/formula candidates: {len(all_parameters)} (independent review pending)")
    print(f"- total atomic acceptance variants: {len(all_variants)} (not run)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
