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

### Expectations from a pull request

All new code should have associated unit tests ([Golden Tests] for UI elements) that validate implemented features and the presence or lack of defects. Take a look at existing golden tests (e.g. [sbb_chip_test.dart](test/sbb_chip_test.dart)) as reference.

Additionally, the code should follow the patterns and structure found in other components, unless there is a clear reason why not to.

It is mandatory to update the [CHANGELOG.md](CHANGELOG.md) file with clear description of what has changed. Stick to the [Keep a Changelog] format and [Semantic Commit Messages].

Your code will be analyzed and formatted according to the rules defined in [analysis_options.yaml](analysis_options.yaml).

Take a look at the [github test action](.github/workflows/test.yml) that will run on every pull request update to understand which tests are run on our CI.

The naming of the Widgets should follow the naming from the [Design specs].


[Golden Tests]: (https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
[Keep A Changelog]: (https://keepachangelog.com/en/1.1.0/)
[Semantic Commit Messages]: (https://sparkbox.com/foundry/semantic_commit_messages)
[Design Specs]: (https://digital.sbb.ch/de/design-system/mobile/overview/)
[Contributing to a project]: https://git-scm.com/book/ms/v2/GitHub-Contributing-to-a-Project