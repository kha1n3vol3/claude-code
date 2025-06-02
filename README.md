# Claude Code SDK Local Setup

This repository demonstrates how to set up and run the `@anthropic-ai/claude-code` Node.js package within a self-contained Python virtual environment (venv) using `nodeenv`. This approach provides:

- An isolated Python environment (if needed for other tasks)
- A co-located Node.js/npm installation
- A local `node_modules/` directory containing `@anthropic-ai/claude-code`

All components reside under the `./venv` directory (or a directory of your choice), ensuring that your system-wide Python or Node.js installations remain unaffected.

## Overview of Claude Code

Claude Code is an AI-powered coding assistant developed by Anthropic, designed to enhance developer productivity directly within the terminal. By integrating Claude Opus 4, it offers deep codebase understanding and the capability to edit files and execute commands within your development environment. This integration allows for tasks such as code navigation, refactoring, and test generation, all facilitated through natural language interactions. 

## Prerequisites

- Unix-like operating system (Linux, macOS, WSL)
- Python 3.6+ installed as `python3`
- `bash`, `curl` (or `wget`), and standard build tools

## Setup

1. **Clone or Copy the Repository**: Place this repository in your project directory.

2. **Ensure `setup.sh` is Executable**:

   ```bash
   chmod +x setup.sh
   ```


3. **Run the Setup Script**:

   ```bash
   ./setup.sh
   ```


   This script will:

   - Create a Python virtual environment in `./venv`
   - Activate it and install `nodeenv` via `pip`
   - Bootstrap Node.js & npm inside the same venv
   - Initialize `package.json` (if not present)
   - Install `@anthropic-ai/claude-code` into `node_modules/`

## Activating the Environment

To work with Claude Code:


```bash
source venv/bin/activate
```


After activation:

- `python` and `pip` refer to your venv’s Python.
- `node` and `npm` refer to the isolated Node.js.

To deactivate the environment:


```bash
deactivate
```


## Usage

1. **Create an Entry-Point JavaScript File**:

   ```javascript
   // index.js
   import { Claude } from "@anthropic-ai/claude-code";

   async function main() {
     const claude = new Claude({ apiKey: process.env.CLAUDE_API_KEY });

     const response = await claude.sendMessage({
       messages: [
         { role: "system", content: "You are a helpful assistant." },
         { role: "user", content: "Hello Claude, how are you?" }
       ]
     });

     console.log("Claude says:", response.reply);
   }

   main().catch(err => {
     console.error("Error running Claude:", err);
     process.exit(1);
   });
   ```


2. **Install Dependencies and Run**:

   ```bash
   source venv/bin/activate
   node index.js
   ```


## How It Works

1. **Python `venv`**: A standard Python virtual environment is created (`python3 -m venv venv`), providing an isolated folder with its own `python`, `pip`, and related tools.

2. **`nodeenv`**: Inside the venv, `nodeenv` is installed. This tool downloads and installs a standalone Node.js/npm distribution into the same directory tree (`venv/bin/node`, `venv/bin/npm`).

3. **Unified Activation**: By sourcing `venv/bin/activate`, both the Python and Node.js environments are activated simultaneously, making their respective binaries available on the `PATH`.

4. **Local `npm install`**: Running `npm install @anthropic-ai/claude-code` installs the SDK into your project's local `node_modules/` directory, ensuring all dependencies are contained within the venv.

## Customizations

- **Pin a Specific Node.js Version**: Modify the `nodeenv` command in `setup.sh` to specify a Node.js version:

  
```bash
  nodeenv --node=18.16.0 --relocatable --prebuilt .
  ```


- **Change the venv Directory**: Edit the `VENV_DIR` variable in `setup.sh` to specify a different directory for the virtual environment.

- **Add Other npm Packages**: Install additional npm packages with:

  
```bash
  npm install --save <package-name>
  ```


## Cleanup

To remove the environment:


```bash
deactivate   # if currently active
rm -rf venv  # deletes both Python and Node.js components
rm -rf node_modules package-lock.json  # if you want to clean npm artifacts
```


## Additional Resources

- [Claude Code Overview](https://www.anthropic.com/claude-code)
- [Anthropic API Client SDKs](https://docs.anthropic.com/en/api/client-sdks)
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)

Happy coding with Claude! 🚀
