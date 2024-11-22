### Release

The maintainers of this library can create a release by triggering the `Design System Flutter Release` workflow with the _patch_, _minor_ or _major_ option. This does several things:

1. Update the `pubspec.yaml` to reflect the new version.
2. Update the `CHANGELOG.md` to reflect the new version.
3. Commit and tag these changes in a new commit by the `@github-action[bot]`.
4. Create a GitHub release with the notes from the top `CHANGELOG.md` section (from the `github-release.yml` workflow).