# Design System Mobile for Flutter
![GitHub](https://img.shields.io/github/license/SchweizerischeBundesbahnen/design_system_flutter)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/SchweizerischeBundesbahnen/design_system_flutter/Flutter%20CI)

[Design System Mobile](https://digital.sbb.ch/en/design-system/mobile/overview/) in Flutter.

This framework contains SBB (Swiss Federal Railways) UI elements for Flutter Apps. It allows an easy integration of SBB theming to your app (or a custom color theming of your choice). All elements are optimized for dynamic TextSizes, VoiceOver, light & dark mode as well as for different SizeClasses.

*Note:* This plugin is still under development and some APIs might change. Feedback and Pull Requests are most welcome!

## Usage
---
To use this plugin, add `design_system_flutter` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). As this is a private plugin, you must add it as a Git dependency:
```yaml
dependencies:
  design_system_flutter:
    git:
      url: https://github.com/SchweizerischeBundesbahnen/design_system_flutter.git
```
## Getting Started
---
### Dart/Flutter Integration
From your Dart code, you need to import the plugin and instantiate it:
```Dart
import 'package:design_system_flutter/design_system_flutter.dart';
```

After that simply use the provided fonts, styles, colors, widgets...

### SBB internal documentation

A the moment, the following documents are only available to people internal to SBB:
* [SBB Design System Mobile documentation](https://digital.sbb.ch/en/design-system/mobile/overview/ "Design System Mobile documentation")
* [Figma](https://www.figma.com/file/WOtLIam1xwrqcgnAITsEhV/Design-System-Mobile "Figma library")
* [AppBakery libraries](https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx "AppBakery libraries")

## Getting help

If you need help, you can reach out to us by e-mail: [mobile@sbb.ch](mailto:mobile@sbb.ch?subject=[GitHub]%20MDS%20Flutter)

## Getting involved

Generally speaking, we are welcoming contributions improving existing UI elements or fixing certain bugs. We will also consider contributions introducing new design elements, but might reject them, if they do not reflect our vision of SBB Design System.

General instructions on _how_ to contribute can be found under [Contributing](Contributing.md).

### Github Actions

#### Testing
This project is built and tested using [Github Actions](https://docs.github.com/en/actions). On every PR request, a `test` workflow is triggered, which does the following:

* running all tests in the `.\test\` dir. Failed golden tests will be uploaded to the job artifacts. The tests run on a _macos_ runner.
* parse the `CHANGELOG.md` file and compare against the [Keep A Changelog](https://keepachangelog.com/en/1.1.0/) schema. This allows for automatic release notes from our Changelog.
* Build the example app in `example` for the minimum and latest supported Flutter SDK for both iOS and Android.

#### Releasing
The maintainers of this library can create a release by triggering the `Design System Flutter Release` workflow with the _patch_, _minor_ or _major_ option. This does several things:

1. Update the `pubspec.yaml` to reflect the new version.
2. Update the `CHANGELOG.md` to reflect the new version.
3. Commit and tag these changes in a new commit by the `@github-action[bot]`.
4. Create a GitHub release with the notes from the top `CHANGELOG.md` section (from the `github-release.yml` workflow).

## Authors

* **Hoang Tran**
* **Dominik Mosberger**
* **Nicolas Vidoni**
* **Dominik Schmucki**
* **Ulrich Raab**
* **Patrice Müller**
* **Michael Moor**
* **Loris Sorace**
* **Cyrill Meyer**
* **Ralf Winkelmann**
* **Yoonjoo Lee**

## License

Code released under the [MIT](LICENSE).
