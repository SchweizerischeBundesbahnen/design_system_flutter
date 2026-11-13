#!/usr/bin/env bash
# This script keeps one open issue per new icon lib version and reports failed updates on it.
#
# Usage:
#   ./update-issue.sh <version> <outcome> <run_url>
#
# Arguments:
#   <version> The new version of the icon lib.
#   <outcome> failure, success (the pull request was created or updated) or pending.
#   <run_url> The URL of the workflow run.
#
# Behavior:
# - Opens an issue labeled "icon-lib-update" if there is no open one.
# - Retitles the open issue and comments on it if a newer version is available.
# - On failure, creates or edits a single warning comment linking the run.
# - On success, marks an existing warning comment as resolved.
# - On pending, only opens or updates the issue.
# - Writes the issue number to the "number" step output.
#
# Requires GH_TOKEN with issues: write and GITHUB_REPOSITORY.

set -euo pipefail

version="$1"
outcome="$2"
run_url="$3"

label="icon-lib-update"
title="Icon lib v${version} available"
marker="<!-- icon-lib-update-failure -->"

if ! gh label list --search "$label" --json name --jq '.[].name' | grep -qx "$label"; then
  gh label create "$label" --color FBCA04 --description "A new icon lib version is available"
fi

number="$(gh issue list --label "$label" --state open --limit 1 --json number --jq '.[0].number // empty')"
if [[ -z "$number" ]]; then
  body="A new version of the [SBB icon lib](https://github.com/sbb-design-systems/sbb-icons/tags) is available.
The nightly_update_icon_lib workflow opens a pull request that closes this issue.
Failed updates are reported in a comment below."
  issue_url="$(gh issue create --title "$title" --label "$label" --body "$body")"
  number="${issue_url##*/}"
  echo "Opened issue #${number}."
elif [[ "$(gh issue view "$number" --json title --jq .title)" != "$title" ]]; then
  gh issue edit "$number" --title "$title"
  gh issue comment "$number" --body "Icon lib v${version} is now available and supersedes the previous version."
  echo "Retitled issue #${number} to v${version}."
fi
echo "number=${number}" >> "$GITHUB_OUTPUT"

comment_id="$(gh api --paginate "repos/${GITHUB_REPOSITORY}/issues/${number}/comments" \
  --jq ".[] | select(.body | startswith(\"${marker}\")) | .id" | head -n 1)"

if [[ "$outcome" == "failure" ]]; then
  body="${marker}
### ⚠️ Icon lib update failed

The update to v${version} failed. No pull request was created or updated. See the run log for the failed checks.

Last attempt: $(date -u '+%Y-%m-%d %H:%M UTC') in [this run](${run_url})"
elif [[ "$outcome" == "success" && -n "$comment_id" ]] && ! gh api "repos/${GITHUB_REPOSITORY}/issues/comments/${comment_id}" --jq .body | grep -q '✅'; then
  body="${marker}
### ✅ Resolved in [this run](${run_url})"
else
  exit 0
fi

if [[ -n "$comment_id" ]]; then
  gh api --method PATCH "repos/${GITHUB_REPOSITORY}/issues/comments/${comment_id}" -f body="$body" >/dev/null
  echo "Edited the warning comment on issue #${number}."
else
  gh issue comment "$number" --body "$body"
fi
