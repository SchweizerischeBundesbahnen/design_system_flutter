This Flutter package contains official UI elements of the SBB (Swiss Federal Railways) [Design System Mobile].
It allows an easy integration of SBB theming to your Flutter app (with the possibility of a custom color theming).
Elements are optimized for dynamic TextSizes, VoiceOver, light & dark mode.

## Table of Contents

<details>
<summary>Click to expand</summary>

- [Table of Contents](#table-of-contents)
- [Getting Started](#getting-started)
    - [Supported platforms](#supported-platforms)
    - [In code usage](#in-code-usage)
  - [Example App](#example-app)
- [Documentation](#documentation)
    - [Design System Mobile specification](#design-system-mobile-specification)
    - [SBB internal documentation](#sbb-internal-documentation)
  - [Read on](#read-on)
- [License](#license)
- [Contributing](#contributing)
  - [Testing](#testing)
  - [Coding Standards](#coding-standards)
  - [Code of Conduct](#code-of-conduct)
  - [Releasing](#releasing)
- [Maintainer](#maintainer)
- [Credits](#credits)


</details>

<a id="Getting-Started"></a>

## Getting Started

#### Supported platforms

<div id="supported_platforms">
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android"/>
  <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white" alt="iOS">
</div>

#### In code usage

In order for the Theming to work, you need to add the `SBBTheme.light` / `SBBTheme.dark` to your app root. For a `MaterialApp`:

```Dart
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SBB DSM',
      theme: SBBTheme.light(),
      darkTheme: SBBTheme.dark(),
      home: const MyHomePage(),
    );
  }
}

```

### Example App

The **Flutter DSM** demo application is currently only available in the SBB Enterprise Playstore (Android).

<p align="left"><img src="https://raw.githubusercontent.com/SchweizerischeBundesbahnen/design_system_flutter/main/example/gallery/example_app_icon.webp" alt="Icon of the example app" width="5%"></p>

<a id="Documentation"></a>

## Documentation

#### Design System Mobile specification

The elements follow the design specifications found in [Design System Mobile] as closely as possible.

The pixel exact specifications can be found in the [Figma](https://www.figma.com/design/WOtLIam1xwrqcgnAITsEhV/Design-System-Mobile) (view only).

#### SBB internal documentation

A the moment, the following documents are only available to people internal to SBB:
* [AppBakery libraries](https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx "AppBakery libraries")

### Read on

- [CODING_STANDARDS.md](CODING_STANDARDS.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [LICENSE](LICENSE)
- [Getting Started SBB Design System](https://digital.sbb.ch/de/design-system/getting-started/designing/)
- [Accessibility](https://digital.sbb.ch/de/accessibility/introduction/about-this-guide/)
- [Colors](https://digital.sbb.ch/de/foundation/colors/base-colors/)
- [Principles](https://digital.sbb.ch/de/principles/ux-principles/overview/)

<a id="License"></a>

## License

This project is licensed under [MIT](LICENSE.md).

<a id="Contributing"></a>

## Contributing

Generally speaking, we are welcoming contributions improving existing UI elements or fixing certain bugs. We will also consider contributions introducing new design elements, but might reject them, if they do not reflect our vision of SBB Design System.

General instructions on _how_ to contribute can be found under [Contributing](Contributing.md).


### Testing
This project is built and tested using [Github Actions](https://docs.github.com/en/actions). On every PR request, a `test` workflow is triggered, which does the following:

* running all tests in the `.\test\` dir. Failed golden tests will be uploaded to the job artifacts. The tests run on a _macos_ runner.
* parse the `CHANGELOG.md` file and compare against the [Keep A Changelog](https://keepachangelog.com/en/1.1.0/) schema. This allows for automatic release notes from our Changelog.
* Build the example app in `example` for the minimum and latest supported Flutter SDK for both iOS and Android.

### Coding Standards

See [CODING_STANDARDS.md](CODING_STANDARDS.md).

<a id="code-of-conduct"></a>

### Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

### Releasing

See [Release.md](Release.md).

<a id="Contributing"></a>

## Maintainer

* [Hoang Tran](https://github.com/VanHoangTran)
* [Nico Vidoni](https://github.com/smallTrogdor)

## Credits

In addition to the contributors on GitHub, we thank the following authors for their previous work:
*  Patrice Müller
*  Dominik Schmucki


[Design System Mobile]: https://digital.sbb.ch/en/design-system/mobile/overview/