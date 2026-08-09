#!/usr/bin/env python3
"""Static validation for the governed UTS implementation baseline."""

from __future__ import annotations

import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

EXPECTED_PROJECTS = {
    "UTS.Core": set(),
    "UTS.Application.Contracts": {"UTS.Core"},
    "UTS.Application": {"UTS.Core", "UTS.Application.Contracts"},
    "UTS.Infrastructure.SQLite": {"UTS.Core", "UTS.Application.Contracts"},
    "UTS.Infrastructure.Driver.Abstractions": {"UTS.Core", "UTS.Application.Contracts"},
    "UTS.Infrastructure.Driver.Simulator": {
        "UTS.Core",
        "UTS.Application.Contracts",
        "UTS.Infrastructure.Driver.Abstractions",
    },
    "UTS.Infrastructure.Reporting": {"UTS.Core", "UTS.Application.Contracts"},
    "UTS.Presentation.Wpf": {"UTS.Application.Contracts"},
    "UTS.Bootstrapper": {
        "UTS.Core",
        "UTS.Application.Contracts",
        "UTS.Application",
        "UTS.Infrastructure.SQLite",
        "UTS.Infrastructure.Driver.Abstractions",
        "UTS.Infrastructure.Driver.Simulator",
        "UTS.Infrastructure.Reporting",
        "UTS.Presentation.Wpf",
    },
}

PINNED_PACKAGES = {
    "Microsoft.NETFramework.ReferenceAssemblies.net48": "1.0.3",
    "System.Data.SQLite.Core": "1.0.119",
    "OxyPlot.Wpf": "2.2.0",
    "NLog": "6.1.4",
    "NUnit": "4.6.1",
    "NUnit3TestAdapter": "6.2.0",
    "Microsoft.NET.Test.Sdk": "18.8.1",
}


def fail(errors: list[str], message: str) -> None:
    errors.append(message)


def parse_references(project_file: Path) -> set[str]:
    root = ET.parse(project_file).getroot()
    references: set[str] = set()
    for element in root.iter():
        if element.tag.rsplit("}", 1)[-1] == "ProjectReference":
            include = element.attrib.get("Include", "").replace("\\", "/")
            references.add(Path(include).stem)
    return references


def validate_projects(errors: list[str]) -> None:
    props = (ROOT / "Directory.Build.props").read_text(encoding="utf-8")
    for expected in ("<TargetFramework>net48</TargetFramework>", "<PlatformTarget>x86</PlatformTarget>",
                     "<OptionStrict>On</OptionStrict>", "<OptionExplicit>On</OptionExplicit>"):
        if expected not in props:
            fail(errors, f"Missing common build property: {expected}")

    actual_projects = {path.stem: path for path in (ROOT / "src").glob("*/*.vbproj")}
    if set(actual_projects) != set(EXPECTED_PROJECTS):
        fail(errors, f"Production project set mismatch: {sorted(actual_projects)}")

    for name, allowed in EXPECTED_PROJECTS.items():
        project = actual_projects.get(name)
        if project is None:
            continue
        references = parse_references(project)
        if references != allowed:
            fail(errors, f"{name} references {sorted(references)}; expected {sorted(allowed)}")

    if list((ROOT / "src").rglob("*.cs")) or list((ROOT / "src").rglob("*.csproj")):
        fail(errors, "C# production source/project detected")


def validate_packages(errors: list[str]) -> None:
    root = ET.parse(ROOT / "Directory.Packages.props").getroot()
    actual: dict[str, str] = {}
    for element in root.iter():
        if element.tag.rsplit("}", 1)[-1] == "PackageVersion":
            actual[element.attrib["Include"]] = element.attrib["Version"]
    if actual != PINNED_PACKAGES:
        fail(errors, f"Pinned package baseline mismatch: {actual}")

    for project in ROOT.rglob("*.vbproj"):
        tree = ET.parse(project)
        for element in tree.getroot().iter():
            if element.tag.rsplit("}", 1)[-1] == "PackageReference" and "Version" in element.attrib:
                fail(errors, f"Package version bypasses central baseline: {project}")


def validate_source_boundaries(errors: list[str]) -> None:
    source_files = list((ROOT / "src").rglob("*.vb"))
    forbidden_release = ("TODO", "NotImplementedException")
    forbidden_listener = ("HttpListener", "TcpListener", "Grpc", "WebSocket")

    for path in source_files:
        text = path.read_text(encoding="utf-8")
        for token in forbidden_release + forbidden_listener:
            if token in text:
                fail(errors, f"Forbidden token {token!r} in {path.relative_to(ROOT)}")
        if re.search(r"Catch(?:\s+\w+(?:\s+As\s+[\w.]+)?)?\s*\r?\n\s*End Try", text, re.IGNORECASE):
            fail(errors, f"Empty Catch block in {path.relative_to(ROOT)}")

    presentation = "\n".join(path.read_text(encoding="utf-8") for path in (ROOT / "src/UTS.Presentation.Wpf").rglob("*.vb"))
    for token in ("System.Data.SQLite", "SQLiteConnection", "IMachineDriver", "UTS.Infrastructure", "SetRegister", "SetCoil"):
        if token in presentation:
            fail(errors, f"Presentation boundary violation: {token}")

    reporting = "\n".join(path.read_text(encoding="utf-8") for path in (ROOT / "src/UTS.Infrastructure.Reporting").rglob("*.vb"))
    for token in ("IRawReplaySource", "IMachineDriver", "System.Data.SQLite"):
        if token in reporting:
            fail(errors, f"Reporting boundary violation: {token}")


def validate_document_sync(errors: list[str]) -> None:
    frozen_index = (ROOT / "FROZEN_DECISIONS.md").read_text(encoding="utf-8")
    for number in range(1, 15):
        identifier = f"EDR-{number:04d}"
        matching = list((ROOT / "EDR").glob(f"{identifier}-*.md"))
        if len(matching) != 1:
            fail(errors, f"Expected exactly one {identifier} document")
            continue
        content = matching[0].read_text(encoding="utf-8")
        if "status: FROZEN" not in content:
            fail(errors, f"{identifier} is not FROZEN")
        if identifier not in frozen_index:
            fail(errors, f"{identifier} missing from Frozen index")

    rtm = (ROOT / "ENGINEERING/REQUIREMENTS_TRACEABILITY.md").read_text(encoding="utf-8")
    tests = (ROOT / "ENGINEERING/ACCEPTANCE_TESTS.md").read_text(encoding="utf-8")
    requirement_ids = set(re.findall(r"`(BASE-\d{3})`", rtm))
    rtm_test_ids = set(re.findall(r"`(BAT-\d{3})`", rtm))
    acceptance_ids = set(re.findall(r"`(BAT-\d{3})`", tests))
    if len(requirement_ids) != 34:
        fail(errors, f"Expected 34 baseline requirements, found {len(requirement_ids)}")
    if rtm_test_ids != acceptance_ids:
        fail(errors, "RTM and acceptance test identifiers are not bidirectional")
    if re.search(r"\|[ \t]*\|", rtm):
        fail(errors, "RTM contains an empty table cell")

    scientific_edr = (ROOT / "EDR/EDR-0014-SCIENTIFIC-AND-ANALYSIS-ENGINE.md").read_text(encoding="utf-8")
    scientific_spec = (ROOT / "SCIENTIFIC/SCIENTIFIC_COMPLETION_SPECIFICATION.md").read_text(encoding="utf-8")
    scientific_rtm = (ROOT / "SCIENTIFIC/REQUIREMENTS_TRACEABILITY.md").read_text(encoding="utf-8")
    scientific_tests = (ROOT / "SCIENTIFIC/ACCEPTANCE_TESTS.md").read_text(encoding="utf-8")
    scientific_cases = (ROOT / "SCIENTIFIC/TEST_CASE_SPECIFICATIONS.md").read_text(encoding="utf-8")
    scientific_fixtures = (ROOT / "SCIENTIFIC/TEST_FIXTURE_CATALOG.md").read_text(encoding="utf-8")
    scientific_coverage = (ROOT / "SCIENTIFIC/SOURCE_COVERAGE_AUDIT.md").read_text(encoding="utf-8")
    source_register = (ROOT / "REFERENCES/README.md").read_text(encoding="utf-8")

    scientific_requirement_ids = set(re.findall(r"`(SCI-\d{3})`", scientific_rtm))
    scientific_rtm_test_ids = set(re.findall(r"`(SAT-\d{3})`", scientific_rtm))
    scientific_acceptance_ids = set(re.findall(r"`(SAT-\d{3})`", scientific_tests))
    scientific_case_ids = set(re.findall(r"`(SAT-\d{3})`", scientific_cases))
    if len(scientific_requirement_ids) != 45:
        fail(errors, f"Expected 45 scientific requirements, found {len(scientific_requirement_ids)}")
    if scientific_rtm_test_ids != scientific_acceptance_ids or len(scientific_acceptance_ids) != 45:
        fail(errors, "Scientific RTM and acceptance identifiers are not complete and bidirectional")
    if scientific_case_ids != scientific_acceptance_ids:
        fail(errors, "Detailed scientific case specifications do not cover every acceptance identifier")
    if scientific_tests.count("CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN") != 46:
        fail(errors, "Scientific acceptance index must retain 45 NOT-RUN case rows plus its status definition")
    if re.search(r"\|[ \t]*\|", scientific_rtm):
        fail(errors, "Scientific RTM contains an empty table cell")
    for token in (
        "REF-STD-ISO-6892-1-2019",
        "REF-STD-ASTM-E8-E8M-15A",
        "REF-SCI-ASM-TENSILE-2004",
    ):
        if token not in source_register or token not in scientific_edr:
            fail(errors, f"Scientific source is not synchronized: {token}")
    for token in ("SCI-045", "SAT-045", "Scientific Architecture and Scope Frozen; Implementation Pending"):
        if token not in scientific_edr + scientific_spec + scientific_rtm + scientific_tests:
            fail(errors, f"Scientific package synchronization token missing: {token}")
    for token in (
        "independent oracle",
        "FX-ANA-ENERGY-LINEAR",
        "SG-02 Clause Traceability",
        "ASTM profile boundary defined; detailed ASTM implementation scope Pending",
    ):
        if token not in scientific_cases + scientific_fixtures + scientific_coverage:
            fail(errors, f"Scientific test-design or coverage token missing: {token}")


def main() -> int:
    errors: list[str] = []
    validate_projects(errors)
    validate_packages(errors)
    validate_source_boundaries(errors)
    validate_document_sync(errors)

    if errors:
        print("IMPLEMENTATION BASELINE VALIDATION: FAIL")
        for error in errors:
            print(f"- {error}")
        return 1

    print("IMPLEMENTATION BASELINE VALIDATION: PASS")
    print(f"- production projects: {len(EXPECTED_PROJECTS)}")
    print(f"- pinned packages: {len(PINNED_PACKAGES)}")
    print("- Frozen EDRs indexed: 14")
    print("- baseline RTM/acceptance pairs: 34")
    print("- scientific RTM/acceptance pairs: 45")
    return 0


if __name__ == "__main__":
    sys.exit(main())
