# Design System Mobile for Flutter
https://img.shields.io/github/license/SchweizerischeBundesbahnen/design_system_flutter
https://img.shields.io/github/workflow/status/SchweizerischeBundesbahnen/design_system_flutter/Flutter%20CI



[Design System Mobile](https://designsystems.app.sbb.ch/) in Flutter (yes, it could be that easy...).

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

A the moment, the following documents are only available to persons internal to SBB:
* [SBB Design System Mobile documentation](https://digital.sbb.ch/de/design-system-mobile-new "Design System Mobile documentation") (new version since 2021)
* [AppBakery libraries](https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx "AppBakery liraries")
* [Figma](https://www.figma.com/file/56woOj0p1qEOrZiTzi4mJ7/SBB-Mobile-Library-%28draft%29 "Figma library")

## Getting help

If you need help, you can reach out to us by e-mail: [mobile@sbb.ch](mailto:mobile@sbb.ch?subject=[GitHub]%20MDS%20Flutter)

## Getting involved

Generally speaking, we are welcoming contributions improving existing UI elements or fixing certain bugs. We will also consider contributions introducing new design elements, but might reject them, if they do not reflect our vision of SBB Design System.

General instructions on _how_ to contribute can be found under [Contributing](Contributing.md).

## Authors

* **Tran Hoang**
* **Raab Ulrich**
* **Mosberger Dominik**
* **Schmucki Dominik**
* **Müller Patrice**

## License

Code released under the [MIT](LICENSE).
