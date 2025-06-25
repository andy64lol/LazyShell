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

## Command Usage

Below are the available commands/scripts in this repository, with detailed descriptions, options, and usage examples for each:

### activation
Copies all regular (non-hidden, non-directory) files from the current directory to `/usr/local/bin`, replacing any existing files with the same name, and makes them executable. Requires `sudo` privileges.

- **Usage:**
  ```bash
  bash ./activation
  ```
- **Behavior:**
  - Skips directories and hidden files.
  - Overwrites files in `/usr/local/bin` if they exist.
  - Makes all copied files executable (`chmod +x`).
  - Prompts for your password if required by `sudo`.

### del
Deletes a specified file from the current directory or a given path.

- **Usage:**
  ```bash
  del <filename>
  del /path/to/file.txt
  ```
- **Behavior:**
  - Removes the file if it exists.
  - May prompt for confirmation if the script is interactive.
  - Does not delete directories.

### gitauto
Automates git add, commit, and push for the current repository.

- **Usage:**
  ```bash
  gitauto
  ```
- **Behavior:**
  - Stages all changes (`git add .`).
  - Commits with a default message.
  - Pushes to the current branch's remote.

### gitid
Displays the current git user name and email configuration.

- **Usage:**
  ```bash
  gitid
  ```
- **Behavior:**
  - Shows the output of `git config user.name` and `git config user.email`, I made it because I was lazy :P .

### gitstat
Shows a concise git status for the current repository.

- **Usage:**
  ```bash
  gitstat
  ```
- **Behavior:**
  - Runs `git status -s` or similar for a short summary.
  - May show branch info and staged/unstaged files.

### gitupdate
Pulls the latest changes from the remote repository.

- **Usage:**
  ```bash
  gitupdate
  ```
- **Behavior:**
  - Runs `git pull` for the current branch.
  - May show a summary of changes after pulling.

### inforepo
Shows detailed information about a git repository, because who has time to remember all that stuff?

- **Usage:**
  - Show info for the current directory:
    ```bash
    inforepo
    ```
  - Show info for a specific repo:
    ```bash
    inforepo /path/to/repo
    ```
  - Show help:
    ```bash
    inforepo --help
    ```
- **Behavior:**
  - Displays who created the repo and when (so you can blame them later).
  - Shows the remote URL and (approximate) clone date.
  - Counts lines of code and shows language stats (uses `cloc` if installed, otherwise does a lazy fallback).
  - Example output:
    ```
    ---- Repo Info for: /home/user/project ----
    Repository created by: John Doe <john@example.com>
    Creation date: 2023-01-01 12:00:00 +0000

    Remote URL: git@github.com:user/project.git
    Clone date (approx): 2023-01-02 09:00:00 +0000

    Lines of code and languages (cloc output or fallback):
    {
      "TotalLines": 1234,
      "Languages": {
        "sh": 1000,
        "md": 234
      }
    }
    -------------------------------
    ```
  - Great for lazy devs who want all the repo info in one go!

### py
Runs a Python script with the default Python interpreter.

- **Usage:**
  ```bash
  py <script.py> [args]
  py myscript.py arg1 arg2
  ```
- **Behavior:**
  - Equivalent to `python <script.py> [args]`.
  - Passes any additional arguments to the script.

### pyver
Shows the current Python version.

- **Usage:**
  ```bash
  pyver
  ```
- **Behavior:**
  - Runs `python --version` or `python3 --version` , same reasons.

### st
A shortcut manager to create and delete custom shell command shortcuts globally. (Because I'm too lazy to type long commands every time!)

- **Usage:**
  - Create a new shortcut interactively:
    ```bash
    st
    ```
  - Delete an existing shortcut:
    ```bash
    st --del <shortcut_name>
    ```
  - Show help:
    ```bash
    st --help
    ```
- **Behavior:**
  - Prompts for a command and a shortcut name, then creates a script in `~/.shortcuts` and links it to `/usr/local/bin/<shortcut_name>`. Now you can be even lazier!
  - Deletes shortcuts from both locations with `--del`.
  - Validates shortcut names (letters, numbers, underscores, dashes).
  - Example (create a shortcut):
    ```
    $ st
    Type in command to shortcut: echo Hello World
    Type in shortcut name: hello
    Shortcut 'hello' created successfully!
    $ hello
    Hello World
    ```
  - Example (delete a shortcut):
    ```
    $ st --del hello
    Shortcut 'hello' deleted. (Back to typing like a peasant)
    ```

## Notes

- Ensure you have the necessary permissions to use `sudo`.
- The script does not copy directories or hidden files.
- Use this script to quickly make your scripts or executables available system-wide.

## License

This project is licensed under the terms of the Apache License 2.0.
