#!/bin/bash

# Function to install python3
install_python3() {
  echo "🔍 Attempting to install python3..."
  if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y python3
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y python3
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y python3
  else
    echo " Unsupported package manager. Please install python3 manually."
    exit 1
  fi
}

# Function to install pip
install_pip() {
  echo "🔧 pip3 is not installed. Attempting to install pip..."
  curl -sS https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
  if [ $? -ne 0 ]; then
    echo " Failed to download get-pip.py"
    exit 1
  fi

  python3 /tmp/get-pip.py
  if [ $? -ne 0 ]; then
    echo " Failed to install pip"
    exit 1
  fi
  echo " pip installed successfully."
}

# Check if python3 is installed
if ! command -v python3 >/dev/null 2>&1; then
  install_python3
fi

# Check if pip is installed
if ! command -v pip3 >/dev/null 2>&1; then
  install_pip
fi

# Show versions
if [ "$1" == "pyver" ]; then
  echo " Python version: $(python3 --version)"
  echo " Pip version: $(pip3 --version)"
  exit 0
fi

# Check if a Python file is provided
if [ -z "$1" ]; then
  echo "Usage:"
  echo "  py filename.py [args...]  - Run a Python script"
  echo "  py pyver                  - Show Python and pip versions"
  exit 1
fi

# Run the Python file
python3 "$@"
