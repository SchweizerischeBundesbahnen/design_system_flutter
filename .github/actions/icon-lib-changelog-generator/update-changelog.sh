# This script updates the "Unreleased" section of a CHANGELOG file to include or modify
# an entry for updating the icon lib version. It ensures that the entry is added
# or updated in the appropriate location within the "### Changed" subsection of the
# "## [Unreleased]" section.
#
# Usage:
#   ./update-changelog.sh <version> <changelog_file>
#
# Arguments:
#   <version>        The version of the icon library to be added or updated.
#   <changelog_file> The path to the CHANGELOG file to be modified.
#
# Behavior:
# - If the "## [Unreleased]" section does not contain a "### Changed" subsection,
#   it will be created.
# - If an entry for the icon library update already exists, it will be updated
#   with the provided version.
# - If no entry exists, a new entry will be added to the "### Changed" subsection.
#
# Requirements:
# - The specified CHANGELOG file must exist.
# - The script requires `awk` to process the file.
#
# Example:
#   ./update-changelog.sh 1.2.3 CHANGELOG.md

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <version> <changelog_file>"
  exit 1
fi

VERSION="$1"
CHANGELOG_FILE="$2"

if [ ! -f "$CHANGELOG_FILE" ]; then
  echo "Error: File '$CHANGELOG_FILE' not found!"
  exit 1
fi

awk -v version="$VERSION" '
BEGIN {
  unreleased_found = 0
  changed_found = 0
  changed_entries_found = 0
  entry_added = 0
}
{
  if (entry_added) {
    print $0
    next
  }

  if ($0 ~ /^## \[Unreleased\]/) {
    unreleased_found = 1
    print $0
    next
  }

  if (unreleased_found && $0 ~ /^### Changed/) {
    changed_found = 1
    print $0
    next
  }

  if (unreleased_found && changed_found && $0 ~ /^\- \(auto\): updated icon lib to version /) {
    $0 = "- (auto): updated icon lib to version " version
    entry_added = 1
    print $0
    next
  }

  if (unreleased_found && changed_found && !changed_entries_found && $0 !~ /^$/) {
    changed_entries_found = 1
    print $0
    next
  }

  if (unreleased_found && changed_found && changed_entries_found && !entry_added && $0 ~ /^$/) {
    # changed section is over without having added the line
    $0 = "- (auto): updated icon lib to version " version "\n"
    entry_added = 1
  }
  if (unreleased_found && !changed_found && $0 ~ /^## /) {
    # unreleased section is over without changed
    $0 = "### Changed\n\n- (auto): updated icon lib to version " version "\n\n" $0
    entry_added = 1
  }

  print $0
}' "$CHANGELOG_FILE" > "${CHANGELOG_FILE}.tmp"

mv "${CHANGELOG_FILE}.tmp" "$CHANGELOG_FILE"
