# TODO — Integration test support (issue #691)

Tickets below implement improved instrumentation/integration-test support across the
design system, per issue [#691](https://github.com/SchweizerischeBundesbahnen/design_system_flutter/issues/691).
Numbered in dependency order (blockers first). Each ticket is a standalone, demoable
vertical slice.

**Excluded from this set:** `SBBPaginator`. It has no interactivity today (no
`onTap`/`onPageChanged`) — the issue's "change between pages" ask is a feature
request, not a test-hook gap, and should be filed separately.

---

## 01 — Testing infrastructure scaffolding

**What to build:** The enabling infrastructure every other ticket in this set depends
on. No user-facing behavior yet.

**Blocked by:** None — can start immediately

**Status:** ready-for-agent

- [x] `flutter_test` promoted from `dev_dependency` to a real `dependency` in `pubspec.yaml`
- [x] New export entry point `package:sbb_design_system_mobile/testing.dart` created (empty/placeholder — populated by later tickets)
- [x] `integration_test` dependency added to `example/pubspec.yaml`
- [x] `example/integration_test/` directory scaffolded with one smoke test that pumps the gallery app and confirms the harness runs end-to-end (`flutter test integration_test/` passes)

---

## 02 — Static singleton-overlay close-button keys (BottomSheet, Popup, Popover)

**What to build:** Consumers can reliably find and tap the close button on
`SBBBottomSheet`, `SBBPopup` and `SBBPopover` via a stable public key, without depending on
internal widget structure.

**Blocked by:** 01

**Status:** ready-for-agent

- [x] `SBBBottomSheet.closeButtonKey` added as a `static const Key`, applied to the internal close button (revives the approach from PR #707, never merged)
- [x] `SBBPopup.closeButtonKey` added following the same pattern, applied to its close button
- [x] `SBBPopover.closeButtonKey` added following the same pattern, applied to its close button
- [x] Test coverage for all three: find by key, tap, verify dismissal — lives solely under `example/integration_test/` (not duplicated as separate widget tests) to avoid testing the same open/tap/dismiss flow twice
- [x] Integration test coverage for all three under `example/integration_test/`
- [x] Separate files for each component in integration test, run them via .main() in app_test.dart file; shared `MaterialApp`/theme/`Scaffold` host factored into `example/integration_test/test_app.dart`
- [x] `CHANGELOG.md` updated

---

## 03 — Item-level key parameters (TabBar, SegmentedButton, Dropdown/MultiDropdown)

**What to build:** Consumers can select a specific tab, segment, or dropdown item
in tests by supplying an optional `Key?` on the item model (`SBBTabBarItem`,
`SBBButtonSegment`, `SBBDropdownItem`), wired onto the rendered item.

**Blocked by:** 01

**Status:** ready-for-agent

- [x] New `Key? key` constructor parameter added to `SBBTabBarItem`, applied to the rendered tab item
- [x] New `Key? key` constructor parameter added to `SBBButtonSegment`, applied to the rendered segment
- [x] New `Key? key` constructor parameter added to `SBBDropdownItem` (single and multi dropdown), applied to the underlying radio/checkbox row
- [x] Widget test coverage: select each type of item by its consumer-supplied key and verify the correct `onChanged`/selection callback fires
- [x] Integration test coverage for all three under `example/integration_test/` following previous test implementations in `example/integration_test/`
- [x] `CHANGELOG.md` updated

---

## 04 — Dismiss-button keys (NotificationBox, PromotionBox)

**What to build:** Consumers can uniquely target the dismiss button on
`SBBNotificationBox` and `SBBPromotionBox`, even with multiple concurrent instances
on screen (both already render in multiples in the example gallery).

**Blocked by:** 01

**Status:** ready-for-agent

- [x] New `Key? dismissButtonKey` constructor parameter added to `SBBNotificationBox`, applied to its internal dismiss button
- [x] New `Key? dismissButtonKey` constructor parameter added to `SBBPromotionBox`, applied to its internal dismiss button
- [x] Widget test coverage: multiple concurrent instances, each dismissed independently by its own key
- [x] Integration test coverage for both under `example/integration_test/`  following previous test implementations in `example/integration_test/`
- [x] `CHANGELOG.md` updated

---

## 05 — SlideToToggle handle key + drag interaction test

**What to build:** Consumers can reliably drive `SBBSlideToToggle`'s drag interaction
in tests. The drag handle is an internal sub-element offset within the track, not
the widget's whole tap area, so the outer widget key alone isn't sufficient.

**Blocked by:** 01

**Status:** ready-for-agent

- [x] New `Key?` parameter added to `SBBSlideToToggle` targeting the internal drag handle specifically (distinct from the outer widget bounds)
- [x] Widget test coverage: drag the handle by key past the toggle threshold, verify state change
- [x] Integration test coverage under `example/integration_test/`, including multiple concurrent instances (confirmed pattern in the example gallery)  following previous test implementations in `example/integration_test/`
- [x] `CHANGELOG.md` updated

---

## 06 — SBBStepperItem identifier field

**What to build:** Consumers can target a specific step in `SBBStepper` directly by
an identifier they supply, instead of matching on item type/position.

**Blocked by:** 01

**Status:** ready-for-agent

- [x] New identifier field added to the `SBBStepperItem` sealed-class hierarchy (`SBBStepperItemIcon`, `SBBStepperItemText`, `SBBStepperItemNumbered`)
- [x] Identifier of type `Key?` wired on each step's internal circle widget
- [x] `OnStepPressedCallback` behavior unaffected (still reports item + index) — identifier is additive
- [x] Widget test coverage: select a specific step by its identifier
- [x] Integration test coverage under `example/integration_test/`  following previous test implementations in `example/integration_test/`
- [x] `CHANGELOG.md` updated

---

## 07 — SBBToast dismiss-action documentation + test

**What to build:** Documented, proven guidance for dismissing a toast's action in
tests. No production code changes — `SBBToastAction` already accepts a `key`.

**Blocked by:** 01

**Status:** ready-for-agent

- [x] Doc comment on `SBBToastAction`/`SBBToast.show` updated with an example showing a consumer-supplied `key` and `find.byKey(...)` + `tester.tap(...)` usage
- [x] Integration test under `example/integration_test/` demonstrating tap-to-dismiss via a consumer-supplied key  following previous test implementations in `example/integration_test/`
- [x] No `CHANGELOG.md` entry needed (no API change) — note the doc addition only if the project's changelog convention calls for it

---

## 08 — SBBDatePickerController (establishes the picker controller pattern)

**What to build:** Consumers can programmatically set `SBBDatePicker`'s value in a
test (or otherwise), without simulating drag gestures or reaching into private state.
This ticket also settles the general controller pattern reused by tickets 09 and 10.

**Blocked by:** 01

**Status:** ready-for-agent

- [x] New `controller: SBBDatePickerController?` constructor parameter added to `SBBDatePicker`
- [x] `SBBDatePickerController.setDate(DateTime value, {bool animate = true})` drives the private day/month/year `SBBPickerScrollController`s internally
- [x] Existing cross-column validation preserved (e.g. clamping day when month/year changes make it invalid)
- [x] Day/month/year column structure stays private — not exposed as public API
- [x] `WidgetTester` extension method `tester.selectSbbDate(Finder finder, DateTime value)` added, exported via `package:sbb_design_system_mobile/testing.dart`
- [ ] Widget test coverage: set a date via the controller, verify `onDateChanged` fires with the expected value (skipped for now — controller behavior covered in `example/integration_test/date_picker_test.dart` instead)
- [x] Integration test coverage under `example/integration_test/`, using the new `tester.selectSbbDate` helper  following previous test implementations in `example/integration_test/`
- [x] `CHANGELOG.md` updated

---

## 09 — SBBTimePickerController

**What to build:** Same controller pattern as 08, applied to `SBBTimePicker`.

**Blocked by:** 08

**Status:** ready-for-agent

- [ ] New `controller: SBBTimePickerController?` constructor parameter added to `SBBTimePicker`
- [ ] `SBBTimePickerController.setTime(TimeOfDay value, {bool animate = true})` drives the private hour/minute controllers internally
- [ ] `WidgetTester` extension method `tester.selectSbbTime(Finder finder, TimeOfDay value)` added, exported via `package:sbb_design_system_mobile/testing.dart`
- [ ] Widget test coverage: set a time via the controller, verify `onTimeChanged` fires with the expected value
- [ ] Integration test coverage under `example/integration_test/`, using the new `tester.selectSbbTime` helper  following previous test implementations in `example/integration_test/`
- [ ] `CHANGELOG.md` updated

---

## 10 — SBBDateTimePickerController

**What to build:** Same controller pattern as 08/09, applied to `SBBDateTimePicker`
(date + hour + minute columns).

**Blocked by:** 08, 09

**Status:** ready-for-agent

- [ ] New `controller: SBBDateTimePickerController?` constructor parameter added to `SBBDateTimePicker`
- [ ] `SBBDateTimePickerController.setDateTime(DateTime value, {bool animate = true})` drives the private date/hour/minute controllers internally
- [ ] `WidgetTester` extension method `tester.selectSbbDateTime(Finder finder, DateTime value)` added, exported via `package:sbb_design_system_mobile/testing.dart`
- [ ] Widget test coverage: set a date+time via the controller, verify `onDateTimeChanged` fires with the expected value
- [ ] Integration test coverage under `example/integration_test/`, using the new `tester.selectSbbDateTime` helper  following previous test implementations in `example/integration_test/`
- [ ] `CHANGELOG.md` updated

---

## 11 — SBBSlider semantics-action test helper

**What to build:** Consumers can set `SBBSlider`'s value in a test without computing
manual drag-distance math. No widget code changes — `SBBSlider` stays a pure `Slider`
wrapper.

**Blocked by:** 01

**Status:** ready-for-agent

- [ ] `WidgetTester` extension method `tester.setSbbSliderValue(Finder finder, double value)` added, exported via `package:sbb_design_system_mobile/testing.dart`
- [ ] Helper drives the value via Flutter's existing `SemanticsAction.increase`/`decrease` on the slider's semantics node — no `SBBSlider`/`Slider` API changes
- [ ] Step-granularity limitation documented (default 10% step when `divisions` is null; exact-value assertions should account for this or use `divisions`) — no drag-offset fallback in scope
- [ ] Widget test coverage: reach a target value via the helper, verify `onChanged`/`onChangeEnd` fires with the expected (possibly step-rounded) value
- [ ] Integration test coverage under `example/integration_test/`, using the new `tester.setSbbSliderValue` helper  following previous test implementations in `example/integration_test/`
- [ ] `CHANGELOG.md` updated

---

## 12 — CONTRIBUTING.md testability convention

**What to build:** A documented convention for future components, written last so it
reflects what was actually shipped rather than aspirational design.

**Blocked by:** 02, 03, 04, 05, 06, 07, 08, 09, 10, 11

**Status:** ready-for-agent

- [ ] New section added to `CONTRIBUTING.md` codifying the recipe used across this set:
  - Use a `static const Key` for interactive sub-elements on genuinely singleton/overlay widgets (only one instance ever mounted at a time)
  - Use a dedicated controller class (not raw internal controllers) for widgets whose value is set via complex/gesture-driven interaction, with an accompanying `WidgetTester` extension shipped via `testing.dart`
- [ ] References the concrete examples from tickets 02–11 as worked precedent
