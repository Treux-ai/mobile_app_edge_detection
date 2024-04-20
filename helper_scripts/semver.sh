#!/bin/bash
# Run this script to bump the version of the package.

# Function to display help message
display_help() {
    echo "Usage: $0 [OPTION]"
    echo "Bumps the version in pubspec.yaml file."
    echo
    echo "Options:"
    echo "  --major       Bump the major version"
    echo "  --minor       Bump the minor version"
    echo "  --patch       Bump the patch version (default)"
    echo "  --help        Display this help message"
}

# Function to bump the version based on the provided argument
bump_version() {
    local version=$1
    local part=$2

    # Split the version into its components
    IFS='.' read -r major minor patch build_number <<<"$(echo "$version" | tr '+' '.')"

    case "$part" in
    "major")
        new_major=$((major + 1))
        new_version="$new_major.$minor.$patch+$build_number"
        ;;
    "minor")
        new_minor=$((minor + 1))
        new_version="$major.$new_minor.$patch+$build_number"
        ;;
    "patch")
        new_patch=$((patch + 1))
        new_version="$major.$minor.$new_patch+$build_number"
        ;;
    "build_number")
        new_build_number=$((build_number + 1))
        new_version="$major.$minor.$patch+$new_build_number"
        ;;
    *)
        echo "Invalid argument. Defaulting to patch bump."
        new_patch=$((patch + 1))
        new_version="$major.$minor.$new_patch+$build_number"
        ;;
    esac

    echo "$new_version"
}

# Get the current version
current_version=$(grep "version:" pubspec.yaml | sed 's/.*: //')

# Determine which part to bump
if [ "$1" == "--major" ]; then
    new_version=$(bump_version "$current_version" "major")
elif [ "$1" == "--minor" ]; then
    new_version=$(bump_version "$current_version" "minor")
elif [ "$1" == "--patch" ]; then
    new_version=$(bump_version "$current_version" "patch")
elif [ "$1" == "--build_number" ]; then
    new_version=$(bump_version "$current_version" "build_number")
elif [ "$1" == "--help" ]; then
    display_help
    exit 0
else
    echo "No valid argument provided. Defaulting to patch bump."
    new_version=$(bump_version "$current_version" "patch")
fi

# Update the pubspec.yaml file
echo "Incrementing version to $new_version"
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -e "s/version: $current_version/version: $new_version/g" pubspec.yaml
else
    sed -i -e "s/version: $current_version/version: $new_version/g" pubspec.yaml
fi
