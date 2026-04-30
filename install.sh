#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GRADLE_INIT_DIR="$HOME/.gradle/init.d"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$GRADLE_INIT_DIR" "$BIN_DIR"

cp "$SCRIPT_DIR/build-tracker.gradle" "$GRADLE_INIT_DIR/build-tracker.gradle"
cp "$SCRIPT_DIR/bt" "$BIN_DIR/bt"
chmod +x "$BIN_DIR/bt"

echo "Installed successfully."
echo ""

if ! echo "$PATH" | tr ':' '\n' | grep -qx "$BIN_DIR"; then
  echo "  ACTION REQUIRED: $BIN_DIR is not in your PATH."
  echo "  Add this line to ~/.zshrc or ~/.bashrc:"
  echo ""
  echo '    export PATH="$HOME/.local/bin:$PATH"'
  echo ""
  echo "  Then reload: source ~/.zshrc"
  echo ""
  echo "  After that, run any Gradle build and then: bt"
else
  echo "  $BIN_DIR already in PATH."
  echo "  Run any Gradle build, then: bt"
fi
