# 🚀 Bash Automations

A collection of high-performance shell scripts designed to automate repetitive developer workflows, from C++ project scaffolding to advanced Git synchronization and Lex/Flex compilation.

## 🛠 Project Overview

This repository serves as a centralized toolkit for local development automation. Each script is designed to reduce terminal overhead and enforce best practices (like safety checks and clean project structures).

## 📂 Featured Scripts

### 1. `commit.sh` (The Ultimate Git Sync)
A robust Git wrapper that handles the entire lifecycle of a commit.
* **Safety First:** Checks for large files (>50MB) before pushing to prevent GitHub rejection.
* **Auto-Sync:** Performs a `git pull --rebase` before pushing to minimize merge conflicts.
* **Smart Staging:** Automatically detects if changes exist before attempting a commit.
* **Usage:** `./commit.sh "your message" [optional_branch]`

### 2. `start-cpp.sh` (C++ Project Scaffolder)
Instantly bootstraps a new C++ environment.
* Creates a project directory and a boilerplate `main.cpp`.
* Initializes a local Git repository automatically.
* Sets up a `.gitignore` to keep binary files out of your version control.
* **Usage:** `./start-cpp.sh ProjectName`

### 3. `run.sh` (Lex/Flex Automator)
Streamlines the multi-step process of compiling Lexical Analyzers.
* Runs `flex` on the input file.
* Compiles the resulting `lex.yy.c` with the `cc` compiler.
* Executes the final binary immediately.
* **Usage:** `./run.sh scanner.l`

---

## 🚀 Installation & Setup

1.  **Clone the Repo:**
    ```bash
    git clone https://github.com/Kibet-Rotich/Bash-Automations.git
    cd Bash-Automations
    ```

2.  **Make Executable:**
    ```bash
    chmod +x *.sh
    ```

3.  **Create Global Aliases:**
    To use these scripts from anywhere, add them to your `~/.zshrc` or `~/.bashrc`:
    ```bash
    alias save="~/Bash-Automations/commit.sh"
    alias start-cpp="~/Bash-Automations/start-cpp.sh"
    alias flex-run="~/Bash-Automations/run.sh"
    ```

---

## 📈 Future Additions
* [ ] Python/Virtualenv automation for ML projects.
* [ ] Automated system backup scripts.
* [ ] Docker container management shortcuts.

## ⚖️ License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.