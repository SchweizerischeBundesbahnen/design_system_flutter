# Font Scripts
Scripts to update the SBB icon fonts from the latest `vX.Y.Z` tag of https://github.com/sbb-design-systems/sbb-icons.

The [nightly_update_icon_lib](../../.github/workflows/nightly-update-icon-lib.yml) workflow runs this script every
night in CI and opens a pull request for a new version. Usually, it should not be run locally except for development
of the script itself.

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

Set `GITHUB_TOKEN` to avoid the rate limit of anonymous GitHub API requests.

### checks

The update fails, without writing `icons/.version` or the Dart files, if:

* the download fails after retries or returns a non-200 response
* the archive's `icons/index.json` is missing, has another version than the tag or lists a sized icon without SVG
* `npm install`, `npm run fix` or `npm run generate` fails
* a font does not have exactly one glyph per unique icon of its size in `index.json`

The failed checks are listed in the output.

### tests

```shell
dart test
```

### generated files

* **.ttf files**: move these to lib/fonts/
* **sbb_icons.dart**: move this to lib/src/theme/
* **sbb_icons_index.dart**: move this to lib/src/theme/
