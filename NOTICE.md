# Notice

This project's source code is licensed under the [MIT License](LICENSE).
Some bundled assets are licensed separately and are **not** covered by the
MIT grant. This file lists those exceptions.

## SBB Web font (`lib/fonts/SBBWeb-*.ttf`)

Licensed to SBB AG by URW++ GmbH under the SBB Font License 1.0, not MIT.
See [`LICENSES/LicenseRef-SBBFL-1.0.txt`](LICENSES/LicenseRef-SBBFL-1.0.txt).

That license grants SBB AG a corporate license to the modified Nimbus Sans
Novus typefaces, scoped to non-commercial disclosure to third parties for
projects carried out on behalf of and for SBB AG. The font file itself
carries a matching embedded EULA string ("Weitergabe der Fontdaten für
Dienstleistungen im Auftrage von SBB AG erlaubt.").

**This is narrower than the MIT terms this repository otherwise offers.**
Consumers of this package do not receive MIT rights (free commercial use,
sublicensing, redistribution) over the font binaries — only whatever the
SBBFL-1.0 text above actually permits. Whether that license's scope covers
unrestricted public distribution via a package registry (as opposed to
SBB-commissioned project work) has not been confirmed with SBB legal / URW
as of this writing; treat the font as restricted-use until that is settled.

## SBB icon fonts (`lib/fonts/sbb_icons_*.ttf`)

Generated from SBB's internal icon set (`icons.app.sbb.ch`, see
`tool/font_scripts`). These are SBB AG's own iconography, not covered by
SBBFL-1.0 (which only concerns the Nimbus Sans Novus-derived typefaces) and
not covered by the repository's MIT license either. No license terms for
these files have been formalized. **Follow-up needed:** SBB brand/legal
should confirm the intended terms and this notice should be updated
accordingly.

## Everything else

All other source files, illustrations, and assets in this repository are
covered by the MIT License unless a `REUSE.toml` annotation says otherwise.
