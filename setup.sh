#!/usr/bin/env bash
set -euo pipefail

# 1) Create a Python virtualenv if it doesn't exist
VENV_DIR=venv
if [ ! -d "$VENV_DIR" ]; then
  echo "Creating Python venv in ./$VENV_DIR"
  python3 -m venv "$VENV_DIR"
fi

# 2) Activate the Python venv
#    On Windows you'd use `.\venv\Scripts\activate`
#    Here we're assuming a Unix‐like shell
source "$VENV_DIR/bin/activate"

# 3) Upgrade pip and install nodeenv
echo "Upgrading pip and installing nodeenv..."
pip install --upgrade pip
pip install nodeenv

# 4) Create a Node.js environment inside our Python venv
#    This will drop a standalone Node/bin/npm under venv/bin
echo "Bootstrapping nodeenv (will download Node.js and npm)..."
# you can pin --node=VERSION here if desired, e.g. --node=18.16.0
nodeenv --relocatable --prebuilt --npm .

# 5) Activate the nodeenv
#    (This simply ensures that `node` & `npm` in venv/bin are on $PATH)
source bin/activate

# 6) (Optional) Initialize a package.json if you don’t have one yet
if [ ! -f package.json ]; then
  echo "Initializing package.json"
  npm init -y
fi

# 7) Install the Claude Code SDK locally
echo "Installing @anthropic-ai/claude-code..."
npm install --save @anthropic-ai/claude-code

echo ""
echo "Setup complete!"
echo "To work in this environment, run:"
echo "  source $VENV_DIR/bin/activate    # activates Python venv + Node"
echo "Then you can use node, npm or your Claude Code package as needed."
