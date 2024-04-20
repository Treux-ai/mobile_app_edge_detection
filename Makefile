#: bump - Increment patch version in pubspec.yaml
.PHONY: bump
bump:
	bash helper_scripts/semver.sh --patch

#: bump_patch - Increment patch version in pubspec.yaml
.PHONY: bump_patch
bump_patch:
	bump

#: bump_minor - Increment minor version in pubspec.yaml
.PHONY: bump_minor
bump_minor:
	bash helper_scripts/semver.sh --minor

#: bump_major - Increment major version in pubspec.yaml
.PHONY: bump_major
bump_major:
	bash helper_scripts/semver.sh --major

#: bump_build_number - Increment build number in pubspec.yaml
.PHONY: bump_build_number
bump_build_number:
	bash helper_scripts/semver.sh --build_number