#!/bin/bash

SHORTCUT_DIR="$HOME/.shortcuts"
BIN_DIR="/usr/local/bin"

mkdir -p "$SHORTCUT_DIR"

print_usage() {
  echo "Usage:"
  echo "  st                     # Create a new shortcut interactively"
  echo "  st --del <name>        # Delete an existing shortcut (also accepts -del)"
  echo "  st -ls                 # List all shortcuts (also accepts --ls)"
  echo "  st -edit <name>        # Edit an existing shortcut (also accepts --edit)"
  echo "  st --help              # Show this help message (also accepts -h/-help)"
}

# Normalize incoming flag (accept -foo, --foo, -fooBar, --fooBar)
NORMALIZE_FLAG() {
  local raw="$1"
  if [ -z "$raw" ]; then
    echo ""
    return
  fi
  while [[ "$raw" == -* ]]; do raw="${raw#-}"; done
  echo "$raw"
}

FLAG=$(NORMALIZE_FLAG "$1")

# === List shortcuts ===
if [[ "$FLAG" == "ls" ]]; then
  echo "Shortcuts in $SHORTCUT_DIR:"
  if [ -z "$(ls -A "$SHORTCUT_DIR")" ]; then
    echo "  No shortcuts found."
  else
    for file in "$SHORTCUT_DIR"/*; do
      shortcut_name=$(basename "$file")
      command_line=$(head -n 2 "$file" | tail -n 1)
      echo "  $shortcut_name -> $command_line"
    done
  fi
  exit 0
fi

# === Delete mode ===
if [[ "$FLAG" == "del" ]]; then
  if [[ -z "$2" ]]; then
    echo "Error: No shortcut name provided."
    print_usage
    exit 1
  fi

  shortcut="$2"
  shortcut_path="$SHORTCUT_DIR/$shortcut"
  bin_path="$BIN_DIR/$shortcut"

  if [[ ! -f "$shortcut_path" && ! -f "$bin_path" ]]; then
    echo "Shortcut '$shortcut' does not exist."
    exit 1
  fi

  # Remove both if exist
  rm -f "$shortcut_path"
  sudo rm -f "$bin_path"

  echo "Shortcut '$shortcut' deleted."
  exit 0
fi

# === Edit shortcut ===
if [[ "$FLAG" == "edit" ]]; then
  if [[ -z "$2" ]]; then
    echo "Error: No shortcut name provided."
    print_usage
    exit 1
  fi

  shortcut="$2"
  shortcut_path="$SHORTCUT_DIR/$shortcut"

  if [[ ! -f "$shortcut_path" ]]; then
    echo "Shortcut '$shortcut' does not exist."
    exit 1
  fi

  echo "Current command for '$shortcut':"
  sed -n '2p' "$shortcut_path"
  echo
  echo -n "Enter new command: "
  read -r new_command

  if [[ -z "$new_command" ]]; then
    echo "No command entered. Exiting."
    exit 1
  fi

  echo "#!/bin/bash" > "$shortcut_path"
  echo "$new_command" >> "$shortcut_path"
  chmod +x "$shortcut_path"

  # Update symlink in /usr/local/bin
  sudo ln -sf "$shortcut_path" "$BIN_DIR/$shortcut"

  echo "Shortcut '$shortcut' updated successfully!"
  exit 0
fi

# === Help ===
if [[ "$FLAG" == "h" || "$FLAG" == "help" ]]; then
  print_usage
  exit 0
fi

# === Create shortcut interactively ===
echo -n "Type in command to shortcut: "
read -r user_command

if [[ -z "$user_command" ]]; then
  echo "No command entered. Exiting."
  exit 1
fi

echo -n "Type in shortcut name: "
read -r shortcut_name

# Validate shortcut name
if [[ ! "$shortcut_name" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
  echo "Invalid shortcut name. Use only letters, numbers, underscores, or dashes."
  exit 1
fi

shortcut_path="$SHORTCUT_DIR/$shortcut_name"
echo "#!/bin/bash" > "$shortcut_path"
echo "$user_command" >> "$shortcut_path"

chmod +x "$shortcut_path"

# Create or overwrite in bin
sudo ln -sf "$shortcut_path" "$BIN_DIR/$shortcut_name"

echo "Shortcut '$shortcut_name' created successfully!"