#!/usr/bin/env python3
"""Validate the controlled JTS legacy-source intake package."""

from __future__ import annotations

import argparse
import hashlib
import re
import stat
import sys
import zipfile
from pathlib import Path, PurePosixPath


EXPECTED_ZIP_SHA256 = "334e9341ba5be8980fce5c140b1d59a5be660bd1338d90f10aabc4da8c52f8ce"
EXPECTED_FILE_COUNT = 87
EXPECTED_CHAPTER_COUNT = 82


def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def line_count(data: bytes) -> int:
    return len(data.splitlines())


def source_path_for(member_name: str, source_root: Path) -> Path:
    member = PurePosixPath(member_name)
    if member.is_absolute() or ".." in member.parts or not member.parts or member.parts[0] != "jts":
        raise ValueError("unsafe or unexpected archive path: {0}".format(member_name))
    return source_root.joinpath(*member.parts[1:])


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write-manifest", action="store_true")
    args = parser.parse_args()

    package_root = Path(__file__).resolve().parent
    zip_path = package_root / "jts.zip"
    source_root = package_root / "SOURCE"
    manifest_path = package_root / "SOURCE_MANIFEST.tsv"

    errors: list[str] = []
    zip_bytes = zip_path.read_bytes()
    if digest(zip_bytes) != EXPECTED_ZIP_SHA256:
        errors.append("archive SHA-256 mismatch")

    manifest_rows: list[tuple[str, int, int, str, int, str]] = []
    chapter_count = 0
    frozen_chapter_count = 0
    chapter_numbers: set[int] = set()
    expected_source_paths: set[Path] = set()

    with zipfile.ZipFile(zip_path) as archive:
        bad = archive.testzip()
        if bad is not None:
            errors.append("ZIP CRC failure: {0}".format(bad))

        file_infos = [info for info in archive.infolist() if not info.is_dir()]
        if len(file_infos) != EXPECTED_FILE_COUNT:
            errors.append("expected {0} files, found {1}".format(EXPECTED_FILE_COUNT, len(file_infos)))

        for info in file_infos:
            mode = info.external_attr >> 16
            if stat.S_ISLNK(mode):
                errors.append("symlink member is prohibited: {0}".format(info.filename))
                continue
            if not info.filename.lower().endswith(".md"):
                errors.append("non-Markdown member is prohibited: {0}".format(info.filename))

            try:
                extracted_path = source_path_for(info.filename, source_root)
            except ValueError as exc:
                errors.append(str(exc))
                continue

            archive_data = archive.read(info)
            normalized_archive_data = archive_data.replace(b"\r\n", b"\n")
            if b"\r" in normalized_archive_data:
                errors.append("unsupported bare CR in archive member: {0}".format(info.filename))
            expected_source_paths.add(extracted_path.resolve())
            if not extracted_path.is_file():
                errors.append("missing searchable extraction: {0}".format(extracted_path.name))
                continue

            extracted_data = extracted_path.read_bytes()
            if extracted_data != normalized_archive_data:
                errors.append("extracted content mismatch: {0}".format(extracted_path.name))

            relative_name = str(extracted_path.relative_to(source_root)).replace("\\", "/")
            manifest_rows.append(
                (
                    relative_name,
                    len(archive_data),
                    line_count(archive_data),
                    digest(archive_data),
                    len(extracted_data),
                    digest(extracted_data),
                )
            )

            if relative_name.startswith("Chapter ") and relative_name.endswith(".md"):
                chapter_count += 1
                text = archive_data.decode("utf-8-sig", errors="strict").replace("\r\n", "\n")
                match = re.fullmatch(r"Chapter (\d{2})\.md", relative_name)
                if match is None:
                    errors.append("unexpected chapter filename: {0}".format(relative_name))
                else:
                    chapter_number = int(match.group(1))
                    chapter_numbers.add(chapter_number)
                    if "\nARCH-{0:03d}\n".format(chapter_number) not in "\n" + text:
                        errors.append("chapter/document ID mismatch: {0}".format(relative_name))
                if "\nStatus\n\nFROZEN\n" in "\n" + text:
                    frozen_chapter_count += 1

    actual_source_paths = {path.resolve() for path in source_root.rglob("*") if path.is_file()}
    for unexpected in sorted(actual_source_paths - expected_source_paths):
        errors.append("unexpected extracted file: {0}".format(unexpected))

    if chapter_count != EXPECTED_CHAPTER_COUNT:
        errors.append("expected {0} chapters, found {1}".format(EXPECTED_CHAPTER_COUNT, chapter_count))
    if chapter_numbers != set(range(EXPECTED_CHAPTER_COUNT)):
        errors.append("chapter sequence is not exactly 00 through 81")
    if frozen_chapter_count != EXPECTED_CHAPTER_COUNT:
        errors.append("expected all chapters to claim FROZEN; found {0}".format(frozen_chapter_count))

    manifest_rows.sort(key=lambda row: row[0])
    manifest_text = "path\tarchive_bytes\tlogical_lines\tarchive_sha256\tsource_bytes\tsource_sha256\n" + "".join(
        "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\n".format(*row) for row in manifest_rows
    )

    if args.write_manifest:
        manifest_path.write_text(manifest_text, encoding="utf-8", newline="\n")
    elif not manifest_path.is_file():
        errors.append("SOURCE_MANIFEST.tsv is missing")
    elif manifest_path.read_text(encoding="utf-8") != manifest_text:
        errors.append("SOURCE_MANIFEST.tsv does not match source content")

    if errors:
        for error in errors:
            print("FAIL: {0}".format(error), file=sys.stderr)
        return 1

    print("PASS: archive_sha256={0}".format(EXPECTED_ZIP_SHA256))
    print("PASS: files={0} chapters={1} frozen_claims={2}".format(len(manifest_rows), chapter_count, frozen_chapter_count))
    print("PASS: searchable extraction matches after CRLF-to-LF normalization")
    print("PASS: all preserved content remains legacy evidence")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
