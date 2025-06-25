#!/bin/bash

SHORTCUT_DIR="$HOME/.shortcuts"
BIN_DIR="/usr/local/bin"

mkdir -p "$SHORTCUT_DIR"

print_usage() {
  echo "Usage:"
  echo "  st                     # Create a new shortcut interactively"
  echo "  st --del <name>        # Delete an existing shortcut"
  echo "  st --help              # Show this help message"
}

# === Delete mode ===
if [[ "$1" == "--del" ]]; then
  if [[ -z "$2" ]]; then
    echo "❌ Error: No shortcut name provided."
    print_usage
    exit 1
  fi

  shortcut="$2"
  shortcut_path="$SHORTCUT_DIR/$shortcut"
  bin_path="$BIN_DIR/$shortcut"

  if [[ ! -f "$shortcut_path" && ! -f "$bin_path" ]]; then
    echo "⚠️ Shortcut '$shortcut' does not exist."
    exit 1
  fi

  # Remove both if exist
  rm -f "$shortcut_path"
  sudo rm -f "$bin_path"

  echo "🗑️  Shortcut '$shortcut' deleted."
  exit 0
fi

# === Help ===
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  print_usage
  exit 0
fi

# === Create shortcut interactively ===
echo -n "Type in command to shortcut: "
read -r user_command

if [[ -z "$user_command" ]]; then
  echo "❌ No command entered. Exiting."
  exit 1
fi

echo -n "Type in shortcut name: "
read -r shortcut_name

# Validate shortcut name
if [[ ! "$shortcut_name" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
  echo "❌ Invalid shortcut name. Use only letters, numbers, underscores, or dashes."
  exit 1
fi

shortcut_path="$SHORTCUT_DIR/$shortcut_name"
echo "#!/bin/bash" > "$shortcut_path"
echo "$user_command" >> "$shortcut_path"

chmod +x "$shortcut_path"

# Create or overwrite in bin
sudo ln -sf "$shortcut_path" "$BIN_DIR/$shortcut_name"

echo "✅ Shortcut '$shortcut_name' created successfully!"
