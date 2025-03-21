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

Generally speaking, you should *fork* this repository, make changes in your own fork, and then submit a pull request.

All new code should have associated unit tests ([Golden Tests] for UI elements) that validate implemented features and the presence or lack of defects.

Additionally, the code should follow any stylistic and architectural guidelines prescribed by the project. In the absence of such guidelines, mimic the styles and patterns in the existing code-base.

Please also update the CHANGELOG.md accordingly respecting the [Keep A Changelog] format. If possible, stick to [Semantic Commit Messages].

The naming of the Widgets should follow the Material equivalent Widgets. However, the component names within the [Design Specs] and links should be provided to the english [Design Specs] should be findable in the codebase.


[Golden Tests]: (https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
[Keep A Changelog]: (https://keepachangelog.com/en/1.1.0/)
[Semantic Commit Messages]: (https://sparkbox.com/foundry/semantic_commit_messages)
[Design Specs]: (https://digital.sbb.ch/de/design-system/mobile/overview/)