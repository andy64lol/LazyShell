#!/bin/bash

SHORTCUT_DIR="$HOME/.shortcuts"
mkdir -p "$SHORTCUT_DIR"

echo -n "Type in command to shortcut: "
read -r user_command

if [[ -z "$user_command" ]]; then
  echo "❌ No command entered. Exiting."
  exit 1
fi

echo -n "Type in shortcut name: "
read -r shortcut_name

# Check valid shortcut name
if [[ ! "$shortcut_name" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
  echo "❌ Invalid shortcut name. Must be a valid command name."
  exit 1
fi

# Write the command as a script
shortcut_path="$SHORTCUT_DIR/$shortcut_name"
echo "#!/bin/bash" > "$shortcut_path"
echo "$user_command" >> "$shortcut_path"

chmod +x "$shortcut_path"

# Create a symlink or copy to /usr/local/bin
sudo ln -sf "$shortcut_path" "/usr/local/bin/$shortcut_name"

echo "✅ Shortcut '$shortcut_name' created successfully!"
