# TensileTestX — COMPLETE SINGLE-FILE PROJECT CONTEXT
### This one file contains EVERYTHING: the master handoff (§0–§18) plus all companion
### documents as appendices (A–G). Paste this whole file at the start of a new chat.
### The only things NOT inline (must be attached separately): the Core code zip and the
### reference PDFs (INSO 3132, catalog, 304-page User Guide, PLC architecture, Self-check).

---

# ===================================================================
# PART 1 — MASTER HANDOFF (§0–§18)
# ===================================================================

# TensileTestX — Complete Project Handoff & Instructions
### (Start a new chat with this document. It carries the full project context.)

---

## 0. HOW TO USE THIS DOCUMENT

This is the master prompt for building **TensileTestX**, a Windows desktop application
that replaces Shimadzu's TRAPEZIUM X software to run a Facon-controlled 25-ton universal
material testing machine. Paste this whole document at the start of a new chat. It
contains every rule, decision, and reference fact agreed so far. Attached reference files
that should travel with this project:

- `3132-1403.pdf` — INSO 3132:2025 standard (rebar specs & test methods).
- `soft.pdf` — Shimadzu TRAPEZIUM X catalog (the 7-component main screen).
- `308575209-...-TRAPEZIUMX-User-s-Guide.pdf` — the full 304-page official user guide (primary UI reference).
- `pdfcoffee...-manual-deu-so-maquina-universal.pdf` — Shimadzu AG-X Hardware Self-check & Settings Guide (behavior reference only — see §11). NOTE: this file was NOT present in the chat where Ch11–20 were extracted; its behavior summary lives in §11 (do not assume more than §11 states until the PDF is re-attached).
- `PLC_Architecture_Prompt.md` — **Facon/Fatek PLC communication architecture from the real machine code** (ProgID, full R/M/X address map, comm loop, calibration, command sequences). **CANONICAL hardware source of truth — see §14.** Resolves Open Item #3.
- `ARCHITECTURE.md` — the system architecture (already produced). **[Now inline: Appendix A.]**
- `USERGUIDE_ANALYSIS.md` — detailed chapter-by-chapter analysis of the 304-page User Guide (page offset PDF = printed + 8). The fullest extraction of the 7-dialog Method Wizard, Batch×SubBatch numbering, the Data-Processing-Item dependency model, re-analysis tools, and SPC.
- `WORKFLOW_ALGORITHM_CH2-5.md` — workflow / algorithm / architecture extracted from Ch2–5 (test-execution loop, in-test operations, method-creation flow) mapped onto the Clean Architecture layers (the concrete spec for TestRunner + Method Wizard).
- `WORKFLOW_ALGORITHM_CH6-10.md` — workflow / algorithm / architecture from Ch6–10 (cycle/control/texture methods, re-analysis, output). Key results: ring stiffness is a Control move-and-hold test; method needs a motion-profile segment list; re-analysis is a 7-mode workflow on immutable raw; exporters are an ITestExporter family.
- `WORKFLOW_ALGORITHM_CH11-20.md` — settings & Phase-2 utilities from Ch11–20 (user/group permissions, customizing, language/auto-save/logs, USB, SPC, marker, initial-speed segment, clearance datum). New concepts: data-driven permissions, audit-log service, i18n, non-recording initial-speed segment + clearance datum, keyboard marker capture, SPC service.
- `ASTM_D732_D1894.md` — spec for two additional test types the lab owns fixtures for (shear-punch + friction).
- `SENSOR_INVENTORY.md` — the 5 load cells + 3 extensometers and the per-sensor calibration model (see §17).
- `TensileTestX_Core.zip` — the Core project already built (VB.NET).

---

## 1. WORKING RULES (apply to the ENTIRE project, every response)

These were established across the project and must persist:

**Rule 1 — Council protocol.** For any non-trivial design decision, reason through
multiple internal viewpoints before deciding: an Opponent (find the flaw/trap), a
Principle-keeper (what is the real underlying problem?), a Detail-examiner (edge cases,
specifics), an Outsider (state the obvious thing being missed), and an Executor (make the
call). Surface the key tension, then decide. Do not rubber-stamp.

**Rule 2 — Complete application from scratch.** Think like a senior full-stack engineer
building a complete, production-ready application. First design the system architecture,
then develop the minimal-but-scalable version. No scattered snippets — coherent whole.

**Rule 3 — Senior debugging engineer.** When investigating bugs, think like a senior
debugging engineer in production: carefully analyze the code, think step by step, find the
ROOT CAUSE (not the symptom), and propose robust solutions (not temporary patches).

**Rule 4 — Codebase understanding & refactoring.** Think like a senior engineer who just
joined a large unfamiliar codebase. First understand the architecture and data flow. Then
identify: structural problems, duplicated code, performance bottlenecks, maintainability risks.

**Rule 5 — Honesty about limits.** Never pretend to have information not actually held
(e.g. don't invent catalog details, don't claim code compiles if it wasn't compiled, don't
claim to have watched a video). State the limit and work around it. Guessing numbers that
feed product Pass/Fail decisions is forbidden — confirm from the standard.

**Rule 6 — Numbered questions.** When asking the user questions, number them to avoid
ambiguity.

**Rule 7 — No Persian (Farsi) inside code.** Code identifiers and comments are English
only. (Conversation with the user is in Persian.)

**Rule 8 — Output format.** The user often views on mobile inside the Claude app, where the
in-app HTML preview is broken (shows black). HTML mockups must be DOWNLOADED and opened in
Chrome. The final product itself is a Windows desktop app, not mobile.

**Rule 9 — Document first, then ask.** "The document" = THIS handoff PLUS all attached
project manuals/standards listed in §0 (User Guide, catalog, INSO 3132 PDF, Self-check
Hardware Guide, ARCHITECTURE.md, Core zip). ALWAYS consult these before asking the user
anything; many answers are already there (e.g. four graphs §5.4, Results placement, ReL §8,
hardware behavior §11). Only ask on genuine ambiguity not resolved by the document, or when
proposing a NEW idea (with advantages). Default to the document; default behavior =
TRAPEZIUM X unless a better idea is approved (§10). NOTE (Rule 5 honesty): not every listed
file is loaded in every chat — if a needed manual (e.g. the 304-page User Guide) is not
actually present in the current chat, say so and either use the §5 summary (flagged as
approximate) or ask the user to attach it; do not invent its contents.

### 1A. GENERAL ENGINEERING WORKING MODES (user-confirmed standing rules)

These eight modes are standing instructions for HOW to approach a task. They are not a
checklist to run blindly in sequence; pick the mode(s) that fit the request. Several already
exist above (cross-referenced); recorded here together as the canonical set.

**Mode 1 — Complete Application From Scratch.** (= Rule 2.) Think like a senior full-stack
engineer building production-ready software. Deliverable order: system architecture → minimal
but scalable build. A complete answer includes: architecture, file structure, database/data
schema, API/interface contracts, UI architecture, and complete code — not scattered snippets.

**Mode 2 — Codebase Understanding & Refactoring.** (= Rule 4.) Think like a senior engineer
joining a large unfamiliar codebase. First map architecture and data flow; then identify
structural problems, duplicated code, performance bottlenecks, and maintainability risks
before changing anything.

**Mode 3 — Senior Debugging Engineer.** (= Rule 3.) Investigate like a production debugger:
analyze the code, reason step by step, find the ROOT CAUSE (not the symptom), and propose a
robust fix (not a temporary patch).

**Mode 4 — System Design + Implementation.** Think like a senior systems architect: design a
scalable system, then build the minimal production version. Cover: architecture, component
structure, data flow, interface/API design, data schema, caching/IO strategy, and the
implementation code. (For TensileTestX this maps onto the 4-layer Clean Architecture in §3.)

**Mode 5 — Performance Optimization.** Think like a performance engineer. Optimize for three
explicit goals: execution speed, memory usage, and scalability. Measure/identify the hot path
first; do not micro-optimize cold code. (For the live test pipeline: data acquisition loop,
chart redraw, and 50-curve overlay are the candidate hot paths.)

**Mode 6 — Clean Architecture Rebuild.** Convert/restructure code to clean architecture:
separate concerns, increase modularity, reduce coupling. **Behavior stays unchanged — only
structure improves.** (This is the project's core discipline: Core → Data → Application →
Presentation, dependencies point inward only; see §3.)

**Mode 7 — Multi-Agent Workflow.** When requested, operate as four collaborating roles:
**Architect** (design the system), **Engineer** (build it), **Reviewer** (quality control /
find defects), **Optimizer** (improve performance). This complements Rule 1 (Council protocol),
which is for decisions; Mode 7 is for executing a build end-to-end.

**Mode 8 — Production-Level UI Component Builder.** Think like a senior frontend engineer
building reusable, accessible, production-ready UI components. Always account for: loading
states, edge cases, responsive/scaled layout, and accessibility. (For TensileTestX the
"frontend" is WinForms/desktop, not web — apply the same rigor to controls, safety-state
visuals, and the live readouts.)

---

## 2. FIXED TECHNICAL DECISIONS (do not re-litigate)

| Decision | Value | Reason |
|---|---|---|
| Language / runtime | **VB.NET, .NET Framework 4.8** | WinForms + 32-bit COM interop |
| Platform target | **x86 (32-bit)** — mandatory | Facon's Windows interface is a 32-bit component; in-process interop needs a 32-bit host |
| Facon connection | **LAN**, but accessed through Facon's **32-bit Windows interface/driver** (COM) | the 32-bit interface is the binding constraint, not the wire |
| IDE | Visual Studio 2019 | user's environment |
| UI | WinForms | matches TRAPEZIUM X desktop paradigm |
| Database | SQLite (x86 native interop DLL beside EXE) | single-file, simple |
| Architecture | 4-layer Clean + light MVVM | testable without hardware |
| Compression standard | **ASTM E9** | confirmed by user |
| Raw data | **immutable**, stored 1:1, re-analysis recomputes from it | ISO 17025 traceability |
| Real machine | **rebuilt 25-ton frame, now Facon-controlled hardware** | TRAPEZIUM X / Shimadzu docs are UI & behavior reference only (see §11) |
| UI shell priority | **Best-possible UX (modern), not TRAPEZIUM X familiarity** | borrow proven patterns from Instron Bluehill & Zwick testXpert (see §12) |
| UI input target | **Desktop, mouse + keyboard, landscape** | classic WinForms desktop; borrow logic of touch-first tools, not their touch form |

---

## 3. ARCHITECTURE SUMMARY (full detail in ARCHITECTURE.md)

Four layers, dependencies point inward only:

```
Presentation (WinForms + ViewModels)  ->  Application (services)  ->  Core (pure domain)
                                                                        ^
                                              Data (SQLite, Facon, Export) implements Core interfaces
```

Solution projects (all x86):
`TensileTestX.Core` . `.Data` . `.Application` . `.App` (WinForms EXE) . `.Tests`

Core has NO external dependencies and is fully testable with a `FakePlcDevice` that replays
reference data (TENSTAND / synthetic curves) — proving the math before any hardware.

**Build plan milestones:** A Core foundation (done partly) -> B Data layer -> C Application
services -> D Presentation -> E Hardware (FaconPlcDevice last). A–D need no instrument.

---

## 4. DOMAIN MODEL — the reception workflow (user's real lab process)

```
Customer 1--inf Reception 1--inf SampleGroup 1--inf Specimen 1--1 TestResult
                                                    +--1 RawData (immutable)
SampleGroup inf--1 TestMethod inf--1 MaterialGrade
TestMethod  inf--1 Calibration
```

| Our term | Meaning | Shimadzu term |
|---|---|---|
| **Reception** | one customer visit; manual intake number; traceability root | (metadata) |
| **SampleGroup** | requested test set: piece + size + standard + method + qty | **Batch / Lot** |
| **Specimen** | one physical piece, own dimensions, one curve | **Specimen** |

Workflow: New Reception -> pick existing customer (auto-fills) or new customer -> add test
groups (e.g. "5x rebar D12 tensile", "5x rebar D18", "3x bolt M16 tensile", "3x bend") ->
tap a group -> test its specimens one by one. Bolt tests and shear are TestType=Tensile with
a purpose label. Averages/SD at SampleGroup level. A specimen can be marked **Invalid**
(e.g. ISO 3132 fracture in the outer third) and replaced without discarding the group.

---

## 5. TRAPEZIUM X UI — EXTRACTED FROM THE OFFICIAL 304-PAGE USER GUIDE

The app must match TRAPEZIUM X's layout and terminology. Verified facts from the guide:

### 5.1 User guide structure (20 chapters, for reference)
- Ch1 Before Using . Ch2 Execution of Test . Ch3 Test Execution Functions
- Ch4 Method Flow . Ch5 Single Test Method . Ch6 Cycle . Ch7 Control . **Ch8 Texture (food texture method; the definitive Data-Processing-Item reference — fully read into §16)**
- Ch9 Re-Analyzing . Ch10 Printing/Output . Ch11 User Management . **Ch12 Customizing Main Screen**
- Ch13 Various Settings . Ch14 USB . Ch15 Statistical Process Control . Ch16 Old Files
- Ch17 Marker Controller . Ch18 Initial Speed . Ch19 Clearance . Ch20 Texture

### 5.2 Login & three real user roles (Ch1) — replaces our earlier guess
- **admin / admin** -> Administrator (all functions)
- **tester / tester** -> Test supervisor (method creation + test execution)
- **user / user** -> General user (test operations only)

After login -> **[TRAPEZIUMX Home]** window.

### 5.3 Main screen = 7 components (catalog + guide confirmed)
1. **Test Method & Situation Panel** (left): Name (e.g. "1~1"), Stop, Test Speed,
   Full Scale, Break ON/OFF, and buttons: **Next test, New Test, Open Test, Save,
   Input Report Items**, and bottom **"Returns to TRAPEZIUMX Home"**.
2. **Navigation Bar / toolbar**: Save, Open, Preview, Print, Re-Analyze, Re-Test,
   Start, Pause, Stop. Has a **Learning Function** (records user actions, adds frequent
   buttons). Toggle via [View]-[Toolbars]/[Navigation Bar].
3. **Charts (up to 4: Chart1–Chart4)**: see 5.4.
4. **Real-time Data Display Panel** (top): Force, Stroke, (Disp), sensor values — large numbers.
5. **Quick Setting Panel** (right): speed, dimensions, report info entered directly;
   specimen rows table with dimension columns (Name/Thickness/Width/Gauge_Length...).
6. **Result Panel** — TWO tables: **Results (Single)** (one specimen, with arrows to move
   between specimens) and **Results (Batch)** (all specimens: Name/Max_Force/Max_Stroke...,
   with a Print checkbox per row). Supports **Retest, Add test, File merge**.
7. **Checkbox to select display curve** (per result row, toggles its curve on the chart).

Other toggleable windows (from [Window] menu): Quick Setting Panel, Summary, File Logs,
Results(Batch), Results(Single), Chart1, Chart2, Chart3, Chart4. Windows can be
**Tiled Vertically/Horizontally**, resized by dragging frames, and shown/hidden individually.

### 5.3.1 REAL screenshot layout — AUTHORITATIVE (user provided actual TRAPEZIUM X capture)
The mockup must match this EXACT arrangement (the user requires full conformance):
- **Menu bar:** File · Edit · View · Test · Tools · Hardware · Window · Help.
- **Toolbar:** Quick Method List | New | Open | Save · Preview · Print · ReAnalyze · ReTest |
  Start · Pause · Stop.
- **Live band (4 cells, top):** Force (N) · Stroke (mm) · **Disp.** (mm) · **Define Sensor1**
  (a user-DEFINABLE sensor cell — NOT "Stress"). Disp is separate from Stroke.
- **Left column = Situation (a SINGLE seamless machine-status panel — no internal dividers/
  boxes):** top shows a **STATUS ANNUNCIATOR** (NOT a button) — a machine-state indicator
  with a lamp that **blinks** to show the current test state; its label reads the state
  (e.g. "Stop" when stopped). The square is **white/light by default** (as in the screenshot)
  and only takes color / blinks during testing — do NOT tint it green at rest. It is NOT clickable; the actual Stop control is the toolbar
  Start/Pause/Stop. SOURCE NOTE (Rule 5): confirmed by the USER inspecting the real machine
  (and a TRAPEZIUM X video); the 304-page User Guide and web search did NOT document the
  lamp/blink, so this is user-confirmed, not guide-sourced. The annunciator lamp + the
  §5.3.2 window border are TWO views of the SAME `SafetyState` and stay in sync (Arch §7).
  Below the annunciator, continuously (no separating lines): Test Speed (100 mm/min), Full
  Scale (CP / Force / 500 N / 10 N), a direction arrow, Break ON. Then buttons Start Test ·
  Save · Specimen Sizes · Input Report Items · Print · ReAnalyze; bottom "Returns to
  TRAPEZIUMX Home". The whole panel reads as one smooth surface.
  Status grid (2 cols x 3 rows) below the annunciator (NO visible grid lines; exact
  asymmetric per-cell alignment as the user specified, matching the screenshot):
  R1C1 Test Speed label (top-left) | R1C2 value (center-left) + unit (bottom-right);
  R2C1 Full Scale label (top-left) + value (center) + unit (bottom-right) |
  R2C2 CP Force label (top-left) + value (center) + unit (bottom-right);
  R3C1 machine motion-direction arrow (center) | R3C2 Break label (top-left) + ON (bottom-right).
  Motion arrow <- MotionDirection; Break <- method break-detection; speed/full-scale <- method+live.
- **Crosshead jog / positioning control (in the Situation panel) — REVISED to match real
  Shimadzu behavior (web-verified Jun 2026 against TRAPEZIUM X / AG-X docs):** below the
  status grid, a **Position · Jog** box for manual crosshead movement when staging a specimen.
  Three buttons: **▲ Up**, **■ Stop**, **▼ Down**, enabled **ONLY in Setup safety state**
  (greyed + pointer-events off otherwise) — never operable mid-test.
  **KEY CORRECTION (supersedes the earlier Hold/Step "clutch" design, which was wrong):**
  In the real machines, manual positioning is mostly **hardware**, not a software clutch:
  • On Shimadzu frames, **fine positioning is done with a PHYSICAL jog WHEEL on the machine's
    operation panel/controller** (used for jig position in fine increments during bend/compression
    setup) — NOT a software Step button. Our UI keeps a small "⊙ wheel on frame" note to signal
    this; the physical wheel is Facon-hardware territory (Milestone E), not a UI widget.
  • **Jog speed is a PRESET, not a live Fine/Fast clutch.** In TRAPEZIUM X "Jog speed setting"
    is one of the **Hardware Settings** (alongside Soft limit, Speed matrix, Analog I/O cal,
    Force zero hold speed, etc.). Our UI exposes it as a **jog-speed dropdown of presets**
    (0.5 / 2 / 10 / 50 / 200 mm/min) that reads from the Settings "Jog Speed" config entry.
  • **NO software "clutch / Hold-Step coupling mode."** That concept does not exist in the
    source software and has been removed. Up/Down are press-and-hold continuous jog; release
    or ■ stops. (A physical clutch, if any, belongs to the Facon gearbox, not the app UI.)
  • **Built-in safety (web-verified, REQUIRED):** the system **stops jog/return motion
    automatically if the force on the load cell jumps beyond a set amount** (protects specimen/
    jig during staging). UI shows "⚠ force-jump stop armed" in Setup. Also surface **soft-limit /
    stroke-limiter** status ("within soft limit") — soft limit is likewise a Hardware Setting.
  The footer shows live jog state + the force-jump-stop indicator + soft-limit status. The
  motion-direction arrow (R3C1) updates live with jog direction. Speed presets are placeholder
  values in the mockup; real values bind to **Jog Speed / Speed Matrix / Soft Limit** (Settings)
  and ultimately to the Facon motion signals (Up/Down/Stop/Servo + force-jump cutoff, see §11;
  resolved at Milestone E). The "Jog Speed" / "Soft Limit" buttons on the Settings page are the
  config entry points these controls read from.
- **Center = charts, stacked, with these exact tab pairings:** TOP section tabs =
  **Chart1 | Chart4**; BOTTOM section tabs = **Chart2 | Chart3**. (NOT 1,2 / 3,4.)
  Default axes shown = **Force vs Disp.(mm)**. Top chart shows a red elastic line, a MAX
  marker, and a picked point "P[". Bottom chart shows several overlaid colored curves.
  Each chart pane has an **X close button** (windows are closable/toggleable).
- **Right-top = Quick Setting Panel:** [Apply] button; Send Speed (100 mm/min); No. of
  Batches / Qty per Batch; Represent · AutoNo. · Reset No.; specimen table columns
  Name / Thickness[T] / Width[W] / Gauge_Length[GL(0)].
- **Right-bottom = Results(Batch):** header rows Name / Parameter / Pass-Fail / Unit / Print,
  then specimen rows 1-1 … 1-7; each row has a Print checkbox and a curve-toggle icon (◷)
  at left; columns include Elastic / Max_Force / Max_Stroke; param e.g. "Force 1-3 N",
  "Calc. at Entire Areas", unit "N/mm²".
- So: **left = Situation, center = charts, right-top = Quick, right-bottom = Results.**
  Earlier idea of putting Quick/Results on the LEFT is WRONG — they are on the RIGHT.

### 5.3.2 Approved modern additions (kept; user chose to keep — do not fight the layout)
These are NOT in the original screenshot but were approved and may coexist:
- **Safety-colored window border** (ready/setup/test/off), colors configurable in Settings.
- **QuickTest** fast path (lives in/near Method; optional).
- **Right-click on ANY of the 4 charts** -> menu to change that chart's mode/axes
  (Force/Disp/Time/Stress/Strain) and displacement source. ALL FOUR charts get this, in
  addition to the original axis controls. (User requirement.)

### 5.4 Graph behavior (confirmed by user + guide)
- Graph area = **two sections stacked** (top/bottom). Each section has **two tabs** ->
  **4 charts total (Chart1–Chart4)**.
- Each chart's **axes are configurable**: X and Y chosen from Force / Displacement / Time /
  Stress / Strain; and displacement source = **Crosshead or Extensometer** must be specified.
- **Double-click on a chart is REMOVED.** Each chart instead has its own **⛶ maximize
  button** (top-right corner of the chart), matching the ⛶ buttons on the right-column
  panels. Toggle behavior: 1st click = maximize the chart, expanding it to cover the whole
  graph area **AND the right column (Quick Setting + Results)**, stopping at the edge of the
  Situation panel; 2nd click = restore to normal. (Same expand target as §13.3's right-panel
  ⛶, just driven from the chart side.)
- **Point picking**: a bar above the chart shows current point coordinates "X = ... Y = ...".
- A **MAX** marker is shown on the curve.
- Up to 50 curves can be overlaid; per-result checkbox toggles each curve.

### 5.5 Method Wizard (Ch5, "Test Parameter Wizard")
Visual wizard showing the whole process flow, illustrations change with test mode &
material. Step dialogs include: basic settings (**Test mode / Test type**; Force Polarity
& Direction auto-selected; **Unit** common to sensors/charts/results), break detection
(test ends at specimen break), and **[Specimen] dialog**: material, **shape (illustrated)**,
quantity, sizes. Illustration shows which dimensions to enter. Dimensions enterable
manually, via **Excel batch reading**, or **calipers**.

### 5.6 Re-analysis (Ch9) & Reporting (Ch10)
- Re-analyze recomputes from raw (Ch9). Key functions: point picking; **change elastic-line
  slope in a chart** (drag -> Elastic value updates in result window); change analysis
  parameters in the result window; **change Pass/Fail judgment criteria** in the result
  window; change specimen sizes; change data-processing range. Raw is never altered.
- Report Designer: free layout (data, charts, photos, logos); output PDF / Word / Excel / HTML.
- Statistical Process Control (Ch15): XBar-R control charts & histograms over a period,
  by date/specimen/batch.

---

## 6. INSO 3132:2025 — REBAR ACCEPTANCE DATA (from the standard PDF)

Rebar yields **discontinuously** -> report **ReH** (not Rp0.2). The critical extra metric is
**Rm/ReH ratio**. Table 11 values (CONFIRM against print before locking in seed data,
especially S420/S550/C and the ratio column):

| Grade | ReH min (MPa) | Rm min (MPa) | Rm/ReH min | A5 min % | A10 min % | Agt min % |
|---|---|---|---|---|---|---|
| S240 (plain) | 240 | 360 | — | 25 | 18 | — |
| S340 | 340 | 500 | — | 19 | 16 | — |
| S400 | 400 | 600 | — | 16 | 14 | 6 |
| S420 | 420 | (ratio 1.25) | 1.25 | 16 | — | 6 |
| S500 | 500 | 650 | — | 14 | 11 | — |
| S550 | 550 | (ratio 1.25) | 1.25 | 10 | 8 | 6 |
| C (high) | 650 | (ratio 1.15) | 1.15 | 8 | — | 6 |

Key rules: rebar gauge length Lo = 5d (A5) or 10d (A10) — derived from diameter. For d >= 32 mm
the min elongation may be reduced (<=5 percentage points). Tensile test per INSO 4186-1.
Bend test per table 12 (mandrel diameter by bar size). Acceptance uses characteristic value
fk with statistical acceptance (k factor) — Ch17 of the standard.

---

## 7. CORE PROJECT — ALREADY BUILT (in TensileTestX_Core.zip)

Status: **written, not yet compiled** (no VB compiler in the build environment; user must
open in VS 2019 and confirm it builds). Contents:

- `Enums/Enums.vb` — TestType, MotionDirection, YieldBehavior, StrainSource, AnalysisMode,
  FlexureMode, ClutchMode, UserRole, Verdict, SpecimenState.
- `Models/` — Customer, User, Reception, SampleGroup, Specimen, MaterialGrade, TestMethod,
  Calibration, CompliancePoint, SamplePoint, RawDataBlob, TestResult, GroupStatistics,
  AppSettings, SafetyState.
- `Units/UnitConverter.vb` — FULL BODY (kgf<->N<->kN, StressMPa, StrainPct, RoundAreaMm2).
- `Analysis/RegressionHelper.vb` — FULL BODY (OLS fit, R2, slope std error) + LinearFit.
- `Abstractions/Interfaces.vb` — IPlcDevice, ITestRepository, ITestCalculator, ITestExporter.
- `TensileTestX.Core.vbproj` — .NET 4.8, x86, Option Strict On.

**First action in new chat:** have the user open Core in VS 2019 and report any compile
errors; fix via Rule 3 (root-cause). THEN proceed to Milestone A step 4.

---

## 8. NEXT STEPS (Milestone A, then onward)

A4. `TestTypes/TensileCalculator.vb` + YieldCalculator/StrengthCalculator/
    ElongationCalculator + `AnalysisPipeline` (rebar: ReH/ReL/Rm/ratio/A). FULL bodies.
A5. `FakePlcDevice` + `TensileTestX.Tests` replaying a known curve, asserting computed
    values match reference (TENSTAND / synthetic). This proves the math.
B.  SQLite Database + schema (immutable RawData) + repositories + TenstandCsvExporter.
C.  AuthService, CustomerService, ReceptionService, TestRunner.
D.  WinForms: Reception list/detail -> Test screen (7-component layout, 4 charts, per-chart
    ⛶ maximize button) -> Method Wizard -> Report.
E.  FaconPlcDevice (32-bit COM over LAN) swapped in at the composition root.

**ReL definition — CONFIRMED (was the A4 blocker).** Per ISO 6892-1 (INSO 3132 / INSO
10272 are the Persian translations of the ISO, so the ISO definition governs):
**ReL = lowest force value in the yield region AFTER ignoring the initial transient effect**
— NOT the first local minimum after the yield drop. Implementation in `YieldCalculator`:
skip the initial transient points of the drop, then take the minimum over the remaining
yield plateau. No guessing involved; matches the standard.

---

## 9. OPEN ITEMS REQUIRING USER/SUPERVISOR INPUT

1. Confirm INSO 3132 Table 11 numbers from print (S420/S550/C, Rm/ReH column).
2. ISO 9969 ring-stiffness formula constants (catalog not on hand).
3. ~~Facon COM specifics: exact ProgID, register addresses, motion bits, clutch control.~~
   **✅ RESOLVED (user supplied the Facon/Fatek PLC communication architecture).** Full address
   map, COM server, comm loop, calibration, and command sequences are now documented in
   **§14 (canonical hardware source of truth)**. This was needed only at Milestone E and is now
   ready for it. NOTE: this also CORRECTS earlier mockup notes that said "no software clutch" —
   a clutch (gear ratio) DOES exist on this machine via M10/M11 (see §14).
4. .NET 4.8 confirmed; VS 2019 confirmed.
5. **(§17) Sensors:** confirm extensometer measuring ranges (travel) for SG-25/50/100; confirm
   whether Facon reports mounted load-cell identity (auto-ID) vs trusting the method selection.
6. **(§17) ASTM:** confirm exact D732/D1894 specimen geometry, speed, and reporting from the
   purchased ASTM text before locking ShearPunch/Friction acceptance logic.

---

## 10. UI SHELL — FROZEN STRUCTURE (Style A locked)

**Guiding rule (NEW, user-confirmed).** The default for every behavior and layout is
**whatever TRAPEZIUM X does**, unless a better idea is proposed WITH its advantages and
explicitly approved. Lower risk; the operator's habits transfer.

**Style decision.** Two styles were mocked (A = TRAPEZIUM X faithful, sourced from the
user's Shimadzu manuals; B = modern, inspired by Bluehill/testXpert but NOT in the user's
docs). **User chose Style A** to avoid risk (B was unverifiable against owned sources).
Keep the modern *logic* already agreed (QuickTest, safety-colored border, role-based view,
right-click chart shortcut) only where it does not fight Style A's familiarity. Charts
themselves follow the original: four graphs (§5.4), not one big chart.

**Spine = 6 pages (FROZEN):**
`Reception › Test › Method › Calibration › Settings › Report`

**Placement of every element (resolves the gaps the user caught):**
- **Test method selection** -> shown per group in **Reception** (Method column); full
  create/edit lives in the **Method** page (Wizard). Matches TRAPEZIUM X (methods are files
  opened/created from Home).
- **Method (Wizard) page** -> basic settings, break detection, specimen (material/shape/
  sizes, illustrated), limits & speed, review. **Sampling / number of stored points lives
  HERE** (it's part of the method in TRAPEZIUM X). Default = **fixed-rate** (device default);
  an **adaptive** option exists but is **OFF by default** (denser sampling near yield/break,
  sparser in elastic region — advantage: cleaner yield region where Pass/Fail is decided,
  smaller raw; kept off by default to protect immutable-raw re-analysis).
- **Machine stiffness / compliance correction** -> **Calibration** page (device-level
  setting, not method-level): a force-vs-machine-deflection curve subtracted from raw.
  Model `CompliancePoint` already exists (§7).
- **Calibration page** -> Zero / Span / E-CAL per channel + machine compliance/stiffness.
- **Settings page** -> units, speeds, soft limits, Force Zero Hold, safety-border colors
  (configurable, per user request), users & roles, export defaults.
- **Report page** -> output PDF/Word/Excel/HTML + designer. **Tentative**: Report is NOT in
  the Self-check manual the user owns; based on §5.6 (User Guide Ch10, not in hand). Flag as
  approximate until the User Guide is consulted.

**Test page (Style A) = the 7 TRAPEZIUM X components** (§5.3), with charts FAITHFUL to the
original: **FOUR graphs** = two stacked sections × two tabs each (Chart 1–4), per §5.4.
Each graph has its OWN axis dropdowns (X/Y from Force/Displacement/Time/Stress/Strain) and
displacement-source selector (crosshead/extensometer). **Right-click on a chart is an
added shortcut** to the same mode switch (kept as convenience, does not replace dropdowns).
Each chart has a **⛶ maximize button** (no double-click); clicking it expands the chart over
the graph area **and the right column**, up to the Situation panel edge; click again to
restore — per §5.4. Point-picking "X=… Y=…" bar above charts. MAX marker on curve.

**Results panel placement (FAITHFUL — user correction):** Results (Single + Batch) sits at
the **right-bottom**, NOT a full-width bottom band. The right column splits vertically:
**Quick Setting (top) + Results (bottom)**. **Both right panels have a ⛶ full-screen button**
that expands the panel leftward up to the edge of the Situation panel (covering the charts),
per user request. The earlier "one big chart" idea is DROPPED — original = four graphs.

**Mockup file:** `tensile_shell.html` — open in Chrome (in-app preview shows black).
Currently contains an A/B switch + 5 pages; **next revision: drop B, go 6-page Style-A,
add Method page (with sampling) and machine-compliance in Calibration.**

**Still pending in mockup:** Report page is approximate (limited source); confirm against
the 304-page User Guide when available.

### 10A. MOCKUP LOCKED SNAPSHOT — v1 (user said "lock it here", current session)

The Test-screen mockup is **locked** at this state. Locked copy: `tensile_shell_LOCKED_v1.html`
(working file remains `tensile_shell.html`). Changes baked in and frozen at this point:

- **Live band** = 5 cells: **Name (200px, first) · Force · Stroke · Disp. · Define Sensor
  (320px, aligned with the right column below it)**. Labels 14px, top-left, following the
  other columns; big 46px mono values; units bottom-right. Name label top-left, value centered.
- **Rate readout**: the configurable 4th cell can show **Stress rate (MPa/s)** and **Force
  rate (kN/s)** via the click-to-switch picker (engine channels `StressRate_MPa_s`,
  `ForceRate_kN_s`).
- **Charts**: double-click REMOVED; each chart has a **⛶ maximize button** that expands it
  over the charts area + right column up to the Situation edge. **Chart tabs switch** (Chart1/4,
  Chart2/3). **Right-click context menu** repositioned to fixed/viewport coords (reliable).
  **Mouse-hover crosshair + coordinate tooltip** and **numbered X/Y axes** added.
- **Run button** state-aware: ▶ Start Test ↔ ■ Stop Test (red) by safety state; disabled when
  Disconnected.
- **Left Situation panel**: status grid (Test Speed · Full Scale: 500 N · **CP/Force** live ·
  Break) — `CP` and `Force` are ONE label for the live force channel cell (taken from the real
  screenshot; NOT invented; true meaning of "CP" still to be confirmed from the machine/Facon
  docs). Three visually separated zones with divider lines + symmetric spacing: **status │ jog │
  Start–Print**; status grid has symmetric top/bottom spacing. Bottom group (ReAnalyze + Return
  Home) pinned to the floor.
- **Jog moved into a separate modal window** opened by the **⊙ Position · Jog** button. Modal
  has ▲/■/▼, a **jog-speed preset dropdown** (Hardware-Settings value, NOT a Fine/Fast clutch),
  force-jump-stop + soft-limit indicators, and a physical-jog-wheel note. Enabled only in Setup;
  closes on ✕ / backdrop / Esc. (Software Hold-Step "clutch" was removed — see §1A/jog notes.)
- **Right column**: Quick Setting and Results each **50%** height, so Quick Setting's height
  matches the top chart.

Any further change starts from this locked v1; record new deltas as 10B, 10C, …

### 10B. MOCKUP LOCKED SNAPSHOT — v2 (user said "lock it" after jog redesign + live-band fixes)

Locked copy: `tensile_shell_LOCKED_v2.html`. Deltas on top of v1:

- **Jog modal redesigned around a speed VOLUME KNOB** (replaces the old preset dropdown):
  - Shapely SVG knob (gradient face, rim shadow, indicator dot, active arc). **Graduated with
    NUMBERS** on a logarithmic scale — labelled ticks at 0.1/0.5/1/5/10/50/100/500, minor ticks
    between decades. Drag up/down to set speed. Knob enlarged (168px).
  - **Editable speed box** next to the knob: type the exact speed; **no spinner arrows**; text
    **centered**. Knob + box stay in sync.
  - **Clutch** selector OFF / 1:1 / 1:10 (label is just "Clutch"). Clutch is a **speed divider**:
    1:1 = shown speed, 1:10 = speed ÷ 10, OFF = no motion. An "effective …" line shows the
    resulting motion speed.
  - **SAFETY LOCK on speed vs clutch:** max settable speed depends on clutch — **1:10 caps at
    50**, **1:1 (and OFF) cap at 500**. Enforced on typing, knob drag, and on clutch change
    (switching to 1:10 auto-clamps a too-high speed down to 50). Selecting OFF also stops motion.
  - **Latched direction buttons:** ▲/▼ = press once to START; motion continues (button stays
    lit, ■ Stop blinks red) until ■ Stop is pressed. (Matches the machine's black UP/Down panel
    buttons; the removed Hold/Latch toggle is gone — Stop + clutch-OFF are enough.)
  - All visible PLC text removed from the UI (R500/M61/M62/M10/M11 live only in code comments).
  - Note clarifies clutch+speed are machine-wide (the physical panel obeys them too) — see §14.14.
- **Live band last cell (configurable readout) fixed:** clicking `Define Sensor1 ▾` opens the
  picker (Define Sensor / Time / Stress rate MPa/s / Force rate kN/s / Strain / Extensometer /
  Aux). Value is centered, **unit sits bottom-right** like the other cells. The cell no longer
  overflows or stretches past the right edge (the band stays aligned with the right column);
  long readouts like "MPa/s" use a slightly smaller value font. Fixed an event-bubbling bug that
  reopened the menu on selection.

Any further change starts from locked v2; record new deltas as 10C, 10D, …

---

## 11. TRAPEZIUM X HARDWARE GUIDE — BEHAVIOR REFERENCE ONLY (Shimadzu AG-X self-check/settings guide)

**Critical framing (Rule 5).** The real machine is a **rebuilt 25-ton frame now driven by
Facon hardware**. The Shimadzu *Hardware Self-check & Settings Guide* (AG-X/AGS-X/EZ-X) is a
**behavioral and UI reference only** — it is NOT a source of Facon addresses, ProgIDs, or
register maps. Do not hardcode any Shimadzu-specific hardware number as if it were a Facon fact.

### 11.1 VALID as general behavior (informs `IPlcDevice` + `SafetyMonitor`, hardware-agnostic)
- **Sensor channels (generic concept):** Force, Stroke, Channel1, Channel2 (internal amps),
  Aux1–Aux6, Digital1/Digital2. Confirms our `StrainSource` enum.
- **Displacement source:** Crosshead (Stroke/Position) vs Extensometer (via Channel/Aux).
  Confirms the pipeline's strain-source branch.
- **Unit system selectable:** SI / Metric (kgf) / lbf. Confirms our fixed decision
  (raw stored in kgf, conversion centralized in `UnitConverter`).
- **Soft-limit logic (safety):** independent min/max per channel.
  - Force range = `[-load-cell capacity] ... [+load-cell capacity]`
  - Stroke range = `-9999.0 ... 9999.0`
  - Aux/strain range derived as `Full scale = Gauge Length x Full Scale(%) / 100`,
    entry range `[-FS ... +FS]`.
  - **Precedence rule:** during a test, Method-Wizard limits apply; the hardware-dialog soft
    limits apply only when not testing / during hardware setup. `SafetyMonitor` must honor this.
- **Force Zero Hold:** specimen-protection function that holds force at 0 at a configured low
  speed before test. Belongs in method / `SafetyState`.
- **Conceptual motion/control signals** (to be exposed by `IPlcDevice`): Stop, Servo ON, Up,
  Down, Return, Zero Position, Alarm Activating.
- **Self-check item set (validation reference for E-stage acceptance):** motor pulse, sensor
  amplifier, board power, emergency switch, limit switch, analog out/in, operation sound,
  crosshead stroke/positioning/speed, force measurement. A checklist when validating the
  Facon build, not code.

### 11.2 NOT VALID for Facon (Shimadzu-specific — do NOT hardcode)
- F-CAL / E-CAL range multipliers (x1...x100), E-CAL message flow.
- Contact I/O pin numbers/assignments (ACC1/ACC2).
- ProgID, COM port specifics, register addresses, motion bits.

These are Shimadzu internals. The Facon build has its own address map and motion bits —
**now documented in §14** (supplied by the user from the actual machine code).

### 11.3 Effect on open items
- **Open Item #3 is now RESOLVED — see §14.** This Shimadzu guide (§11) clarified *expected
  behavior* only; the *actual Facon* ProgID, register/marker map, motion bits, and clutch
  (gear-ratio) control are now provided in §14, which is the canonical hardware source. Where
  §11 (behavior) and §14 (real addresses) overlap, **§14 wins for anything concrete**; §11
  stays useful only for UI/behavior intent.
- No change to Milestones A–D, which need no instrument. §14 unblocks Milestone E.

---
## 12. PROFESSIONAL-SOFTWARE UI PATTERNS TO BORROW (Instron Bluehill + Zwick testXpert)

**Decision (§2):** target the *best-possible modern UX*, not TRAPEZIUM X familiarity.
Run on **desktop, mouse + keyboard, landscape**. We borrow the **logic/behavior** of these
touch-first tools, NOT their physical touch form (no portrait layout, no oversized
touchpoints, no pinch gestures — translate to mouse equivalents: pinch-zoom -> wheel-zoom,
touchpoint -> normal button with hover state).

### 12.1 Patterns from Instron Bluehill Universal
- **QuickTest:** a one-tap path for routine tests — operator enters only test speed +
  specimen dimensions and hits Start; a pre-defined graph + results table populate
  (Max Force, Displacement at Break, etc.). Sits ALONGSIDE the full Method Wizard. Ideal
  for daily repetitive rebar tests; the wizard is only for new/unusual setups.
- **Safety-state colored screen border:** the window border changes color to signal machine
  state (e.g. blue = Setup, with jog limited to a safe speed). Makes safety state instantly
  visible instead of buried in a menu. Wire directly to our `SafetyState` / `SafetyMonitor`.
- **Unlimited, freely-arranged Live Displays:** large live readouts for force/displacement/
  time/results + multiple graphs in one fully-customizable workspace. More flexible than
  TRAPEZIUM X's fixed panels; pairs with our 4-chart area.
- **Results table with subsample sorting:** sort/group results by any parameter (operator,
  specimen break location, etc.). Directly serves our Valid/Invalid specimen handling
  (ISO 3132 fracture in the outer third).

### 12.2 Patterns from Zwick testXpert III
- **Workflow-based architecture:** the UI mirrors the lab's real process and guides the user
  step by step (prepare -> run -> analyze). Maps 1:1 onto our Reception -> SampleGroup ->
  Specimen flow. The shell should express this flow, not present one crowded screen.
- **Test settings separated from system settings:** test-relevant settings are grouped and
  kept separate from general machine settings. Aligns with our 3-layer config brain
  (Global -> Method -> Specimen overrides).
- **System Configuration Builder (safety):** safety settings saved per application/test type,
  enabling reproducible, locked test conditions. Define each test type's safety envelope once.
- **Role-based views:** each user sees only what they need; operators are kept away from
  method-building complexity. Maps onto our three roles (admin / tester / user).

### 12.3 How these shape the TensileTestX shell
The shell = testXpert-style **workflow spine** (Reception -> Group -> Specimen) +
Bluehill **QuickTest** for routine rebar (full Wizard only for new setups) +
Bluehill **safety-colored border** bound to `SafetyState` +
flexible **Live Display + 4-chart** workspace +
**sortable results table** for Valid/Invalid management +
**role-based** visibility (operator shielded from method internals).
All rendered as classic landscape WinForms for mouse/keyboard.

---

## 13. COMPLETE UI ARCHITECTURE & RELATIONSHIPS (extracted from the 304-page User Guide, 349-02787H)

This section captures the whole guide's architecture so the heavy PDF need NOT be reopened.
Source: TRAPEZIUM X User's Guide, 17 chapters. Authoritative for UI behavior & relationships.

### 13.1 Guide chapters (the functional map)
1 Before Using (install, startup, login, Home) · 2 Execution of Test · 3 Test Execution
Functions · 4 Flow of Method Create/Edit · 5 Creating Single Test Method · 6 Cycle Method ·
7 Control Method · 8 Texture Method · 9 Re-analyzing Result · 10 Printing/Output ·
11 User Management · 12 Customizing Main Screen · 13 Various Settings · 14 USB Memory ·
15 Statistical Process Control · 16 Old Files · 17 Marker Controller.

### 13.2 Top-level navigation graph (screen relationships)
```
[TRAPEZIUMX Home]  (after login: admin/tester/user — Ch1, Ch11)
   ├─ Create/Open Method ─► [Method Wizard] (Ch4–5) ──┐
   ├─ Select method & test ─► [Main Test Screen] ◄────┘ (uses the method)
   │        │  run → [Result] window (Ch2)
   │        │  re-analyze → back into Method Wizard (Ch9, recompute from raw)
   │        └─ print/export → [Report] (Ch10)
   ├─ User Accounts (Ch11) · Hardware Settings (hardware guide) · Various Settings (Ch13)
   └─ USB (Ch14) · SPC (Ch15) · Old Files (Ch16)
```
Key: the **method** is the contract between Wizard (defines) and Test screen (consumes).
Raw is immutable; **Re-analyze re-runs the Wizard pipeline on stored raw** (Ch9), never alters raw.

### 13.3 Main Test Screen — the 7 components and how they INTERRELATE
Layout (confirmed by the user's screenshot, §5.3.1): left **Situation**, center **Charts**,
right-top **Quick Setting Panel**, right-bottom **Result window**. Data relationships:
- **Situation panel** (left): controls the run (Start/Stop/Next), shows method name, speed,
  full scale, break ON/OFF. Drives the machine via the PLC interface.
- **Live Data band** (top, 4 cells): Force / Stroke / Disp / a **definable cell**
  ("Define Sensor1"). Fed live from the instrument during a run; also feeds the live chart.
  IMPORTANT (user-confirmed): the definable cell is **configurable in Settings** and can be
  switched to show different quantities — not only a physical sensor, but also **Time**, a
  strain/extensometer channel, an Aux input, a **calculated value**, and **rates** such as
  **MPa/s** (stress rate) and **kN/s** (force rate). So treat the 4th cell (and potentially
  others) as a **user-selectable readout slot**, bound to a configurable source, defined in
  Settings. UI: clicking the cell opens a small picker of available quantities.
  **RATE DISPLAY (user-confirmed, REQUIRED):** beyond Time and Stress, the live readout must
  be able to show **test rate** in both **MPa/s** (stress rate) and **kN/s** (force rate).
  These are first-class options in the cell picker (not buried), computed as the time
  derivative of stress and force respectively over the live data stream. Engine: the live
  pipeline must expose `StressRate_MPa_s` and `ForceRate_kN_s` as calculated channels (Core
  layer) so any readout slot — or a future dedicated rate cell — can bind to them.
  DISTINCTION (important for the pipeline): **Stroke** = crosshead travel (machine motion,
  includes machine compliance); **Displacement (Disp)** = specimen displacement, sourced
  EITHER from crosshead (approximate) OR from extensometer (accurate) per `StrainSource`
  (§11.1); the **definable cell** = configurable (sensor / Time / Aux / calc). For rebar, the
  extensometer is normally the accurate displacement source (set in the Method Wizard
  [Sensor] dialog, §13.5). Live cell numbers are center-aligned; labels stay at top.
- **Charts** (center, up to 4: Chart1–4): plot live during test and stored curves after.
  Each chart is independent (own axes/overlay). See 13.4.
- **Quick Setting Panel** (right-top): the always-visible fast editor — speed, No. of
  Batches, Qty/Batch, and the **specimen size table** (Name/Thickness/Width/Gauge_Length).
  Editing sizes here is one of THREE ways to set sizes (the others: [Test]-[Specimen Sizes]
  dialog, or via Re-analyze/Method Wizard). Changes here flow to area/stress and to results.
- **Result window** (right-bottom): Results(Single) + Results(Batch). Each specimen row has
  a **Print checkbox** and a **curve-display toggle**. Selecting/double-clicking a specimen's
  left column targets it for the chart and for re-test. THIS is the specimen↔curve link.

### 13.4 Chart behavior — COMPLETE (Ch5 [Chart] dialog + Ch9 right-click menu)
THE KEY MECHANISM the user asked about — overlay by specimen selection:
- **Overlay (superimpose several curves):** controlled by the **[Chart] dialog** (Ch5) and by
  the **right-click "Overlay" checkbox** on the chart (Ch9). When Overlay is ON, the curves of
  the specimens selected/checked in the Result window are drawn **superimposed on the same
  chart** (the guide: "display several curves simultaneously (overlay)"). When Overlay is
  OFF, the chart shows only the single specimen selected in the result window.
- **So the relationship is:** Result window specimen selection / row curve-toggle ⇒ which
  curves appear on a chart; the chart's Overlay flag decides single-vs-superimposed. Up to
  50 curves can be overlaid. (This is what must be wired: checking specimens in Results adds
  their curves to the chart when Overlay is on.)
- **Right-click chart menu (full list, Ch9):** Overlay (on/off) · Point Picking Axis1/Axis2 ·
  Data processing parameters · Elastic Adjustment (drag elastic line → Elastic value in
  result updates) · Property (X axis / Y axis: choose Force/Disp/Time/Stress/Strain, scale) ·
  Data Processing Area Specification · Peak/Valley Calc. Area Specification · Average curve
  per Batch · (print chart). ALL FOUR charts expose this menu. This is "change to all modes".
- **Point picking:** right-click → Point Picking Axis, drag to a point, right-click to set;
  used to override auto-detected points (e.g. upper yield). Changed result cells highlight yellow.
- **Chart ⛶ maximize button:** expands the chart over the graph area **and the right column**
  (Quick Setting + Results), stopping at the Situation panel edge; toggle to restore (§5.4).
- Default axes in the real screen = Force(N) vs Disp(mm); elastic line drawn; MAX marker; "P[".

### 13.5 Method Wizard — the 7 dialogs (Ch5), in order
1 **[System]** (test mode/type, unit) → 2 **[Sensor]** (force/stroke limits, sensor type,
extensometer) → 3 **[Testing]** (machine operation: speed, end-at-break) → 4 **[Specimen]**
(material, shape illustrated, quantity, sizes) → 5 **[Data Processing Items]** (which metrics
to compute: Max_Force, Elastic, etc., and Pass/Fail criteria — "Enabled" + upper/lower limits)
→ 6 **[Chart]** (scale, overlay on/off, axes) → 7 **[Report]** (report content + layout).
This wizard is reused by **Re-analyze** (Ch9) to recompute stored raw with changed settings.

### 13.6 Result analysis & output relationships (Ch9–10)
- **In the result window you can change (re-analysis, recomputed from raw):** analysis
  parameters; Pass/Fail criteria (result + verdict update live); printing order & print
  on/off; specimen sizes; data-processing range. Changed cells highlight yellow.
- **Re-test** a specimen: double-click its left column, or right-click → "Re-Test this
  specimen"; result overwrites in the same column. **Insert / Add Specimen** via right-click
  in the result window.
- **Print/Export (Ch10):** quick-print a single chart or single result table via right-click
  in that pane; full Report via the Report designer (PDF/Word/Excel/HTML per §5.6).
- **SPC (Ch15):** XBar-R control charts & histograms across batches/dates.

### 13.7 What this means for TensileTestX (build implications)
- Wire **Result-window specimen check/toggle → chart curves**, gated by a per-chart **Overlay**
  flag (right-click menu). Default behavior mirrors TRAPEZIUM X (Rule 9 / §10).
- Each of the 4 charts needs its own right-click menu with the full list in 13.4.
- Method = the 7-dialog wizard (13.5); Re-analyze reuses it on immutable raw.
- Three size-entry paths (Quick Panel / Specimen Sizes dialog / Re-analyze) all converge on
  the same specimen sizes → area/stress recompute.


continue from Milestone A step 4 (TensileCalculator). The ReL question is now CLOSED (§8);
UI direction is CLOSED (§2, §12). Facon COM specifics are now CLOSED (§14). The remaining
blocker is only the INSO Table 11 numbers (§9 #1); everything needed for Milestone E hardware
integration is now documented in §14.*


---

## 14. FACON / FATEK PLC COMMUNICATION ARCHITECTURE — CANONICAL HARDWARE SOURCE OF TRUTH

*Supplied by the user from the actual machine's working code. This RESOLVES Open Item #3 and
supersedes every earlier "to be determined at Milestone E" placeholder for Facon specifics.
Where this section and §11 (Shimadzu behavior guide) disagree on anything concrete, §14 wins.*

### 14.1 Connection & transport
- **COM Server (OPC/ActiveX driver):** `FaconSvr.FaconServer` — the driver for the **Fatek/Facon**
  PLC. Held in a global `Facon_server As Object`.
- **PLC project file:** `Autograph_svr.fcs`, located in the app execution directory.
- **Init sequence:** `CreateObject("FaconSvr.FaconServer")` → `OpenProject("[AppPath]\Autograph_svr.fcs")`
  → `Connect()`.
- **Channel name (all commands):** `"Channel0.Station0"`.
- **Two groups:** `Group_read` (reads), `Group_write` (writes).
- This is the **concrete ProgID + transport** that §3 of the spec abstracts as "32-bit COM".
  ProgID = `FaconSvr.FaconServer` (confirmed). Still a 32-bit in-process COM component → keeps
  the **x86 mandatory** decision (§2) valid.

### 14.2 Read / write primitives
- **Read:** `Facon_server.GetItem(channel, address)` → returns a STRING; convert with `Val()`.
  e.g. `GetItem("Channel0.Station0.Group_read", "R32")`.
- **Write:** `Facon_server.SetItem(channel, address, value)` → returns a Byte.
  e.g. `SetItem("Channel0.Station0.Group_write", "M61", 1)`.

### 14.3 READ map (Group_read)
| Addr | Type | Meaning | Notes |
|---|---|---|---|
| R20 | R | Displacement low word | low 16 bits |
| R21 | R | Displacement high word | real value = 65535 × R21 + R20 |
| R25 | R | Test time (×100 ms) | Test_Time = R25 / 10 (seconds) |
| R32 | R | Force (raw) | × Force_Factor[loadcell] |
| R37 | R | Deformation/extensometer (raw) | × Extensometer_Factor[ext] |
| T55 | T | Programmable test hold timer | |
| M6  | M | Manual handwheel active | |
| M20 | M | E-stop (panel) | |
| M40 | M | Displacement sign | 0 = negative, 1 = positive |
| M41 | M | Force sign | 0 = negative, 1 = positive |
| M42 | M | Deformation sign | 1 = negative |
| X14 | X | E-stop main (digital input) | |

### 14.4 WRITE map (Group_write)
| Addr | Type | Meaning | Values |
|---|---|---|---|
| M0    | M | PLC watchdog reset | pulse 1 every 50 cycles to keep PLC alive |
| M4    | M | Brake active | 1 = brake on, 0 = off |
| M10   | M | Clutch bit 0 | gear-ratio (table 14.7) |
| M11   | M | Clutch bit 1 | gear-ratio (table 14.7) |
| M30   | M | Reset force (tare) | 1 = zero the load cell |
| M31   | M | Reset deformation | 1 = zero the extensometer |
| M50   | M | Test timer start/stop | 1 = start, 0 = stop |
| M51   | M | Test timer reset | 1 = reset |
| M52   | M | Programmable hold timer | 1 = start, 0 = stop |
| M60   | M | Test mode / manual mode | 1 = test, 0 = manual |
| M61   | M | Crosshead up | 1 = move up |
| M62   | M | Crosshead down | 1 = move down |
| M63   | M | Auxiliary stop | 0 = off |
| M64   | M | Auxiliary stop | 0 = off |
| M1941 | M | Reset displacement | 1 = zero the position |
| R500  | R | Crosshead speed | written value = Crosshead_Speed × 10 |

### 14.5 Communication loop (10 ms Windows timer `TimerReadTick`)
Every 10 ms: read TestTime (R25/10), Force (R32 × factor, sign M41), Displacement
((65535×R21+R20) × factor, sign M40), Deformation (R37 × factor, sign M42, if enabled).
Then: **Sampling check** — if Test_mode ∈ {ON, HOLD} and Sampling_Counter > Sampling_Period/10,
increment sample no., grab one sample (store + compute stress/strain), draw online graph, write
sample to file; else increment counter. **Watchdog** — if Communication_Check_Counter > 50,
SetItem M0 = 1; else increment. **Read status** — X14, M20, M6. **Load high-limit check** — if
|Force| ≥ Limit[loadcell], call Test_Over() (emergency stop).

### 14.6 Calibration (raw → physical)
- **Force** = Force_raw × Force_Factor[loadcell]; if Force_Sign = 0 → ×(−1).
  Loadcell index: 0=5 kgf, 1=100 kgf, 2=500 kgf, 3=2 Tf, 4=10 Tf, 5=25 Tf.
  > **SUPERSEDED for the current machine — see §17.1.** This 6-cell / 50 mm-extensometer layout
  > is the LEGACY Shimadzu code. The rebuilt machine has 5 load cells (100 kg…25 t) and
  > SG-25/50/100 (gauge 25/50/100 mm). Use §17 for physical inventory and gauge lengths.
- **Displacement_raw** = 65535 × R21 + R20 (32-bit split over two 16-bit registers);
  Displacement = raw × Displacement_Factor; if Displacement_Sign = 0 → ×(−1).
- **Deformation** = raw × Extensometer_Factor[ext]; if Deformation_Sign = 1 → ×(−1).
  Ext index: 0=50mm/0.5mm, 1=50mm/10mm, 2=50mm/100mm.
- **Stress = |Force| / Sample_Area**; **Strain = (|Displacement| / Sample_L0) × 100 [%]**.
  (Stress/strain are SOFTWARE-computed, not from the PLC — they belong in the Core layer.)

### 14.7 Clutch / gear ratio (M10 + M11)
| State | M10 | M11 | Meaning |
|---|---|---|---|
| OFF  | 0 | 0 | clutch disengaged |
| 1/1  | 1 | 0 | 1:1 (full speed) |
| 1/10 | 0 | 1 | 1:10 (fine) |

### 14.8 Test control command sequences
- **Test Start:** M60=1 (test mode); M61=1, M62=0 (up); M50=1 (timer start); M1941=1 (reset disp);
  M31=1 (reset deformation).
- **Hold:** M61=0, M62=0, M63=0, M64=0, M4=1 (stop with brake).
- **Test Over:** stop-with-brake; M50=0 (timer stop); M51=1 (timer reset); M60=0 (manual mode).
- **Manual down (compression):** M61=0, M62=1.
- **Stop, no brake:** M61=0, M62=0, M63=0, M64=0, M4=0.
- **Tare force:** M30=1.
- **Set speed:** R500 = Crosshead_Speed × 10.
- **Clutch:** OFF→M10=0,M11=0 · 1/1→M10=1,M11=0 · 1/10→M10=0,M11=1.

### 14.9 Persisted settings — `Autograph.INI` (app dir)
- **[MachineSettings]:** Crosshead_Speed (mm/min), clutch_State (0/1/2), Test sample time (ms),
  Loadcell Number (0–5), Extensometer Number (0–2).
- **[Calibration]:** Force_Factor_5K … Force_Factor_25T (6), Displacement_Factor (1),
  Extensometer_Factor_0/1/2 (3).
- **[Limits]:** Load Limit on 5k … Load Limit on 25T (6) — per-loadcell max load.

### 14.10 Critical engineering notes (carry into the rebuild)
1. **Watchdog ≤ 500 ms:** PLC faults if it doesn't get an M0 pulse within ~500 ms. Current
   code: every 50 cycles × 10 ms = 500 ms. In the rebuild this is a HARD real-time constraint —
   the watchdog write must never be starved by UI/GC pauses.
2. **Displacement is 32-bit split:** value = 65535 × R21 + R20. (NB: literally 65535, not 65536,
   as written in the source — preserve exactly; verify against the machine before "fixing".)
3. **Signs are separate bits:** magnitudes are always positive; direction lives in M40/M41/M42.
4. **Speed scaling:** R500 = display speed × 10. Don't double-apply.
5. **Test vs manual are mutually exclusive:** M60=1 (auto) XOR M60=0 (manual); never both active.
6. **Modernization path:** if the PLC is later upgraded, Fatek OPC UA or Modbus TCP can replace
   the ActiveX COM driver — but ONLY behind the `IPlcDevice` interface, never leaking into Core.

### 14.11 Mapping onto Clean Architecture (where each thing lives)
- **Core (domain):** calibration math (raw→Force/Disp/Deformation), Stress/Strain formulas,
  loadcell/ext index → factor selection, sign application, high-limit comparison logic. Pure,
  no COM. These are unit-testable without hardware.
- **Data/Hardware layer — `FaconPlcDevice : IPlcDevice`:** owns `FaconSvr.FaconServer`,
  OpenProject/Connect, GetItem/SetItem, the address constants (R/M/X/T/R500), the 10 ms timer,
  and the watchdog. Exposes clean methods: `ReadForce()`, `ReadDisplacement()`, `MoveUp()`,
  `MoveDown()`, `StopWithBrake()`, `StopNoBrake()`, `SetSpeed(mmPerMin)`, `SetClutch(state)`,
  `TareForce()`, `StartTestTimer()`, etc. Raw register addresses NEVER appear above this layer.
- **Application:** the sampling/test orchestration (start→sample loop→over), Sampling_Period
  gating, and turning device readings into samples + invoking online graph/file writes.
- **Presentation (mockup §10A):** Start/Stop, jog modal, speed/clutch selectors, live readouts,
  safety state — all talk to Application/`IPlcDevice` abstractions, never to GetItem/SetItem.
- **INI** maps to a settings provider in the Data layer (Calibration + MachineSettings + Limits),
  surfaced to Settings UI; factors/limits are injected into Core calc, not hardcoded.

### 14.12 CORRECTIONS this section forces on earlier notes
1. **Clutch DOES exist (hardware).** Earlier mockup notes (§10A and the jog-modal note) said
   "no software clutch — a physical clutch belongs to the Facon gearbox." §14 confirms the gear
   ratio is real and is driven by **M10/M11 from software** (OFF / 1/1 / 1/10). The jog modal's
   speed model should therefore eventually expose **clutch state (OFF/1:1/1:10)** in addition to
   crosshead speed (R500). The mockup's current "jog-speed preset" is a simplification; the real
   control is **speed (R500) + clutch (M10/M11)** together. Update the UI when wiring Milestone E.
2. **Jog up/down = M61/M62.** The mockup's ▲/▼ map directly to Crosshead_Up_Run (M61=1,M62=0)
   and Crosshead_Down_Run (M61=0,M62=1); ■ Stop = StopNoBrake or StopWithBrake.
3. **Force-jump safety** (mockup "force-jump stop armed") corresponds to the **Load high-limit
   check** in the 10 ms loop (|Force| ≥ Limit[loadcell] → Test_Over), plus E-stops X14/M20.
4. **"CP" still unconfirmed.** §14 does not name a channel "CP"; the live force comes from R32.
   The mockup's `CP/Force` label remains a screenshot artifact pending confirmation.

### 14.13 PHYSICAL CONTROL PANEL (photo from the real machine, user-supplied)

The machine has a hardware pendant/panel beside the frame. Layout (top → bottom):
- **Manual UP** (yellow) · **UP** (black)
- **Manual Down** (yellow) · **Down** (black)
- **Manual** (red) — mode/enable button
- **Autonics jog wheel** — a rotary **MPG (Manual Pulse Generator)**, graduated dial
  (10/20/30…). This IS the "physical jog wheel" referenced in §14 (corresponds to **M6 = Manual
  Handwheel Active**). Used for fine, pulse-by-pulse crosshead positioning.
- **E-Stop** — large red mushroom (maps to **X14 / M20** in §14.3).

**Button behavior (confirmed by user):**
- **Black UP / Down = LATCHED (toggle):** one press starts motion, the next press stops it.
- **Yellow Manual UP / Down = MOMENTARY (hold-to-run):** moves only while held; releasing the
  finger stops immediately.

**Architecture implication.** Both styles drive the same PLC bits (**M61 up / M62 down**, stop =
clear both). The difference is purely the **input latch logic**, which belongs in the
Presentation/Application layer, not in `IPlcDevice`. So the software jog UI legitimately can
offer BOTH a hold-to-run control (mirrors yellow) and a start/stop toggle (mirrors black) — the
device interface stays the same (`MoveUp()/MoveDown()/Stop()`). The Autonics MPG is a separate
hardware input path (M6); if it must be read in software, it is its own channel, independent of
the on-screen jog.

**IMPORTANT — software jog ≠ physical panel (user-confirmed).** The on-screen jog modal is NOT
meant to replicate or replace the physical pendant. They are **separate paths with different
purposes**: the physical panel (yellow/black buttons + Autonics wheel) is for the operator at
the frame; the **software jog is for calibration routines and similar precise software-driven
tasks**. So do NOT try to "match" the modal to the panel's button styles. The earlier suggestion
to add a black-style latched toggle "to match the panel" is **withdrawn** — keep the software jog
designed around its own use case (calibration/precise positioning), not as a panel clone.

### 14.14 CLUTCH AND SPEED ARE SHARED MACHINE-LEVEL STATE (user-confirmed)

Both the clutch / gear ratio (M10/M11, §14.7) **and the crosshead speed (R500, §14.4)** are
**single global machine states**, NOT per-control settings. Whatever clutch AND speed the
**software** selects apply to EVERYTHING: software jog, the physical panel buttons (yellow
Manual + black UP/Down), and the **Autonics MPG jog wheel** all move at the currently-selected
clutch ratio and the currently-selected speed. There is no separate "physical clutch" or
"physical speed knob" — the physical controls obey the software-set M10/M11 and R500. (The
Autonics wheel still meters fine motion pulse-by-pulse, but the speed/ratio context is the
software-set one.)

**Architecture implication.**
- **Clutch and speed both belong to device/machine state** (one source of truth in the
  Application or Device layer), surfaced read/write to any UI that needs them. Set once, honored
  by all motion paths (software jog AND the physical pendant).
- The on-screen jog modal's clutch selector and speed control are therefore **editors for this
  shared machine state**, not jog-only local options. Changing speed or clutch in the modal
  changes the machine's speed/ratio for the physical pendant too.
- The modal's "effective speed" (base speed ÷10 when clutch = 1:10) is the real resulting motion
  speed and applies to the physical buttons as well.
- When the real `FaconPlcDevice` writes M10/M11 and R500, the UI indicators must reflect the
  actual device state (two-way), so the on-screen values never disagree with what the hardware
  (and the physical panel) will do.

**Effect on the mockup.** The jog modal's speed knob + editable speed box + clutch selector are
correctly modeling SHARED machine state — they are not "just for software jog." A future label/
tooltip pass may clarify in-UI that these set the machine-wide speed & clutch (used by the
physical panel too), but the structure is already right.

---

## 15. CROSS-PAGE ARCHITECTURE & THE RESULT-PARAMETER MODEL (user asked: what does "Force 1-3 N" mean?)

### 15.1 What "Elastic / Force 1-3 N" means
A Results(Batch) column is a **Data Processing Item** defined in the Method Wizard, dialog 5
([Data Processing Items], §13.5). The three header rows under the column name describe HOW that
metric is computed:
- **Column name** = the result, e.g. **Elastic** (elastic slope / stiffness), **Max_Force**,
  **Max_Stroke**.
- **Parameter** = the computation METHOD, not a label. **"Force 1-3"** means *the slope is taken
  between the points where Force = 1 and Force = 3* (in that channel's unit) — i.e. the elastic
  modulus is computed from the 1→3 N segment of the force/displacement curve. **"Calc. at Entire
  Areas"** means the metric (e.g. Max_Force) is evaluated over the whole captured data range.
- **Unit** = the result unit (N/mm² for a modulus/stress, N for force, mm for stroke).
- **Pass/Fail** = verdict against the upper/lower limits set in dialog 5.
- **Print** = whether this column goes into the Report.

So the header band is **not static decoration** — every row in it is a projection of the Method
Wizard configuration. Change the method, and these change.

### 15.2 The page chain (this is the architecture the user flagged as important)
```
METHOD (Wizard, 7 dialogs, §13.5)
   dialog 5 defines: which metrics (Elastic=Force 1-3, Max_Force=Entire Areas, …),
                     their units, and Pass/Fail limits
        │  (defines the "shape" of the result table)
        ▼
TEST  ── acquires immutable RAW (force/disp/time samples, §14 loop)
        │  applies the method's data-processing items to raw → fills Results(Batch) columns
        │  Quick Setting specimen sizes → area/L0 → stress/strain
        ▼
RESULTS window (right-bottom)
        │  re-analyze on raw (never alters raw): change parameter/limits → cells recompute,
        │  Pass/Fail re-verdicts, changed cells highlight yellow
        │  tick a specimen row → its curve overlays on the chart (if chart Overlay on, §13.7)
        │  Print checkbox per column → selects what reaches the report
        ▼
REPORT (Wizard dialog 7 / Report designer, §5.6) ── PDF/Word/Excel/HTML
```
Key invariants:
- **RAW is immutable.** Re-analyze and Re-test recompute *from* raw; they never edit raw (§13.2).
- **One source of truth per concept:** metric definitions live in Method dialog 5; specimen
  sizes have three entry paths (Quick Panel / Specimen Sizes dialog / Re-analyze) that all
  converge on the same specimen-size store → area/stress recompute (§13.7).
- **Results table header = Method config projection.** The mockup's Parameter/Pass-Fail/Unit/
  Print rows must, in the real app, be **data-bound to the Method**, not hardcoded.
- **Calibration** (§14.6 factors) feeds raw→physical conversion upstream of all of this;
  changing a factor changes physical values, hence every downstream result.

### 15.3 Clean-Architecture placement
- **Core:** the metric calculators (Elastic-from-Force-1-3, Max_Force-over-range, stress/strain),
  Pass/Fail evaluation. Pure, unit-testable, parameterized by the method config.
- **Application:** holds the Method config (data-processing items + limits), orchestrates
  Test → results fill, Re-analyze (re-run calculators on stored raw), and overlay selection
  state. Owns the immutable-raw store.
- **Presentation:** Method Wizard editing the config; Results table rendering the config-driven
  header + computed cells; chart overlay reacting to row ticks. No calculation logic here.
- **Data:** raw acquisition (§14 FaconPlcDevice), INI/persistence for method + calibration.

### 15.4 Mockup status vs this model
- ✅ Results(Batch) header shows Name / Parameter / Pass-Fail / Unit / Print (§10C).
- ✅ Table rebuilt to match the real **"Show Batch Results"** window: left icon columns
  (curve-overlay ◢ | per-row Print checkbox), columns **Max_Force / Max_Stress**, batch groups
  (1-1/1-2/1-3 … then **Average** row … then 2-1/2-2/2-3 … Average), red batch-number chips
  ❶❷ on the Print header row.
- ✅ Per-row curve toggle + checkbox for overlay-on-tick.
- ⚠ Mockup still shows **Results(Batch) only**; the guide (§13.6) also has **Results(Single)**.
  Pending: add a Single/Batch view or tab in a later revision.
- ⚠ Header values are hardcoded sample text; in the real app they bind to the Method config.

### 15.5 WHERE the result targets are configured (user's question: "where do we say which points the test targets?")
The columns, their calculation method, and Pass/Fail are NOT defined in the Results window —
they are defined upstream in **Method Wizard → dialog 5 [Data Processing Items]** (§13.5). That
dialog is the single place that answers "what is this test measuring and where":
- **Which metrics**: enable/disable Max_Force, Max_Stress, Elastic, ReH/ReL, Rm, A%, etc.
- **The target points / range per metric** = the "Parameter" shown in the table:
  - "Calc. at Entire Areas" → evaluate over the whole captured curve.
  - "Force 1-3" → take the value/slope between Force = 1 and Force = 3 (the segment is the
    *target points*). This is exactly "from where to where" the metric is taken.
  - yield/proof methods (ReL plateau, Rp0.2 offset) carry their own point-finding rule.
- **Pass/Fail** per metric: Enabled + upper/lower limit.
The Results window then only **displays and re-analyzes** those definitions against each
specimen's immutable raw. So to change "which points the test targets", you edit Method dialog 5
(or Re-analyze, which reuses the same dialog) — never the Results table directly.
In Clean-Architecture terms: dialog 5 edits the **MethodConfig** (Application layer); the Core
calculators consume it; the Results table is a read/re-analyze view bound to it.

---

## 16. DATA-PROCESSING PIPELINE & ARCHITECTURE (extracted from Ch8, full read)

*Ch8 is titled "Creating Texture Test Method" (food texture), but the **Data Processing Items
mechanism is identical across all test modes**, including tensile. It is the clearest source for
how metrics, target points, Pass/Fail, and chart markers are defined. This section is the
canonical model for the result/parameter engine.*

### 16.1 The Method Wizard tab order (confirmed from Ch8 screenshots)
The wizard runs as horizontal tabs in this order:
**System → Sensor → Testing → Specimen → Data Processing → Chart → Report.**
(Earlier we listed 7 dialogs; Ch8 confirms the exact tab names and order.)
- **1 System:** Test Mode (Texture/Tensile/…) + Test Type (Compression/…); Unit & number of
  figures (applied at once to sensor values, charts, results); Force Polarity/Direction auto.
- **2 Sensor:** force & stroke limits.
- **3 Testing:** the **multi-area motion program** — Area1..Area5 columns, each with Act.
  (Down/Up/OFF), control basis (Stroke/Force), **speed (mm/min)**, a **Change point** (value +
  unit + "Set"), GetData, **Samplings (e.g. 10msec / 50msec / "Same as previous area")**, Loop.
  Plus **Break Detection** (Sensitivity / Level%FS / Level%MAX). → This is the real structure
  behind our "Method step 4 sampling" note: sampling is PER-AREA.
- **4 Specimen:** shape, quantity, sizes.
- **5 Data Processing:** the metric engine (see 16.2) + **Statistics** (Average, Std Dev,
  Max, Min, Range, Median, Variation, 3Sigma, Average±6Sigma) + **Define Formula** (custom
  calculated items) + **Node Threshold** (Set by Force full scale / Set Threshold).
- **6 Chart / 7 Report:** as required.

### 16.2 ANATOMY OF A DATA PROCESSING ITEM (the core model — answers "where do we say which points the test targets")
Every metric (Hardness, Max_Force, Elastic, Peak_Max.1, Valley_Min.1, Adhesiveness, …) is a
**Data Processing Item** with this exact structure (verified across ~10 Ch8 dialog screenshots):

1. **Type** (radio/checkbox group): **Force · Stress · Stroke · Stroke Strain · Disp. · Strain
   · Time** — which channel the metric reads. (e.g. Hardness uses Force; Dent uses Stroke.)
2. **Name:** the item's identifier (e.g. `H_Hardness`, `T_Dent`, `Peak_Max1_Force`).
3. **Parameters tab (P1/P2/P3): THE TARGET POINTS.** This is literally "from where / to where /
   which node" the value is taken. The parameter forms seen:
   - **`Calc. at Entire Area`** (a checkbox) → evaluate over the whole curve.
   - **`P_ (th Node)`** → the Nth node/peak (e.g. Peak_Max.1 = first max, Valley_Min.1 = first
     min).
   - **`P_ (%/FS)`** → a threshold as % of full scale (e.g. 10 %/FS to qualify a peak).
   - **`P_ (th)` / `(th Time)`** → an ordinal/time index.
   - **`Next Node`** (dropdown) → relative reference for energy/area items (A1=Energy1 between
     nodes, A2=Energy2, etc.).
   So "Force 1-3" style targeting in the tensile screenshot is the same mechanism: P1/P2 define
   the segment. **To change which points a test targets, you edit these P-parameters here.**
4. **Pass/Fail tab:** **`Enabled`** checkbox + **`Upper (Xbar_UCL)`** / **`Lower (Xbar_LCL)`**
   limits. This is the source of the Results table's Pass/Fail row.
5. **`Show Marker`** checkbox: **THIS is the "graph tick" the user asked about.** When checked,
   the item's point (H, T, A, Peak_Max, Valley_Min, …) is drawn **as a marker on the chart**.
   The little curve/graph icons in the Result/Method UI map to this Show-Marker state per item.

### 16.3 Composite items & custom formulas
- Some items are **derived** from other registered items, not read directly:
  - **Brittleness B = [Peak_Max.1_Force] − [Valley_Min.1_Force]** → you must first register
    Peak_Max.1 and Valley_Min.1, then B references them.
  - **Cohesiveness = A2/A1**, **Gumminess = H×A2/A1**, **Springness = T2/T1**,
    **Chewiness = H×A2/A1×T2/T1**, **Jelly strength = [H_Hardness]*[T_Dent]**.
- **Define Formula** dialog: Name + **Unit** (e.g. N·mm) + a formula built from a **List** of
  registered items, with math buttons (Sin/Cos/Tan/Log/Log10/Abs/Exp/Sqr) + Pass/Fail.
- **Architecture implication:** data processing items form a **dependency graph** — base items
  (read from a channel) → derived items (reference other items) → formula items. The engine must
  resolve them in dependency order. This is a **computation DAG in Core**, parameterized by the
  Method config.

### 16.4 THE FULL PIPELINE (end-to-end, now complete)
```
METHOD WIZARD (config authoring)
  System(mode/unit) → Sensor(limits) → Testing(Area1..5 motion + per-area sampling + break)
    → Specimen(sizes) → Data Processing(items: Type+Params+PassFail+ShowMarker, stats, formulas)
    → Chart → Report
        │  produces: MethodConfig (immutable per run): channel map, motion program,
        │            metric DAG, pass/fail limits, marker flags, stats set, report layout
        ▼
TEST EXECUTION (per specimen)
  PLC 10ms loop (§14) → raw Force/Disp/Deformation/Time samples (RAW, immutable)
  per-area motion (Down/Up, speed, change-point, break detect) drives the machine
  sampling rate is per-area (10/50 msec / same-as-previous)
        ▼
DATA PROCESSING (apply MethodConfig to RAW)
  resolve metric DAG → base items (by Type/Params target points) → derived → formulas
  evaluate Pass/Fail (Enabled + Upper/Lower) → verdict per item
  compute Statistics across the batch (Average, StdDev, Range, … per item)
  Show-Marker items emit chart markers at their target nodes
        ▼
RESULTS WINDOWS
  Show Batch Results: rows = specimens grouped by batch with an Average row per batch;
    columns = enabled metrics; header rows = Name/Parameter/Pass-Fail/Unit/Print
    (all projected from MethodConfig); left cols = curve-overlay toggle + per-row Print check
  tick a row → overlay its curve on the chart; markers show where each metric was taken
  Re-Analyze → re-run this stage on stored RAW with edited MethodConfig (raw never changes)
        ▼
REPORT/OUTPUT (Ch9 Re-Analyzing, Ch10 Printing/Output)
  Print-checked columns/items → report; export to media
```

### 16.5 Clean-Architecture mapping (refined with Ch8 detail)
- **Core (pure):**
  - `Channel` enum (Force/Stress/Stroke/StrokeStrain/Disp/Strain/Time).
  - `DataProcessingItem` = {Type, Params(P1..P3 target-point spec), PassFail(enabled,upper,lower),
    showMarker} + evaluator.
  - Node/peak/valley finders, "entire area" reducers, energy/area integrators.
  - Formula evaluator over the item DAG; statistics functions.
  - Pass/Fail verdict logic.
- **Application:**
  - `MethodConfig` aggregate (System/Sensor/Testing-areas/Specimen/Items/Stats/Formulas/
    Chart/Report). Owns the immutable-RAW store. Orchestrates Test → process → results.
  - Re-Analyze = recompute from RAW with edited MethodConfig.
- **Presentation:** the 7-tab wizard editors; Results table (config-projected header + cells +
  markers + overlay); chart marker rendering driven by Show-Marker flags.
- **Data:** PLC acquisition (§14), INI/file persistence of MethodConfig + calibration + raw.

### 16.6 Corrections / confirmations to earlier sections
- §5.1 chapter list said "Ch8 Texture" — confirmed: **Ch8 = Creating Texture Test Method**
  (plunger compression + chewing). Useful as the definitive Data-Processing-Item reference.
- The Method "sampling" note (was "Method step 4") is refined: **sampling is configured PER
  AREA in the Testing dialog (dialog 3)**, not a single global rate.
- The Results "Parameter" row values (e.g. "Calc. at Entire Areas") are now traced to their
  origin: the **P-parameters of each item** in Data Processing dialog 5.
- The left-column "graph tick" the user asked about = **Show Marker** flag per item (chart
  marker), distinct from the per-row **curve-overlay** toggle and the **Print** checkbox in the
  Results window. Three different per-item/per-row controls, do not conflate.

---

## 17. SENSOR INVENTORY, PER-SENSOR CALIBRATION & TWO ADDED ASTM TEST TYPES
### (Decided after §0–§16 were written. Full detail: SENSOR_INVENTORY.md, ASTM_D732_D1894.md.)

### 17.1 Physical sensor inventory — CURRENT REBUILT MACHINE (user-confirmed, AUTHORITATIVE)
The lab's actual rebuilt machine has **5 load cells** and **3 extensometers**:

| Load cells (5) | Extensometers (3) |
|---|---|
| LC-100kg (~981 N) | SG-25 (gauge length 25 mm) |
| LC-500kg (~4.9 kN) | SG-50 (gauge length 50 mm) |
| LC-2t (~19.6 kN) | SG-100 (gauge length 100 mm) |
| LC-10t (~98 kN) | |
| LC-25t (~245 kN) | |

> **CORRECTION to §14.6 (Rule 3 — root-caused).** The PLC source (§14) lists **6** loadcell
> indices (0=5 kgf … 5=25 Tf) and extensometers as **50 mm gauge with 0.5/10/100 mm ranges**.
> That reflects the OLD Shimadzu machine code. The **current rebuilt machine** (this section)
> has **5 load cells (100 kg…25 t, no 5 kgf cell)** and **SG-25/50/100 with gauge lengths
> 25/50/100 mm**. **§17 wins over §14.6 for the physical inventory and gauge lengths.** When
> wiring Facon calibration, map the 5 real load cells and the 3 real extensometer gauge lengths,
> not the legacy 6/50mm layout. (Gauge length feeds Strain = ΔL/Lo×100 directly — must be exact.)
> STILL TO CONFIRM: extensometer measuring RANGES (travel) for SG-25/50/100.

### 17.2 Both sensors are chosen IN THE METHOD (user-confirmed)
The **[Sensor] dialog (Method Wizard dialog #2)** selects, per method, which **load cell** and
which **extensometer** (or none → crosshead strain). Mandatory. E.g. rebar ⌀12 → LC-25t/LC-10t;
ASTM D1894 friction → LC-100kg.

### 17.3 Calibration is PER-SENSOR (refines §4 model + §14.6)
Each load cell and extensometer has its OWN calibration (curve, date, valid-until, certificate #).
- New entities `LoadCell` (CapacityKgf, ForceClass ISO 7500-1, CalibrationId) and
  `Extensometer` (GaugeLengthMm, RangeMm, ExtensometerClass ISO 9513, CalibrationId).
- `Calibration` becomes per-sensor: { SensorType, SensorId, Curve, Date, ValidUntil, Cert# }.
- `TestMethod` gains `LoadCellId` + `ExtensometerId?`.
- `Specimen`/`TestRecord` record which sensors + which calibration produced each result (ISO 17025).
- New enum `SensorType { LoadCell, Extensometer }`.
- **Force-range validation:** warn/block when expected force (nominal Rm × area) is outside the
  selected load cell's usable range (overload high-end; poor accuracy low-end, e.g. 50 N on the
  25 t cell). Expected force comes from the material grade's nominal Rm × specimen area.

### 17.4 Two ADDED test types (lab owns the fixtures)
Extend the `TestType` enum and add two `ITestCalculator`s — no rewrite (ARCHITECTURE.md §6 seam):
- **`ShearPunch` — ASTM D732** (shear strength of plastics by punch). Compressive motion, shear
  result: `τ = F_max / (π·d·t)` (d = punch diameter, t = specimen thickness).
- **`Friction` — ASTM D1894** (static & kinetic COF of plastic film). Output μs/μk, NOT
  stress/strain: `μs = F_static_peak / N`, `μk = F_kinetic_avg / N` (N = sled weight). Needs a
  low-force load cell (LC-100kg) + fast sampling; curve = Force vs Time/Distance.

Full `TestType` set: Tensile, Compression (E9), Flexure, SpringRate, RingStiffness,
**ShearPunch**, **Friction**. (Bolt/shear of metal stay TestType=Tensile with a purpose label,
per §4; ShearPunch is specifically the D732 plastics punch test.)

### 17.5 Open items added (update §9)
- Confirm extensometer measuring ranges (travel) for SG-25/50/100.
- Confirm whether Facon reports mounted load-cell identity (auto-ID) vs trusting method selection.
- Confirm exact D732/D1894 specimen geometry, speed, reporting from the purchased ASTM text.

---

## 18. FINAL STATUS & WHERE THE NEW CHAT STARTS

### 18.1 Complete document set (the project's full context)
**NOTE: All text documents below are now MERGED INTO THIS SINGLE FILE as Appendices A–G
(see Part 2). You only attach this one .md file. The list is kept for reference.**
Text references (now inline appendices):
- **`TensileTestX_Handoff.md`** — THIS file (master prompt, §0–§18).
- `ARCHITECTURE.md` — 4-layer Clean Architecture detail.
- `USERGUIDE_ANALYSIS.md` — chapter-by-chapter guide analysis.
- `WORKFLOW_ALGORITHM_CH2-5.md` — run loop, in-test ops, method-creation flow → TestRunner spec.
- `WORKFLOW_ALGORITHM_CH6-10.md` — cycle/control/texture, re-analysis (7 modes), output family.
- `WORKFLOW_ALGORITHM_CH11-20.md` — settings + Phase-2 utilities (permissions, logs, SPC, etc.).
- `SENSOR_INVENTORY.md` — 5 load cells + 3 extensometers, per-sensor calibration (§17).
- `ASTM_D732_D1894.md` — the two added plastics test types (§17.4).
Code:
- `TensileTestX_Core.zip` — the Core project (written, NOT yet compiled — verify in VS 2019).
Reference PDFs (re-attach each new chat — they don't persist):
- `3132-1403.pdf` (INSO 3132), `soft.pdf` (catalog), the 304-page User Guide,
  `PLC_Architecture_Prompt.md` (Facon hardware truth, §14).
- Hardware Self-check guide — re-attach when available (only §11 summary held otherwise).

### 18.2 Key architecture decisions now locked (quick recall)
- 4-layer Clean + light MVVM; dependencies inward; Core has zero external deps.
- x86 / .NET 4.8 / WinForms / SQLite / VS 2019.
- Domain: Customer→Reception→SampleGroup→Specimen→TestResult (+immutable RawData).
- **Method = a motion-profile segment list** (initial-speed non-recording → test → return),
  generalizing across Tensile/Compression/Cycle/Control/Ring. (CH6-10 + CH11-20 finding.)
- **Ring stiffness = a Control move-and-hold test** (deflect to 3% diameter), not a constant pull.
- **Per-sensor calibration**; load cell + extensometer chosen in the [Sensor] method dialog.
- **Re-Test re-acquires** (new raw, overwrite in place); **Re-Analyze recomputes** from immutable
  raw (7 modes). Never conflate.
- **Data-Processing-Item DAG** = {name, formula, params, dependencies, Pass/Fail, Show-Marker};
  ReH/Rm/A/μs/τ are instances; pipeline resolves dependencies then computes.
- TestType set: Tensile, Compression(E9), Flexure, SpringRate, RingStiffness, ShearPunch(D732),
  Friction(D1894).

### 18.3 EXACT next step (Milestone A, step 4)
1. **First:** user opens `TensileTestX_Core.zip` in VS 2019, builds it, reports any compile
   errors. Fix via Rule 3 (root-cause). (Core was written without a VB compiler available, so
   it is unverified — honesty per Rule 5.)
2. **Then build (Core, no hardware needed):**
   - `Enums`: add `ShearPunch`, `Friction` to TestType; add `SensorType {LoadCell, Extensometer}`.
   - `Models`: add `LoadCell`, `Extensometer`; make `Calibration` per-sensor; add sensor IDs to
     `TestMethod`/`Specimen` (per §17.3).
   - `TestTypes/TensileCalculator.vb` + `YieldCalculator`/`StrengthCalculator`/`ElongationCalculator`
     + `AnalysisPipeline` for rebar (ReH/ReL/Rm/Rm-ReH ratio/A) — FULL bodies, English only (Rule 7).
   - `FakePlcDevice` + `TensileTestX.Tests` replaying a known curve; assert computed ReH/Rm/A
     against reference (TENSTAND/synthetic). **This proves the math before any UI or hardware.**
3. Then Milestones B (Data/SQLite) → C (Application/TestRunner) → D (WinForms) → E (Facon).

### 18.4 Standing reminders
- Rules 1–9 + Modes 1–8 (§1, §1A) apply to every response.
- Confirm INSO 3132 Table 11 numbers, ISO 9969 constants, extensometer ranges, and D732/D1894
  geometry from primary sources before locking Pass/Fail (Rule 5) — see §9 open items.
- HTML mockups: download + open in Chrome (in-app preview is broken on the user's phone).
- The latest locked mockup line is `tensile_shell*.html` (§10A/10B); a `tensile_shell-12.html`
  exists from a parallel session — reconcile against §10 frozen structure if revisited.

*End of TensileTestX_Handoff.md — the new chat begins at §18.3 step 1.*


# ===================================================================
# PART 2 — COMPANION DOCUMENTS (APPENDICES)
# ===================================================================
# These were separate files; merged here so everything is in ONE file.
# Each appendix is the full content of the named document.

# -------------------------------------------------------------------
# APPENDIX A — ARCHITECTURE.md (4-layer Clean Architecture detail)
# -------------------------------------------------------------------

# TensileTestX — System Architecture

**Version:** 1.0 (architecture baseline)
**Target platform:** Windows, **x86 (32-bit)** — mandatory. The Facon controller communicates with the PC over **LAN**, but it is accessed through Facon's **32-bit Windows interface/driver** (a 32-bit COM/ActiveX component installed on the PC). We talk to that 32-bit interface in-process; the interface in turn talks to the instrument over LAN. In-process interop with a 32-bit component requires a 32-bit host, so the application must be x86. (The LAN transport does not change this — the binding constraint is the 32-bit interface, not the wire.)
**Language / runtime:** VB.NET, .NET Framework 4.8 (best WinForms + 32-bit COM interop support).
**UI:** WinForms.
**Storage:** SQLite (single-file DB, x86 native interop).
**Instrument:** Shimadzu-class 25 t universal tester driven by a Facon PLC over COM.

---

## 1. Guiding principles

1. **Complete, production-ready application** built from a designed architecture — not scattered snippets.
2. **Minimal but scalable:** the first version does one thing end-to-end (rebar tensile test, reception → test → result → report), but every seam needed for growth (new test types, new standards, new exporters) is already an interface.
3. **Dependency rule:** dependencies point inward only. `Core` knows nothing about SQLite, Facon, or WinForms. The outer layers depend on `Core`, never the reverse.
4. **Testable without hardware:** the entire pipeline runs against a `FakePlcDevice` that replays reference data (TENSTAND / synthetic curves). No instrument required for development or validation.
5. **Raw data is immutable:** acquired sample points are stored verbatim and never overwritten. All analysis is recomputed from raw, so re-analysis is always possible.

---

## 2. Layered architecture

```
┌─────────────────────────────────────────────────────────────┐
│  Presentation  (WinForms)                                    │
│  Forms + ViewModels. No business logic, no SQL, no COM.      │
│  Reception list · Reception detail · Test screen · Wizard ·  │
│  Report · Customer/Method/Calibration editors                │
└───────────────┬─────────────────────────────────────────────┘
                │ depends on
┌───────────────▼─────────────────────────────────────────────┐
│  Application  (services / orchestration / use-cases)         │
│  ReceptionService · TestRunner · AnalysisService ·           │
│  ReportService · AuthService · CustomerService               │
│  Coordinates Core + Data. Holds no algorithms itself.        │
└───────────────┬─────────────────────────────────────────────┘
                │ depends on
┌───────────────▼─────────────────────────────────────────────┐
│  Core  (pure domain — NO external dependencies)              │
│  • Models     (Customer, Reception, SampleGroup, Specimen,   │
│                 TestMethod, MaterialGrade, TestResult, ...)   │
│  • Abstractions (IPlcDevice, IRepository, ITestCalculator,   │
│                 ITestExporter)                                │
│  • Analysis   (RegressionHelper, ModulusCalculator,          │
│                 YieldCalculator, AnalysisPipeline, ...)       │
│  • Units      (UnitConverter)                                │
│  • TestTypes  (Tensile/Compression/Flexure/Spring/Ring)      │
└───────────────▲─────────────────────────────────────────────┘
                │ implements Core abstractions
┌───────────────┴─────────────────────────────────────────────┐
│  Data  (infrastructure — the only layer touching the world)  │
│  • Persistence (SQLite: Database, repositories)              │
│  • Plc         (FaconPlcDevice [COM, x86] · FakePlcDevice)   │
│  • Export      (TenstandCsvExporter · PdfReportExporter)     │
└─────────────────────────────────────────────────────────────┘
```

Key point: **Core defines interfaces, Data implements them.** `Application` wires a concrete implementation (e.g. `FaconPlcDevice` or `FakePlcDevice`) into `Core` at startup (dependency injection by constructor — no DI framework needed for v1).

---

## 3. Solution / project structure

```
TensileTestX.sln
│
├── TensileTestX.Core            (Class Library, no references out)
│   ├── Models/
│   ├── Abstractions/
│   ├── Analysis/
│   ├── Units/
│   └── TestTypes/
│
├── TensileTestX.Data            (Class Library → references Core)
│   ├── Persistence/
│   ├── Plc/
│   └── Export/
│
├── TensileTestX.Application     (Class Library → references Core, Data)
│   └── Services/
│
├── TensileTestX.App             (WinForms EXE → references all)  ← x86 target
│   ├── Forms/
│   ├── ViewModels/
│   └── Program.vb               (composition root: wires everything)
│
└── TensileTestX.Tests           (Unit tests → references Core, Data, Application)
    ├── AnalysisTests/           (regression, modulus, yield vs known curves)
    └── PipelineTests/           (FakePlcDevice replay → expected results)
```

Build setting on **every** project: `Platform target = x86`. SQLite native `x86/SQLite.Interop.dll` ships next to the EXE.

---

## 4. Domain model (entity relationships)

```
Customer 1───∞ Reception 1───∞ SampleGroup 1───∞ Specimen 1───1 TestResult
                                     │                 │
                                     │                 └──1 RawData (immutable)
                                     │
SampleGroup ∞───1 TestMethod ∞───1 MaterialGrade
TestMethod  ∞───1 Calibration
Specimen, Reception carry the audit trail (operator, timestamps).
User 1───∞ (audit references on Reception/Specimen)
```

Plain-language mapping (matches the reception workflow and Shimadzu terms):

| Layer | Meaning | Shimadzu term |
|---|---|---|
| **Reception** | one customer visit; manual intake number; traceability root | (metadata) |
| **SampleGroup** | a requested test set: piece + size + standard + qty | **Batch / Lot** |
| **Specimen** | one physical piece, its own dimensions, one curve | **Specimen** |
| **TestResult** | computed values for one specimen | result row |
| **RawData** | verbatim sample points (immutable) | — |

Averages and standard deviation are computed **at the SampleGroup level** over its valid specimens. A specimen can be marked **invalid** (e.g. ISO 3132 fracture in the outer third) and replaced without discarding the group.

---

## 5. Data flow — running one specimen

```
Operator picks a SampleGroup in the Test screen
        │
        ▼
TestRunner.StartSpecimen(specimen, method, calibration)
        │
        ├─► MachineController.StartTest(method)      → IPlcDevice.MoveDown/Up, SetClutch
        │
        ├─► DataAcquirer (timer @ method.SamplingRateHz)
        │       each tick: IPlcDevice.ReadForceKgf / ReadDisplacementMm
        │       → SamplePoint → raised as PointAcquired event
        │
        ├─► ViewModel updates live readouts + chart (Force, Stroke, Stress)
        │
        ▼  (stop condition: fracture detected, or target, or manual)
TestRunner.Finish()
        │
        ├─► raw points serialized → RawData (immutable XML/CSV)
        │
        ├─► AnalysisService.Analyze(raw, specimen, method, calibration)
        │       → AnalysisPipeline.Run(...)
        │           1. select strain source (crosshead/extensometer)
        │           2. compliance correction (if configured)
        │           3. toe correction
        │           4. ITestCalculator.Calculate(...)  ← per test type
        │               (uses RegressionHelper, YieldCalculator, etc.)
        │       → TestResult  (+ warnings, e.g. "crosshead strain")
        │
        ├─► Pass/Fail evaluated against MaterialGrade limits
        │
        └─► Repository.SaveTest(record) + SaveRawData(raw) + SaveResult(result)
                → Result Panel refreshes; SampleGroup avg/SD recomputed
```

The **same pipeline** runs in tests with `FakePlcDevice` replaying a reference curve — output is compared to known TENSTAND values. That is the software-verification strategy, built into the architecture.

---

## 6. Extensibility seams (how it scales without rewrite)

| To add… | You implement… | Nothing else changes because… |
|---|---|---|
| A new **test type** (e.g. peel) | a new `ITestCalculator` | pipeline & UI resolve calculators by `TestType` |
| A new **standard** (e.g. ASTM A615) | rows in `MaterialGrade` (+ optional method preset) | limits are data, not code |
| A new **export format** | a new `ITestExporter` | Report screen lists exporters by `FormatName` |
| A different **machine/PLC** | a new `IPlcDevice` | everything above talks to the interface |
| **Extensometer** support | enable `StrainSource.Extensometer` path | pipeline already branches on strain source |
| Real-time **true stress/strain** | a display layer over immutable raw | raw is preserved; re-analysis is free |

"Minimal but scalable" in practice: v1 ships only `TensileCalculator` + `FaconPlcDevice` + `TenstandCsvExporter`, but the other slots already exist as interfaces.

---

## 7. Cross-cutting concerns

- **Units:** PLC & display in kgf; stress computed in N/MPa; export in kN. All conversions centralized in `UnitConverter`. Force/area can never be mixed up because raw stays in kgf and conversion happens once, explicitly.
- **Authentication / roles:** `Operator` vs `Supervisor`. Operators run tests; Supervisors edit methods, material limits, calibration, and can override invalid marks. Passwords stored as SHA-256(salt+password). Every Reception/Specimen records the acting user (audit trail, ISO 17025).
- **Safety:** `SafetyMonitor` checks limit switch (direction-aware), emergency stop, and handwheel before any motion command. No motion is issued without passing the gate.
- **Configuration (3 layers):** Global app settings (Supervisor) → Method defaults (per test method) → per-Specimen overrides (measured dimensions). Lower layers inherit from higher unless overridden — the "configuration brain."
- **Immutability & re-analysis:** raw never changes; `Re-Analyze` re-runs the pipeline with possibly different method settings and writes a new result, keeping raw intact.
- **Error handling:** PLC disconnects, out-of-range readings, and failed conversions surface as typed results/warnings, never silent. Temperature outside 10–35 °C is mandatory to record.

---

## 8. Build plan — minimal but scalable v1

**Milestone A — Core foundation (no hardware, fully testable)**
1. `Models` (all entities).
2. `UnitConverter` + `RegressionHelper` (with unit tests vs known curves).
3. `Abstractions` (interfaces).
4. `TensileCalculator` + `AnalysisPipeline` for rebar (ReH/ReL/Rm/ratio/A).
5. `FakePlcDevice` + pipeline tests against synthetic/TENSTAND data. ← proves the math before any UI.

**Milestone B — Data layer**
6. SQLite `Database` + schema (immutable RawData).
7. Repositories implementing `Core` interfaces.
8. `TenstandCsvExporter`.

**Milestone C — Application services**
9. `AuthService`, `CustomerService`, `ReceptionService`.
10. `TestRunner` (orchestrates acquisition + analysis + save).

**Milestone D — Presentation (WinForms, x86)**
11. Reception list / detail (workflow shell).
12. Test screen (7-component Shimadzu layout) bound to a `TestViewModel`.
13. Method Wizard, Report.

**Milestone E — Hardware**
14. `FaconPlcDevice` (COM, x86) — swapped in for `FakePlcDevice` at the composition root.
15. On-instrument validation against reference values.

Milestones A–D need **no instrument**. Hardware is the last plug-in, not a prerequisite.

---

## 9. Open items requiring Supervisor input (not guessable)

1. **INSO 3132 grade numbers** — table 11 values to seed `MaterialGrade` (partially read; need print confirmation for S420/S550/C and the Rm/ReH column).
2. **ISO 9969 ring-stiffness coefficient** — exact formula constants (catalog not on hand).
3. **Facon COM API specifics** — exact ProgID, register addresses (R32/R20/R21/R37/R500), and motion bits (M61/M62) to finalize `FaconPlcDevice`.
4. **Compression standard** — confirmed as ASTM E9.

These are data/integration details; none block Milestones A–D.
```
```

# -------------------------------------------------------------------
# APPENDIX B — USERGUIDE_ANALYSIS.md (chapter-by-chapter guide analysis)
# -------------------------------------------------------------------

# TRAPEZIUM X User Guide — Detailed Analysis
### Extracted from the official 304-page User Guide (PDF). Page offset: **PDF page = printed page + 8.**

This document analyses the guide chapter by chapter and maps each finding to what
TensileTestX must implement. It is the companion to PROJECT_HANDOFF.md §5.

> Rule 5 honesty note: the User Guide repeatedly defers field-level dialog detail to a
> separate **"TRAPEZIUMX Software Reference Manual"** which we do NOT have. Where the guide
> only names a dialog without listing every field, that is flagged. Screenshots in the guide
> were read visually for the authoritative facts below.

---

## PART 1 — STRUCTURE (20 chapters, 6 sections)

| Section | Chapters | Relevance to us |
|---|---|---|
| Preparations | 1 | install, connect machine, login, register machine/jigs |
| Execution of Test | 2–3 | **the run-test flow + in-test operations** (core) |
| Creating Method | 4–8 | **Method Wizard** (core); 5=single, 6=cycle, 7=control, 8=texture |
| Result Analysis & Output | 9–10 | **re-analysis + report/export** (core) |
| Settings | 11–13 | users, customize main screen, various settings |
| Useful Functions | 14–20 | USB, SPC/statistics, old files, marker, initial speed, clearance |

---

## PART 2 — CHAPTER-BY-CHAPTER FINDINGS

### Ch1 — Before Using (printed 10–32 / PDF 18–40)
- Install, USB driver (`C:\Program Files\SHIMADZU\TRAPEZIUMX\USBDRV\x86` — **note x86 path**,
  x64 path exists too), connect to testing machine, register machines & jigs.
- **Login → three roles** (initial users): `admin/admin` Administrator (all),
  `tester/tester` Test supervisor (method creation + test execution), `user/user`
  General user (test operations only). → maps to our UserRole (Supervisor/Operator;
  Administrator folds into Supervisor for v1).
- After login → **[TRAPEZIUMX Home]** window.
- Statistical Process Control function is opt-in on first start.

### Ch2 — Execution of Test (printed 34–43 / PDF 42–51) — THE RUN FLOW
Four steps:
1. **Turn power on.**
2. **Preparation for test execution** (mount specimen, select method).
3. **Executing test** (Start → live acquisition → break/stop).
4. **Saving test result.**
Plus: **Operations available during test execution**, **Restoring data in emergency
(backup function)**, **Amount of data that can be saved/controlled**.
→ Our `TestRunner` (Application layer) implements exactly this flow; the emergency backup
maps to writing raw immediately/incrementally so a crash never loses an in-progress test.

### Ch3 — Test Execution Functions (printed 45–56 / PDF 53–64) — IN-TEST TOOLS
Each is a feature our Test screen must expose:
- **Selecting a method** · **Continuing test after completion** (auto-advance to next specimen).
- **Entering specimen sizes** (per specimen, before its run).
- **Protecting specimens against damage before test** (pre-test slow approach / soft contact).
- **Returning the testing machine to the original position** (= "Return to Home" / return crosshead).
- **Re-test** (re-run a specimen, replace its result) · **Adding specimens** (extend the batch).
- **Executing test for a NEW LOT under same conditions** (new batch, same method).
- **Deleting a line for specimen yet to be tested** · **Changing order of specimens** (drag).
- **Executing scheduled task** (one person builds a schedule, another runs it in order).
→ Confirms SampleGroup operations: add/insert/reorder/retest/invalidate specimens, new lot.

### Ch4 — Method Flow (printed 58–62 / PDF 66–70)
- New method → **Method Wizard** appears. Tabs across the top; **[Next]/[Back]** or click a tab.
- End choices: **execute test now** under current settings · **save & return Home** · **quit**.
- Edit existing method = open file → same wizard.

### Ch5 — Single Test Method (printed 63–100 / PDF 71–108) — THE WIZARD (CORE)
Covers tensile, compression, bending, peel, creep. **The tensile wizard = 7 dialogs in order:**
1. **[System]** — Test Mode (Single/…); Test Type (Tensile/Compression/Bending/Peel/Creep);
   Force Polarity & Direction auto-selected (**change for a "down tensile test"** — relevant
   to our frame); **Unit** block with SI/Metric/English and per-quantity units:
   Force=N, Disp=mm, Stress=N/mm², Strain=%, Time=sec, Elastic=N/mm², Slope=N/mm, Energy=J.
2. **[Sensor]** — configure sensors (load cell, extensometer) if differing from defaults.
3. **[Testing]** — test **Speed** (e.g. 50 mm/min); end condition (**test ends at specimen
   break detection**), and other control/stop settings.
4. **[Specimen]** — **Material, Shape (illustrated), Quantity, Sizes**. Illustration shows
   which dimensions to enter; dimensions via manual / Excel batch / calipers.
5. **[Data Processing Items]** — pick the metrics to compute (e.g. Break_Force, Break_Stroke,
   Max_Force, Elastic, etc.). **This is the per-method selection of which TestResult fields
   get calculated.** (Ch8 texture chapter is the fullest list of available items.)
6. **[Chart]** — chart scale during test; whether to overlay several curves; axis setup.
7. **[Report]** — report contents + layout (Test date, Test report, Specimen sizes, Test
   result, Chart). Editable sample report.
→ This 7-dialog sequence IS our Method Wizard spec. Each test type tweaks dialogs 3–5.
- Compression method (printed 78): like tensile, down direction, ASTM E9 for us.
- Bending method (printed 83): 3/4-point fixture, span; bend mandrel per INSO 3132 table 12.
- Peel & Creep exist but are lower priority for our lab.

#### Ch5 DEEP DIVE — Method Wizard chrome & the [Specimen] dialog (read from screenshot, PDF p75)
- **Wizard tab strip (top, confirmed visually):** `System · Sensor · Testing · Specimen ·
  Data Process… · Chart · Report` — 7 tabs, clickable; plus **[< Back]/[Next >]** at bottom.
- **Wizard left rail:** numbered step guidance for the current tab (e.g. for Specimen:
  "1. Select the Material · 2. Select the Shape · 3. Enter the Batch and SubBatch Size ·
  4. Enter the specimen sizes · 5. Set the constants"), plus action buttons
  **[Save a Method file] · [Test with this method] · [Finish] · [Cancel]**.
- **[Specimen] dialog contents:**
  - **Material** dropdown · **Shape** dropdown · **Size Unit** (mm).
  - **Batch Size** + **SubBatch Size** → specimen numbering is **Batch-SubBatch** (e.g.
    Batch 2 × SubBatch 3 → rows 1-1,1-2,1-3, 2-1,2-2,2-3). **This refines our model:**
    Shimadzu's "Specimen name" = `{batch}-{sub}`. Our SampleGroup already ≈ batch; the
    sub-batch is an extra grouping level we can fold into Specimen.Index or support explicitly.
  - **Specimen illustration** (left) that changes with Shape; for Plate shows T (thickness),
    W (width), GL(E)/GL(0) (gauge length).
  - **Sizes table:** columns `Name | Thickness[T] | Width[W] | Gauge_Length[GL]`, one row per
    specimen. Buttons: **Represent · AutoNo. · Reset No. · Fixtures · Load (caliper input)**.
  - **Constants column** (right): arbitrary user constants per specimen, with Add/Edit/Delete.
  → Confirms specimen dimension entry is a grid; supports caliper load + Excel batch; and the
    per-specimen Constants feed custom calculation formulas (see Data Processing dependency).

### Ch6/7/8 — Cycle / Control / Texture methods (printed 101–142 / PDF 109–150)
- **Cycle**: repeated load/unload (endurance). Lower priority.
- **Control**: arbitrary machine operation patterns; **simple Up/Down** and **stepped control**.
  → relevant to ring-stiffness style controlled-deflection tests.
- **Texture**: food/pharma; **but its Data-Processing-Item list is the most complete in the
  guide** — use it as the reference catalog of available calculation items.

#### Ch8 DEEP DIVE — Data Processing Item model (the key architectural insight)
Texture items are irrelevant to metal, but they reveal HOW data-processing items work:
- Items can be **derived/composite**, defined by a formula over other items, e.g.
  `Brittleness = Peak_Max.1_Force − Vally_Min.1_Force`, `Hardness = Hardness_Force`,
  `Dent = Hardness_Stroke`.
- Items can have **dependencies**: using one item (e.g. Gumminess) requires registering
  prerequisite items (e.g. Hardness + Cohesiveness) and setting their parameters.
- Items take **parameters** (which peak/valley, which region, etc.).
→ **Architectural consequence for us:** model a `DataProcessingItem` as { name, formula/calc,
  parameters, dependencies }. Our TestResult fields (ReH, Rm, A, …) are concrete instances of
  this. A method selects a list of items; the AnalysisPipeline resolves dependencies, then
  computes them in order. This is the scalable mechanism behind "which metrics get calculated."

### Ch9 — Re-Analyzing (printed 144–163 / PDF 152–171) — CORE
Re-analysis recomputes from immutable raw. Functions:
- **Method-wizard batch change** of parameters · **Quick Setting Panel direct change** ·
  **change only analysis parameters in result window** · **change Pass/Fail criteria** ·
  **change printing order / print on-off** · **point picking in a chart** ·
  **change elastic-line slope in a chart** (drag → Elastic updates) ·
  peel range / peak-valley exclusion · **reset a manually changed result to original**.
- **Combining several test files** (file merge) · **Analysis method selection guide**.
→ Our AnalysisPipeline must support re-running with changed params and manual chart edits,
always preserving raw and allowing reset-to-original.

### Ch10 — Printing & Output (printed 165–176 / PDF 173–184)
- **Print report** · **Excel report** (specified format) · **send e-mail** ·
  **network export** (auto-save result to a network server).
- Report Designer: free layout; output **PDF / Word / Excel / HTML**.
→ Our ITestExporter family: TENSTAND CSV (already planned) + PDF + Excel + network export.

### Ch11 — User Management (printed 178–196 / PDF 186–204)
- Users + **groups** with custom permissions; add/change/delete user; **skip login** option.
→ Our AuthService: roles + optional auto-login; SHA-256+salt as decided.

### Ch12 — Customizing Main Screen (printed 197–208 / PDF 205–216) — LAYOUT (CORE)
- **Customize toolbar** + change toolbar size.
- **Sensor display on/off** ([View]-[Sensors]).
- **Chart/Result window on/off** ([Window] menu): Quick Setting Panel, Summary, File Logs,
  Results(Batch), Results(Single), Chart1, Chart2, Chart3, Chart4.
- **Change window size** (drag frames) · **change layout** (Tile Vertically/Horizontally).
- **Set up the Quick Setting Panel.**
→ Confirms: 4 charts, two result tables (Single+Batch), draggable/toggleable windows.
  Our Test screen should allow show/hide + resize of these panes.

### Ch13 — Various Settings (printed 209–222 / PDF 217–230)
- **Display language** · **startup screen** · **auto-save** · **software & machine operation
  logs** · **test schedule** · **register a frequently-used method** (Quick Method List).
→ AppSettings + audit logs + Quick Method List registration.

### Ch14–20 — Useful Functions (printed 224–304 / PDF 232–304)
- **Ch14 USB memory**: create method/run test/load data via USB (offline operation).
- **Ch15 Statistical Process Control**: XBar-R control charts, histograms, abnormality rules,
  statistics by date/specimen/batch. → matches catalog's "Conventional Process Control".
  DEEP DIVE: two chart types — **Xbar control chart** + **R control chart** (range), and
  **Histogram**. Control chart plots measured values (Y) vs batches/group numbers (X), with
  **UCL/LCL** (upper/lower control limits) and average lines. Histogram: X = test-result
  values for a data-processing item, Y = frequency; can overlay average, UCL/LCL, std dev.
  **[Rules of unusual judging]** dialog (on the System tab) lets you tick which abnormality
  rules apply. Data pulled over an interval via **[Find test files]**. Works with or without
  the SPC function enabled. → Phase-2 QC module: a control-chart/histogram view over stored
  results, filtered by date/specimen/batch, with configurable limits and abnormality rules.
- **Ch16 Old software files** (import legacy).
- **Ch17 Marker Controller** · **Ch18 Initial Speed** (high-speed sampling from a position) ·
  **Ch19 Measuring the Clearance** · **Ch20 Texture-specific useful functions**.
→ Mostly later-phase; Ch15 (SPC) is a notable Phase-2 feature for QC trend charts.

---

## PART 3 — WHAT THIS CHANGES / CONFIRMS FOR OUR BUILD

1. **Method Wizard = 7 dialogs** ([System][Sensor][Testing][Specimen][Data Processing][Chart]
   [Report]) with a tab strip + numbered left-rail guidance + [Save/Test/Finish/Cancel].
   This is the concrete spec for Milestone D's wizard.
2. **Unit system** is selectable (SI/Metric/English) with per-quantity units — UnitConverter
   and display must be unit-aware, not hard-wired to kgf only. (PLC raw still kgf; display
   configurable.)
3. **Down tensile** direction is a real setting — our frame may pull downward; expose it.
4. **Data Processing Items = a dependency-aware calculation model** (Ch8 insight): each item is
   { name, formula/calc, parameters, dependencies }. A method selects a list; the pipeline
   resolves dependencies then computes. Our ReH/Rm/A/etc. are instances. **This is the
   scalable engine for "which metrics compute" — model it explicitly, don't hard-code.**
5. **Specimen numbering = Batch-SubBatch** (`{batch}-{sub}`). Sizes entered in a grid
   (Name/Thickness/Width/GaugeLength) with caliper/Excel load + per-specimen Constants.
6. **In-test operations** (Ch3) define all SampleGroup/Specimen actions: add, insert, reorder,
   retest, delete-untested, new-lot, return-home, protect-before-test.
7. **Re-analysis** (Ch9) must support manual chart edits (point pick, elastic slope) and
   reset-to-original, all on immutable raw.
8. **Outputs** (Ch10): PDF/Word/Excel/HTML + e-mail + network export, beyond TENSTAND CSV.
9. **SPC** (Ch15) is a defined Phase-2 QC feature: Xbar + R control charts and histograms with
   UCL/LCL and configurable abnormality rules, filtered by date/specimen/batch.

---
*Companion to PROJECT_HANDOFF.md. Page offset PDF = printed + 8 for re-checking any section.*

# -------------------------------------------------------------------
# APPENDIX C — WORKFLOW_ALGORITHM_CH2-5.md
# -------------------------------------------------------------------

# Workflow · Algorithm · Architecture — from User Guide Ch2, Ch3, Ch4, Ch5
### Extracted from the official 304-page guide (PDF page = printed + 8). Companion to
### USERGUIDE_ANALYSIS.md. This is the concrete spec for the TestRunner, the in-test
### operations, and the Method Wizard — i.e. Milestones C and D.

---

## PART A — THE TEST-EXECUTION WORKFLOW (Ch2)

The end-to-end run flow, as the operator experiences it:

```
Step 1  Power ON: machine power → PC power → launch app → login (user/pass)
        → [Home] window.
Step 2  Preparation: [Select a method and test] → [Test] Wizard → pick method
        → main window appears.
Step 3  Execute (loop over specimens):
          1. Prepare N specimens.
          2. Move crosshead to the mounting position
             (right-click in the "blue area" = jog/position context).
          3. Mount specimen #1.
          4. Start (hardware button OR software [Start]).
          5. Machine runs; live values + charts update in real time.
          6. Test ends (break detected / stop) → results computed → [Result] window.
          7. Return crosshead to original position.
          8. Mount specimen #2.
          9. Repeat 4–7 for all specimens.
Step 4  Save: [File]-[Save as]-[Test] → result persisted.
        (Print/export can happen at any time.)
Plus:   Operations available DURING test (Part B).
        Emergency backup: in-progress data is restorable after a crash.
```

**Architecture mapping (Clean layers):**
- This loop is the **`TestRunner`** use-case in the **Application** layer.
- "Live values + charts update" = the acquisition loop (Data.Plc `IPlcDevice`) raising
  `PointAcquired`, the **TestViewModel** (Presentation) updating readouts/charts.
- "Results computed" = **AnalysisPipeline** (Core) invoked at break/stop.
- "Save" = **ITestRepository** (Data) writing immutable RawData + TestResult.
- **Emergency backup** = write RAW incrementally during acquisition (not only at the end), so
  a crash mid-test loses nothing. → `TestRunner` flushes raw to disk as it streams.

**Algorithm — stop/break detection (Step 3.6):** the test ends on break detection (force
drops past a threshold after peak) OR a configured stop condition OR manual Stop. This lives
in Core (analysis of the live stream) but is *armed* by the method's Testing dialog settings.

---

## PART B — IN-TEST OPERATIONS (Ch3) — the SampleGroup/Specimen action set

Every item below is a concrete operation our Test screen + TestRunner must support. These ARE
the SampleGroup/Specimen editing semantics.

### B1. Selecting a method
Multiple entry routes (flowchart in guide) → all converge on loading a `TestMethod`.
→ Application: `MethodService.Load`; Presentation: method picker / Quick Method List.

### B2. Continuing tests (three distinct mechanisms — do not conflate)
- **Add specimen** → extend current batch by one (right-click a batch row → [Add Specimen],
  appended to end).
- **Insert specimen** → right-click a row → [Insert] → new specimen added *below* that line.
- **Next Test (new lot)** → [Test]-[Next Test]: clears chart+results, prepares a NEW lot of the
  same N specimens under the SAME method. (= new SampleGroup, same TestMethod.)

### B3. Entering specimen sizes — THREE places (all write the same Specimen dims)
- **[Test]-[Specimen Sizes]** dialog — change only sizes.
- **[Quick Setting Panel]** on the main window — always visible, for frequent direct edits.
- **[Test]-[Reanalyze] → Method Wizard [Specimen]** — change sizes together with other conditions.
Sizes can be entered **any time, before OR after the test** (because stress/strain are
recomputed from raw + sizes). → Confirms: dimensions are an input to analysis, not baked into
raw; re-analysis re-derives stress/strain when sizes change.
→ Algorithm consequence: **Stress = |Force|/S0** and **Strain = (|Disp|/Lo)·100** are computed
in Core from raw + (area, gauge length); editing sizes triggers recompute, raw untouched.

### B4. Protecting specimens before test — "Force Zero Hold"
[Test]-[Test Control]-[Force Zero Hold]: machine auto-moves to hold force at 0 (prevents
pre-load damage to fragile specimens). [Start] begins the test; [Stop] cancels the hold.
→ Application: a `MachineController.ForceZeroHold()` command; Core SafetyMonitor permits it.
→ Algorithm: closed-loop move until measured force ≈ 0 within a tolerance, then hold.

### B5. Returning the machine to start position — "Return"
- Manual: [Test]-[Test Control]-[Return].
- Automatic: set [Return] in **[Break and Limit Action]** in the Method Wizard [Testing] dialog.
→ `MachineController.Return()`; method carries a "return after break" flag.

### B6. Re-Test
Re-run a specimen after an error; **the result is OVERWRITTEN in the same place**.
→ Repository: re-test replaces that specimen's result+raw (the only sanctioned overwrite —
the specimen is re-run physically, producing new raw; the OLD raw is gone by design here,
distinct from re-analysis which never re-acquires).

### B7. Delete an untested line
Right-click a not-yet-tested row → [Delete this specimen]. Untested lines are also skipped in
printing even if not deleted. The "next test" line cannot be deleted.

### B8. Change specimen order
Drag a [Specimen Name] cell to a new row (cursor → "+"), drop to reorder results.
→ Specimen.Index is mutable post-test for ordering; identity stays stable.

### B9. Scheduled task
One person builds a test schedule ([Tools]-[Task Scheduler]); another runs tasks in order.
→ Phase-2: a `TestSchedule` of queued methods/groups.

**Architecture mapping:** B1–B8 are commands on the **SampleGroup aggregate** in Application,
surfaced as right-click menu actions on the Results table in Presentation. They mutate
specimen list/order/results but NEVER mutate stored raw (except B6 re-test, which re-acquires).

---

## PART C — METHOD CREATION/EDITING FLOW (Ch4) + THE WIZARD (Ch5)

### C1. Create / edit flow (Ch4)
```
[Home] → [Create a new method]  (or [Open a method] to edit)
        → [Method Wizard] opens
        → set each tab via tab-click or [Next]/[Back]
        → finish with one of:
             • [Test with this method]  → run immediately under current settings
             • [Save a Method file]     → save & return Home
             • [Cancel]                 → quit, return Home
```
Editing an existing method opens the same wizard on the loaded file. Identical flow.

### C2. The 7 wizard dialogs in order (Ch5) — the Method Wizard spec
```
1. [System]    Test Mode (Single/Cycle/Control/Texture) · Test Type
               (Tensile/Compression/Bending/Peel/Creep) · Force Polarity & Direction
               (auto; change for DOWN tensile) · Unit (SI/Metric/English, per-quantity).
2. [Sensor]    Load cell + extensometer selection (our 5 cells / 3 extensometers, §17).
3. [Testing]   Speed; Break detection; Break and Limit Action (incl. auto-Return);
               sampling configured PER AREA (not one global rate).
4. [Specimen]  Material · Shape (illustrated, changes with shape) · Batch Size ·
               SubBatch Size · Sizes grid (Name/Thickness[T]/Width[W]/Gauge_Length[GL]) ·
               Constants column. Sizes via manual / Excel batch / calipers.
               Numbering = {batch}-{sub}.
5. [Data Processing Items]  Pick metrics to compute; each item = {name, formula, params,
               dependencies, Pass/Fail, Show-Marker}. Dependency-resolved DAG (see §16).
6. [Chart]     Chart scale during test; overlay several curves; axis setup.
7. [Report]    Report contents + layout (date, report, specimen sizes, result, chart).
```

**Architecture mapping:**
- The wizard edits a **`MethodConfig` aggregate** (Application) = the 7 dialogs' data.
- Each dialog is a Presentation editor bound to a slice of `MethodConfig`.
- [Test with this method] hands `MethodConfig` to `TestRunner`; [Save] persists via repository.
- Re-Analyze (Ch9) reopens the wizard on a COMPLETED test and recomputes from raw — same
  aggregate, different entry point.

---

## PART D — ALGORITHMS THIS PINS DOWN

1. **Stress/strain derivation** (B3): `Stress=|F|/S0`, `Strain=(|Disp|/Lo)·100`, computed in
   Core from raw + sizes; recomputed whenever sizes change; raw immutable.
2. **Break detection** (A): end test when force drops past threshold after peak (armed by
   Testing dialog). Core analyses the live stream.
3. **Force Zero Hold** (B4): closed-loop approach to F≈0, then hold; pre-test protection.
4. **Auto-Return** (B5): post-break return to start, if method flag set.
5. **Re-Test vs Re-Analyze** (B6 vs Ch9): Re-Test RE-ACQUIRES (new raw, overwrites in place);
   Re-Analyze RECOMPUTES from existing immutable raw (never re-acquires). Two different paths —
   must not be conflated in TestRunner/AnalysisService.
6. **Per-area sampling** (C2 dialog 3): sampling rate is set per test area/segment, not one
   global Hz — the acquisition loop must switch rate by segment.

---

## PART E — WHAT TO BUILD (maps to milestones)

- **Application/`TestRunner`** (Milestone C): implement the Ch2 loop + B2–B8 commands +
  incremental raw backup + the Re-Test vs Re-Analyze split.
- **Application/`MachineController`** (Milestone C/E): Start/Stop/Return/ForceZeroHold/Jog.
- **Application/`MethodConfig`** + **`MethodService`** (Milestone C): the 7-dialog aggregate,
  load/save, hand-off to runner.
- **Presentation** (Milestone D): main-window test loop UI; Results table right-click menu
  (add/insert/delete/reorder/re-test/next-lot); the 7-tab Method Wizard; Quick Setting Panel
  live size editing.
- **Core** (Milestone A, ongoing): stress/strain, break detection, AnalysisPipeline, the
  Data-Processing-Item DAG.

---
*Companion to TensileTestX_Handoff.md (§5, §13, §16) and USERGUIDE_ANALYSIS.md. Page offset
PDF = printed + 8 for re-checking Ch2 (printed 34), Ch3 (45), Ch4 (58), Ch5 (63).*

# -------------------------------------------------------------------
# APPENDIX D — WORKFLOW_ALGORITHM_CH6-10.md
# -------------------------------------------------------------------

# Workflow · Algorithm · Architecture — from User Guide Ch6, Ch7, Ch8, Ch9, Ch10
### Extracted from the official 304-page guide (PDF page = printed + 8). Companion to
### WORKFLOW_ALGORITHM_CH2-5.md and USERGUIDE_ANALYSIS.md. Covers the other test modes
### (cycle/control/texture), re-analysis, and output — i.e. more of Milestones C and D.

---

## PART A — CYCLE TEST METHOD (Ch6)

**What it is:** repeated load/unload, computing **hysteresis** (energy loss per cycle).
Used for endurance / spring-like behavior.

Key facts from the guide:
- **[System]** dialog: same as single, with Test Mode = Cycle.
- **Unit** dialog: hysteresis is an **Energy** quantity — set the number of figures for "Energy".
- **[Sensor]**: a **"Cycle"** indicator is auto-added to the main-screen sensors; **the current
  cycle number is displayed live during the test.**
- **[Testing]**: specify machine operation as cycles, e.g. **Pre-Test: 2 cycles up to 50 N**,
  then **Actual test: 1 cycle up to 50 N**. (Pre-Test = preliminary conditioning load.)
- **[Specimen]**: for cycle tests, **only Batch size** can be specified (no sub-batch).
- **[Data Processing Items]**: includes **Hysteresis** — note it has **no P-parameter**; you
  enable Pass/Fail by ticking "Enabled" and entering upper/lower limits.

**Architecture/algorithm mapping:**
- A cycle test = a `CycleTestType` profile: a sequence of {direction, cycles, force/stroke
  target} segments, with a Pre-Test phase. → method carries a **segment list**, not a single
  speed/stop.
- **Hysteresis algorithm:** energy = area between load and unload curves per cycle
  (∮ F·ds over the loop). Computed in Core from raw.
- Live **cycle counter** = a derived live readout (Presentation), fed by counting completed
  segments in the acquisition stream.

---

## PART B — CONTROL TEST METHOD (Ch7) — RELEVANT TO RING STIFFNESS

**What it is:** arbitrary machine motion patterns. Two forms:
1. **Simple Up/Down** — basic directional motion.
2. **Stepped control** — **repeating move & hold cycles** (move a step, hold, repeat).

Key facts:
- **[System]**: Test Mode = Control; the **"down tensile"** note appears here too (direction
  matters for our frame).
- **[Testing]**: specify the motion pattern (move/hold steps).
- **[Data Processing Items]** example: **"Force at 50% strain during unloading"** — i.e. find
  the point where Stroke(strain) reaches 50% in the second (unloading) segment. Shows items can
  target **a specific segment + a specific strain level**.

**Why this matters for us (Council — Principle-keeper):**
- **Ring stiffness (ISO 9969)** is a **controlled-deflection** test: deflect the pipe ring to
  a set % of diameter, read force. That is exactly a **Control / move-and-hold** profile, NOT a
  simple constant-speed tensile pull. → `RingStiffnessCalculator` consumes a control-style run:
  drive to 3% diametric deflection, capture force, compute S.
- **Stepped control** (move & hold) is the mechanism for "deflect to X, hold, measure".
- → Our method model needs a **motion-profile** concept (segments) for Control/Cycle/Ring,
  beyond the single-speed Tensile/Compression case. This generalizes the Testing dialog.

---

## PART C — TEXTURE TEST METHOD (Ch8) — DATA-PROCESSING-ITEM REFERENCE ONLY

Food/pharma; not used for metal. **Its value to us = the fullest Data-Processing-Item catalog
and the composite-item/formula mechanism** (already captured in handoff §16 and
USERGUIDE_ANALYSIS.md Ch8 deep-dive). Key reusable ideas:
- Items can be **composite** (defined by a formula over other items), have **dependencies**
  (one item requires others registered first), and take **parameters** (which peak/valley/area).
- This is the engine behind "which metrics compute" — our ReH/Rm/A/μs/τ are instances.
→ No separate build work here beyond the DataProcessingItem DAG already specified.

---

## PART D — RE-ANALYZING TEST RESULT (Ch9) — CORE ANALYSIS WORKFLOW

**Definition:** re-analysis recomputes results by changing data-processing parameters AFTER the
test, and updates report/chart — **all from immutable raw, never re-acquiring.** (Contrast
Re-Test in Ch3, which re-acquires.)

**Flow:**
```
1. Open a test file (several files can be COMBINED into one analysis).
2. Main window appears with the completed data.
3. Re-analyze by one of the methods below.
4. Save / print / export the re-analysis result as needed.
```

**The 7 re-analysis methods (each a distinct capability our AnalysisService must expose):**
1. **Batch change of parameters via Method Wizard** — reopen the 7-dialog wizard on the
   completed test, change anything, recompute.
2. **Direct change on the main screen via Quick Setting Panel** — e.g. edit specimen sizes →
   stress/strain recompute live.
3. **Change analysis parameters in the result window** — per-item parameter edits.
4. **Change Pass/Fail judgment criteria in the result window** — edit limits, re-judge.
5. **Point picking in a chart** — manually pick a data-processing point on the curve.
6. **Changing an elastic-line slope in a chart** — drag the elastic line; **Elastic (modulus)
   value updates** from the new slope.
7. **Changing the peel-test data-processing range in a chart** — adjust the analysis window.
Plus: **reset a manually changed result to its original value** (undo manual edits).
Plus: **combine several saved test files** into one analysis (file merge).

**Architecture/algorithm mapping:**
- **AnalysisService.ReAnalyze(testId, editedMethodConfig)** → re-runs AnalysisPipeline on the
  stored immutable raw with new parameters. Writes a NEW result; raw untouched.
- Manual chart edits (point pick #5, elastic slope #6, range #7) produce **manual overrides**
  stored alongside the computed result, with a **reset-to-original** that drops the overrides.
- **File merge** = load multiple raw+result sets into one in-memory analysis session.
- This confirms: **raw is the single source of truth; every result is a pure function of
  (raw, method parameters, manual overrides)** — re-runnable and resettable. Core stays pure.

---

## PART E — PRINTING & OUTPUT (Ch10)

**Export selection guide** — TRAPEZIUM X offers several routes; pick by purpose:
- **Print a report** (full formatted report) · **print a chart singly/quickly** (right-click
  chart) · **print a result table singly/quickly** (right-click result window).
- **Excel report** — report in a specified Excel format.
- **CSV measurement-data export** — raw measurement file to CSV (this is our TENSTAND-style export).
- **Method/result/measurement export in CSV / WORD / HTML / PDF.**
- **Send E-mail** (attach result/report).
- **Network export** — auto-save result as CSV to a network server.
- **WebPlus data export** — push to Shimadzu WebPlus (vendor-specific; not for us).

**Architecture mapping:**
- Each output route = an **`ITestExporter`** implementation (FormatName-keyed):
  `TenstandCsvExporter`, `PdfReportExporter`, `ExcelReportExporter`, `WordExporter`,
  `HtmlExporter`, plus side-channels `EmailSender` and `NetworkExporter`.
- The **Report Designer** (free layout: data/charts/photos/logos) is a Presentation-layer
  feature producing a report document the exporters render. (Phase-2 for full designer; v1 =
  a fixed report template + CSV/PDF.)
- **Right-click quick-print** of a single chart or result table = Presentation context actions.

---

## PART F — WHAT THESE FIVE CHAPTERS PIN DOWN (build implications)

1. **Motion-profile generalization (Ch6/7):** beyond single-speed tests, the method must carry
   a **segment list** (move/hold/cycle, direction, force/stroke targets). Tensile/Compression =
   one segment; Cycle = repeated segments; Control/Ring = move-and-hold segments. → generalize
   the [Testing] dialog + `MethodConfig` to a motion profile.
2. **Ring stiffness is a Control test (Ch7):** `RingStiffnessCalculator` runs on a
   move-and-hold-to-deflection profile, not a constant pull. Confirms ISO 9969 needs controlled
   deflection to 3% of diameter.
3. **Hysteresis/energy algorithm (Ch6):** area between load/unload curves; Core math.
4. **Re-analysis is a first-class workflow (Ch9):** AnalysisService must support 7 re-analysis
   modes + manual chart overrides + reset-to-original + file merge, all on immutable raw.
5. **Exporters are a family (Ch10):** CSV/PDF/Word/HTML/Excel + email + network export, each an
   `ITestExporter`; right-click quick-print for chart/table. v1 ships CSV+PDF; rest are seams.
6. **Live derived readouts:** cycle counter (Ch6) is an example — the readout panel shows
   method-specific live values, not a fixed set.

---
*Companion to TensileTestX_Handoff.md (§16) and WORKFLOW_ALGORITHM_CH2-5.md. Page offset
PDF = printed + 8: Ch6 (printed 101), Ch7 (113), Ch8 (125), Ch9 (144), Ch10 (165).*

# -------------------------------------------------------------------
# APPENDIX E — WORKFLOW_ALGORITHM_CH11-20.md
# -------------------------------------------------------------------

# Workflow · Architecture — from User Guide Ch11–20 (Settings & Useful Functions)
### Extracted from the official 304-page guide (PDF page = printed + 8). Companion to
### WORKFLOW_ALGORITHM_CH2-5.md and CH6-10.md. These chapters are mostly **settings and
### Phase-2 utilities**; captured here so nothing is lost, with architecture placement.

---

## Ch11 — User Management (printed 178 / PDF 186)

- Function access is limited **by user**, managed through **authority Groups** (a pack of
  permissions). **Every user must belong to a Group.**
- Three initial Groups: **Administrator** (all functions incl. method editing),
  **Test supervisor**, **User** (general). Custom authority groups can be created.
- Change user info; **skip login name/password entry at startup** (optional auto-login).

**Architecture:** `AuthService` + `User`/`Group`/`Permission` in Core; SHA-256+salt (our
decision). For v1 we collapse to Operator/Supervisor, but the **Group→permissions** model is
the scalable form — keep permissions data-driven, not hard-coded to two roles.

---

## Ch12 — Customizing Main Screen (printed 197 / PDF 205)
Already fully captured (handoff §5.3, §13.3, USERGUIDE_ANALYSIS.md Ch12). Summary: toolbar
customize + size; sensor display on/off; chart/result window on/off ([Window] menu: Quick
Setting Panel, Summary, File Logs, Results(Batch/Single), Chart1–4); window resize (drag) +
layout (Tile V/H); Quick Setting Panel setup.
**Architecture:** Presentation layer — a dockable/toggleable window manager for the main
screen; persisted per user in settings.

---

## Ch13 — Various Settings (printed 209 / PDF 217)

- **Display language**: English, Japanese, Spanish, Simplified/Traditional Chinese. (We need
  English + likely Persian later — i18n via resource strings, not hard-coded UI text.)
- **Startup screen** choice · **Auto Save** · **Backup** function · **software & machine
  operation logs** · **test schedule** · **register a frequently-used method (Quick Method List).**

**Architecture:** `AppSettings` (Global layer) + an **audit/operation log** service (software
events + machine events) — relevant to ISO 17025 traceability. Auto-save/backup reinforce the
"flush raw incrementally" rule from Ch2.

---

## Ch14 — USB Memory Function (printed 224 / PDF 232)
Create method / run test / load data via USB for **offline operation** (build a method on one
PC, carry it to the test PC). **Architecture:** import/export of method+result files to
removable media — an `ITestExporter`/importer pair. Phase-2.

---

## Ch15 — Statistical Process Control (printed 235 / PDF 243) — Phase-2 QC

- Acquires statistics on routine results by **date / specimen / batch**, displays on screen,
  text annotations, **PDF export**.
- **Two operating modes:** "using SPC function" (full) and "not using SPC function" (ad-hoc
  histogram/control chart). Either way produces **Xbar-R control charts** and **histograms**.
- **[Setting rules for judging abnormalities]** — choose which abnormality rules apply.
- Data pulled over intervals via **[Find test files]**.

**Algorithm:** Xbar chart (subgroup means vs UCL/LCL/centerline), R chart (subgroup range),
histogram (frequency of a data-processing item with mean/UCL/LCL/σ overlays). Western-Electric-
style abnormality rules.
**Architecture:** a Phase-2 **`SpcService`** reading stored results (never raw re-acquisition),
+ a Presentation chart view. Pure stats → Core helpers (mean, range, σ, control limits).

---

## Ch16 — Using Old Software Files (printed 251 / PDF 259)
Open & **convert TRAPEZIUM2 method/result files** to TRAPEZIUM X format. **Not relevant to us**
(we have no legacy TRAPEZIUM2 files) — skip unless a customer brings such files.

---

## Ch17 — Marker Controller Function (printed 267 / PDF 275)

- During testing, capture **up to 20 marker points** by pushing a **Marker Controller Switch**
  (hardware, vendor-specific to AG-X/EZ-L,S/AGS-J) **or the PC keyboard** (works on all machines).
- Requires a data-processing item **"Point …"** to be set.

**For us:** the hardware switch is Shimadzu-specific (ignore). **Keyboard marker capture is
useful and machine-agnostic** — let the operator press a key to drop a marker (e.g. note yield
onset) during a live test → stored as marker points on the raw. Phase-2, low cost.

---

## Ch18 — Initial Speed Function (printed 271 / PDF 279)

- **Initial Speed** = a different speed at the very beginning of a test. **During the initial-
  speed region, sampling data is NOT recorded**; recording starts after reaching the threshold/
  main speed.
- Set via an ON/OFF checkbox + value in the method.

**For us — algorithm:** the [Testing] dialog gains an optional **initial-speed segment** (fast
approach / slack take-up) where data isn't logged, then the test proper begins. This pairs with
"protect specimen / take up slack" before real measurement. → part of the **motion-profile
segment list** (from CH6-10 Part F): the first segment can be a non-recording initial-speed move.

---

## Ch19 — Measuring the Clearance Function (printed 275 / PDF 283)

- Measures **clearance / slack** (e.g. grip take-up, jig backlash) so it can be accounted for
  before real measurement begins.

**For us — algorithm:** a pre-test routine that moves until load just registers (slack removed),
establishing the true zero-displacement datum. Improves strain accuracy. Ties to "protect
specimen" (Ch3 Force Zero Hold) and the initial-speed segment (Ch18). Core can offset
displacement by the measured clearance. Phase-2 refinement.

---

## Ch20 — Useful Functions for Texture Software (printed 289 / PDF 297)
Texture-specific (food/pharma). **Not relevant to metal/plastics testing** — skip.

---

## SUMMARY — what from Ch11–20 enters our build

| Chapter | Take into the build? | Where |
|---|---|---|
| 11 User Mgmt | Yes — Group/permission model (collapse to Operator/Supervisor v1) | Core/AuthService |
| 12 Customize | Yes — toggle/resize/tile main-screen windows | Presentation |
| 13 Settings | Yes — language(i18n), auto-save, backup, **operation logs**, Quick Method List | AppSettings + LogService |
| 14 USB | Phase-2 — method/result portability | Data import/export |
| 15 SPC | Phase-2 — Xbar-R + histogram, abnormality rules | SpcService + Core stats |
| 16 Old files | No — no legacy files | — |
| 17 Marker | Partial — **keyboard marker capture** (drop points live) | TestRunner + raw markers |
| 18 Initial Speed | Yes — **non-recording initial-speed segment** | motion profile |
| 19 Clearance | Phase-2 — slack/clearance datum for strain accuracy | Core displacement offset |
| 20 Texture utils | No — texture only | — |

**Net new architectural concepts from Ch11–20:**
1. **Group/permission model** (not just two fixed roles) — keep permissions data-driven.
2. **Operation/audit log service** (software + machine events) — ISO 17025.
3. **i18n** via resource strings (English now, Persian/others later).
4. **Initial-speed (non-recording) segment** + **clearance datum** → both extend the
   motion-profile + the displacement-zeroing algorithm.
5. **Keyboard marker capture** during live tests → marker points on raw.
6. **SPC service** (Phase-2) reading stored results for control charts/histograms.

---
*Companion to TensileTestX_Handoff.md and the CH2-5 / CH6-10 workflow docs. Page offset
PDF = printed + 8. NOTE: the separate "Hardware Self-check & Settings Guide" referenced in
handoff §0/§11 was NOT present in this chat — extract it when it is uploaded.*

# -------------------------------------------------------------------
# APPENDIX F — SENSOR_INVENTORY.md (5 load cells + 3 extensometers)
# -------------------------------------------------------------------

# Sensor Inventory & Calibration Model
### The machine has multiple load cells and extensometers. Each is selected IN THE METHOD
### ([Sensor] dialog of the Method Wizard) and calibrated individually.

This changes the Calibration model from one-per-machine to **one-per-sensor**, and makes
load-cell + extensometer selection part of every method.

---

## 1. Physical inventory (from the user / the real machine)

### Load cells (5)
| ID | Capacity | Typical use |
|---|---|---|
| LC-100kg | 100 kgf (~981 N) | ASTM D1894 friction (5–100 N), thin films, low-force |
| LC-500kg | 500 kgf (~4.9 kN) | small plastics, light shear |
| LC-2t | 2 tonf (~19.6 kN) | medium specimens |
| LC-10t | 10 tonf (~98 kN) | larger bars, plates |
| LC-25t | 25 tonf (~245 kN) | rebar ⌀ up to large, full-capacity tests |

### Extensometers (3)
| ID | Gauge length (TO CONFIRM) | Typical use |
|---|---|---|
| SG-25 | 25 mm (assumed) | short gauge / small specimens |
| SG-50 | 50 mm (assumed) | medium |
| SG-100 | 100 mm (assumed) | long gauge / large specimens |

> Rule 5: "SG-25/50/100" is read as gauge length in mm but NOT yet confirmed. The gauge
> length feeds strain directly (StrainPct = ΔL/Lo·100), so it MUST be confirmed from the
> extensometer label/datasheet before locking. Travel/measuring range of each is also needed.

---

## 2. Selection rule (user-confirmed: "both are chosen in the method")

The **[Sensor] dialog (Method Wizard dialog #2)** selects, per method:
- which **load cell** (one of the 5),
- which **extensometer** (one of the 3, or none → crosshead strain).

This is mandatory, not optional. A method created for "Rebar ⌀12 tensile" picks LC-25t (or
LC-10t) and an appropriate extensometer; a method for "D1894 friction" picks LC-100kg.

---

## 3. Force-range validation (the non-obvious safety/accuracy rule)

A load cell is only accurate in its upper range (typically ≥1–2% of capacity per ISO 7500-1
Class 1). The software must **warn** when the expected force is outside the selected cell's
usable range:
- Too high → risk of overload (expected force near/above capacity) → block or warn hard.
- Too low → poor accuracy (e.g. measuring 50 N on the 25 t cell) → warn to pick a smaller cell.
The expected force comes from the material grade's nominal Rm × specimen area, so the method
can sanity-check the chosen cell automatically.

---

## 4. Data-model impact (refines Core.Models)

Replace the single `Calibration` with per-sensor entities:

```
LoadCell
  Id, Name (e.g. "LC-25t"), CapacityKgf, ForceClass (ISO 7500-1, e.g. Class1),
  CalibrationId  → its own Calibration record (curve, date, valid-until)

Extensometer
  Id, Name (e.g. "SG-50"), GaugeLengthMm, RangeMm, ExtensometerClass (ISO 9513),
  CalibrationId  → its own Calibration record

Calibration (now per-sensor, not per-machine)
  Id, SensorType (LoadCell|Extensometer), SensorId,
  CalibrationCurve (points), CalibrationDate, ValidUntil, Certificate#

TestMethod  (add)
  LoadCellId        → selected load cell
  ExtensometerId?   → selected extensometer (null = crosshead strain)

Specimen/TestRecord (add for traceability)
  LoadCellId, ExtensometerId, LoadCellCalibrationId, ExtensometerCalibrationId
  → records WHICH sensors & WHICH calibration produced each result (ISO 17025)
```

### Why per-sensor calibration matters (ISO 17025)
Each load cell and extensometer has its own calibration certificate and expiry. A result must
record exactly which sensor and which calibration version produced it, so the measurement is
traceable. A method using an out-of-date calibration should warn/block.

---

## 5. Consequences elsewhere

1. **Core enums:** add `SensorType { LoadCell, Extensometer }`.
2. **[Sensor] wizard dialog:** two dropdowns (load cell, extensometer) populated from the
   sensor inventory; shows each sensor's calibration status (valid/expired).
3. **Force-range check:** Application-layer validation using nominal Rm × area vs cell capacity.
4. **Calibration screen (Supervisor):** manage 5 load cells + 3 extensometers, each with its
   own calibration curve, date, valid-until, certificate number.
5. **Facon/hardware (Milestone E):** if the frame reports which load cell is mounted
   (auto-ID), verify it matches the method's selected cell; else trust the method selection.
   (Whether Facon supports load-cell auto-ID is an OPEN hardware question.)
6. **Compliance correction:** machine compliance may differ per load cell / crosshead config;
   the compliance curve can live with the calibration record.

---
*Companion to PROJECT_HANDOFF.md, USERGUIDE_ANALYSIS.md, ASTM_D732_D1894.md.
Open items: confirm extensometer gauge lengths & ranges; confirm whether Facon reports
mounted load-cell identity.*

# -------------------------------------------------------------------
# APPENDIX G — ASTM_D732_D1894.md (two added plastics test types)
# -------------------------------------------------------------------

# Additional Test Types — ASTM D732 & ASTM D1894
### The lab owns fixtures for these. They extend the test-type set beyond metal.

These are **plastics** tests (not metal/rebar). They slot into the architecture as two new
`TestType` values + two new `ITestCalculator` implementations — no rewrite, by design
(this is exactly the extensibility seam in ARCHITECTURE.md §6).

> Rule 5 note: formulas below are from the public method summaries (web, Jun 2026). Before
> locking acceptance logic, confirm exact specimen geometry, speed, and reporting against the
> purchased ASTM standard text.

---

## 1. ASTM D732 — Shear Strength of Plastics by Punch Tool

**What it is:** a punch shears a disk out of a clamped plastic sheet/disk specimen. The
machine applies a **compressive** force to the punch; the result reported is **shear strength**.

- **TestType:** `ShearPunch` (NEW). Mechanically compressive motion, but the metric is shear —
  do NOT hide it under Compression; it has its own formula and specimen geometry.
- **Specimen:** 50 mm (2 in) square or 50 mm disk; thickness 1.27–12.7 mm (0.050–0.500 in).
  Punch diameter typically 1 in (25.4 mm). Thickness must be measured precisely (digital
  micrometer, ~0.025 mm resolution) — thickness is the critical dimension.
- **Formula:** shear strength `τ = F_max / (π · d · t)`
  where d = punch diameter, t = specimen thickness, F_max = peak force.
  (Area sheared = punch circumference × thickness = π·d·t.)
- **Result fields:** ShearStrength (MPa), F_max (N), thickness t. No ReH/Rm/E.
- **Direction:** down (compressive punch).
- **Notes:** shear strength here is NOT a pure material property (depends on thickness) — the
  standard warns about this; just report it.

### Model impact
- Add `TestType.ShearPunch`.
- New `ShearPunchCalculator : ITestCalculator` → computes τ from F_max, d, t.
- Specimen needs: thickness `t`, punch diameter `d` (a method/fixture constant).
- New result field `ShearStrength` (reuse TestResult.ExtraJson or add a typed field).

---

## 2. ASTM D1894 — Static & Kinetic Coefficient of Friction of Plastic Film

**What it is:** a sled of known weight (wrapped in the test film) is dragged horizontally
across the same film by the crosshead via a cord-and-pulley. The pulling force gives the
friction coefficients.

- **TestType:** `Friction` (NEW). Output is NOT stress/strain — it is **coefficients of
  friction**. Curve is Force vs Time (or vs distance), not stress–strain.
- **Specimen / fixture:** film on a flat bed; a sled (standard weight, e.g. ~200 g sled →
  N = sled weight in N) wrapped in the same film; pull cord over a pulley to the crosshead.
  Requires the COF fixture (Instron 2810-005-class) and a **low-force load cell (5–100 N)** —
  our 25-ton cell is far too coarse; this needs a small interchangeable load cell.
- **Formulas:**
  - Static COF `μs = F_static_peak / N` (first force peak = sled break-away).
  - Kinetic COF `μk = F_kinetic_avg / N` (average sliding force over the run).
  - N = normal force = sled weight (in N).
- **Result fields:** μs, μk, F_static_peak, F_kinetic_avg, sled weight N. No ReH/Rm/E.
- **Direction:** horizontal drag (crosshead pulls the sled).
- **Sampling:** fast capture needed — the static peak is brief; use a high sampling rate so
  the break-away peak isn't missed (Instron notes up to kHz). Relevant to our SamplingRateHz.

### Model impact
- Add `TestType.Friction`.
- New `FrictionCalculator : ITestCalculator` → finds static peak (μs) and mean sliding force
  (μk), divides by sled weight N.
- Method/fixture constants: sled weight N, kinetic-region window.
- New result fields μs, μk (ExtraJson or typed).
- **Sensor config:** this method selects a small load cell (5–100 N), not the 25-t cell —
  ties into the [Sensor] wizard dialog (multiple load cells / ranges).

---

## 3. Cross-cutting consequences

1. **`TestType` enum grows by two:** `ShearPunch`, `Friction` (alongside Tensile, Compression,
   Flexure, SpringRate, RingStiffness). Each gets its own `ITestCalculator`. Nothing else
   in Core/Application/Presentation changes — the pipeline resolves calculators by TestType.
2. **Multiple load cells / ranges** is now a real requirement: the 25-t frame must support
   swapping to a small load cell (5–100 N) for D1894. The [Sensor] dialog (Method Wizard
   dialog 2) must let a method pick its load-cell range. Calibration is per load cell.
3. **Result fields beyond stress/strain:** ShearStrength, μs, μk. Either add typed nullable
   fields to TestResult or carry them in ExtraJson (the scalable seam already exists).
4. **Charts:** D1894's natural chart is Force vs Time/Distance (friction trace); D732's is
   Force vs Stroke. The configurable-axis charts already support this.
5. **Pass/Fail:** these are mostly characterization tests (engineering data / QC comparison),
   so acceptance limits are optional per customer spec, not a fixed standard table like INSO 3132.

---
*Companion to USERGUIDE_ANALYSIS.md and PROJECT_HANDOFF.md. Add TestType.ShearPunch and
TestType.Friction when extending the Core enums; build their calculators in the TestTypes
folder at the same stage as the other non-tensile calculators.*

*End of single-file project context. Companion code: TensileTestX_Core.zip.*
