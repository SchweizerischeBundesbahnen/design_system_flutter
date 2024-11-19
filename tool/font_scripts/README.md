# Font Scripts
Scripts to update the SBB CDN icon fonts from https://icons.app.sbb.ch/

## Usage
Make sure, npm and fvm flutter are installed.

### First usage
```shell
npm i
fvm flutter pub get
```

### every update
```shell
dart lib/update_icon_fonts.dart
```

### generated files

* **.ttf files**: move these to lib/fonts/
* **sbb_icons.dart**: move this lib/src/theme/sbb_icons/
* **sbb_icons_index.dart**: move this example/lib/