# Activation Script

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Shell Script](https://img.shields.io/badge/Script-Shell-blue.svg)](https://www.shellscript.sh/) [![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)]()

This is a shell script named `activation` that copies all regular files from the current directory to `/usr/local/bin`, replacing any existing files with the same name, and makes the copied files executable.

## Features

- Copies only regular files (non-recursive) from the current directory.
- Replaces existing files in `/usr/local/bin` with the new versions.
- Uses `sudo` to handle permission requirements for copying and setting executable permissions.
- Makes all copied files executable using `chmod +x`.
- Suitable for making CLI scripts and apps globally accessible.

## Usage

1. Place the `activation` script in the directory containing the files you want to copy to `/usr/local/bin`.
2. Run the script:

```bash
bash ./activation
```

3. You will be prompted for your password due to the use of `sudo`.
4. After execution, all regular files from the current directory will be copied to `/usr/local/bin` and made executable.

## Current Apps and CLI

- This script is designed to help deploy shell scripts, CLI tools, and small apps by copying them to a system-wide executable path.
- It is ideal for personal scripts or small utilities you want to run from anywhere in the terminal.

## Notes

- Ensure you have the necessary permissions to use `sudo`.
- The script does not copy directories or hidden files.
- Use this script to quickly make your scripts or executables available system-wide.

## License

This project is licensed under the terms of the Apache License 2.0.
