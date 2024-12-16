### Release

##### Release PR

The maintainers of this library can create a release by triggering the `make-release-pr` 
workflow with the _patch_, _minor_ or _major_ option. This does several things:

1. Update the `pubspec.yaml` to reflect the new version.
2. Update the `CHANGELOG.md` to reflect the new version.
3. Commit and tag these changes in a new commit by the `sbb-app-bakery[bot]`.
4. Create a pull request with these changes with the `autorelease` label.

##### Github release

Merging a pull request with the `autorelease` label will trigger the `github-release` workflow that does several things:

1. Create a tag with the new version from the `CHANGELOG.md`.
2. Make a github release based on the `CHANGELOG.md` and the version of the tag.

##### Pub Dev release

The creation of a tag in the `github-release` workflow triggers the `pubdev-release` workflow that will complete
all necessary steps for publishing the package to pubdev.

##### Example App release

Merging a pull request with the `autorelease` label will trigger the `android-release` workflow that

1. Builds the app
2. Signs the app
3. Publishes the app to the enterprise app store in the `alpha` channel


