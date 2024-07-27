# Manjaro Install Script

## Overview
This Bash script automates the process of installing packages, cloning a my `.dotfiles` repository, and using GNU Stow to manage configuration files. It interacts with the user to decide which packages to install and handles the setup of configuration files in the user's `.config` directory.

This script id based on my necessities so adjust the provided lists and repository URL to suit your personal configuration.

## Prerequisites
Before running this script, ensure you have the following tools installed on your system:

- `stow`
- `git`

## Files
The script relies on three text files:

1. `pkg_list.txt`: A list of packages that the script will ask the user about installing.
2. `pkg_install.txt`: A temporary file used to store the list of packages the user wants to install.
3. `stow_files.txt`: A list of configuration directories that will be managed by stow.

## Usage
1. **Prepare the Package List**: Create a `pkg_list.txt` file with a list of packages you might want to install, one per line.
2. **Prepare the Stow Files List**: Create a `stow_files.txt` file with a list of configuration directories to manage with `stow`, one per line.
3. **Run the Script**: Execute the script in a terminal.

    ```bash
    chmod +x your_script.sh
    ./your_script.sh
    ```

4. **Follow Prompts**: The script will prompt you to confirm the installation of each package and to proceed with the installation process. 

## Example Files

### pkg_list.txt
```
tmux
code
```

### stow_files.txt
```
vim
tmux
zsh
```

## Notes

- Ensure that `pamac` is installed and configured properly, or replace `pamac install` with your preferred package manager command in the script.
- The script assumes a Unix-like environment with a home directory structure.

## Troubleshooting

- **stow or git not found**: Make sure `stow` and `git` are installed and accessible in your `$PATH`.
- **Permissions Issues**: Ensure you have the necessary permissions to install packages and write to the directories involved.
- **Customizing for Different Package Managers**: Modify the package installation command if you are using a different package manager (e.g., `apt`, `yum`, `brew`).