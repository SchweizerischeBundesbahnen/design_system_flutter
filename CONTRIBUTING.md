# Guidance on how to contribute

> All contributions to this project will be released under the MIT License. By submitting a pull request or filing a bug, issue, or feature request, you are agreeing to comply with this waiver of copyright interest.
> Details can be found in our [LICENSE](LICENSE).

There are two primary ways to help:

- Using the issue tracker, and
- Changing the code-base.

## Using the issue tracker

Use the issue tracker to suggest feature requests, report bugs, and ask questions. This is also a great way to connect with the developers of the project as well as others who are interested in this solution.

Note that we will not accept all feature requests, since the UI elements in SBB DSM are closely tied to the SBB Design System.

Use the issue tracker to find ways to contribute. Find a bug or a feature, mention in the issue that you will take on that effort, then follow the _Changing the code-base_ guidance below.

## Changing the code-base

Generally speaking, you should *fork* this repository, make changes in your own fork, and then submit a pull request. Refer to the official git documentation on [Contributing to a Project] for details.

### Expectations for a pull request

All new code should be covered by tests that validate the implemented features and the presence or lack of defects. See [Testing](#testing) for which kind of test we expect where.

Additionally, the code should follow the patterns and structure found in other components, unless there is a clear reason why not to.

It is mandatory to update the [CHANGELOG.md](CHANGELOG.md) file with clear description of what has changed. Stick to the [Keep a Changelog] format and [Semantic Commit Messages].

Your code will be analyzed and formatted according to the rules defined in [analysis_options.yaml](analysis_options.yaml).

Take a look at the [github test action](.github/workflows/test.yml) that will run on every pull request update to understand which tests are run on our CI.

The naming of the Widgets should follow the naming from the [Design specs].

### Testing

This is a design system: what a component *looks like* is its contract. **We therefore prefer [Golden Tests] over any other kind of test.**
A golden test pins down the rendered pixels, which covers layout, spacing, colors, typography, theming and state at once.

#### Golden tests (the default)

Golden tests live in `test/` and are run by `flutter test` on every pull request.

Write one per component and cover its relevant states (default, selected, disabled, long text, custom content, ...) in a single widget, so that one golden captures the whole matrix.
Use the `TestSpecs.run` helper from [test/test_app.dart](test/test_app.dart) with `TestSpecs.themedSpecs` — it renders the widget in both light and dark theme and writes one golden per brightness.
[sbb_chip_test.dart](test/sbb_chip_test.dart) is a good reference.

Generate or refresh the reference images with:

```shell
flutter test --update-goldens
```

Goldens are pixel-compared on a _macOS_ runner in CI. Failed goldens are uploaded to the job artifacts so you can inspect the diff.

#### Integration tests (only where a golden cannot reach)

Some behaviour cannot be captured visually: gestures, scroll and animation driven selection, overlays and controllers.
For those, add an integration test to [example/integration_test/](example/integration_test/) and register it in [app_test.dart](example/integration_test/app_test.dart),
which bundles all of them into the single run performed by CI on an iOS simulator.

**Only add an integration test for non-trivial logic.** A test that merely asserts a callback is wired up — for example that `onItemSelected` is actually called when an item is tapped — is trivial and should not be added.
Ask yourself whether the test could realistically catch a regression that neither the golden test nor the analyzer would.

Name integration tests `subject_whenCondition_thenExpectation` and reuse the helpers in [widget_tester_extensions.dart](example/integration_test/widget_tester_extensions.dart) where they fit.


[Golden Tests]: (https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)

[Keep A Changelog]: (https://keepachangelog.com/en/1.1.0/)

[Semantic Commit Messages]: (https://sparkbox.com/foundry/semantic_commit_messages)

[Design Specs]: (https://digital.sbb.ch/de/design-system/mobile/overview/)

[Contributing to a project]: https://git-scm.com/book/ms/v2/GitHub-Contributing-to-a-Project