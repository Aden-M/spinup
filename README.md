# Ubuntu Development Environment Bootstrap

This repository contains a set of automated scripts to quickly and reproducibly set up a complete development environment on a fresh Ubuntu installation. It streamlines the process of installing essential packages, synchronizing dotfiles, and configuring a personalized workspace, saving significant time and effort for engineers and developers.

# Problem Solved

Setting up a new development machine can be a time-consuming and manual process, prone to errors. This project solves that problem by automating the entire configuration, ensuring a consistent and ready-to-use environment across different machines.

# Key Features
- **Docker & Docker Compose:** Installs Docker for containerization and Docker Compose for multi-container orchestration.
- **Firewall Configuration:** Sets up firewall rules via UFW to secure the system and prevent unauthorized access.
- **SSH Configuration:** Configures key-based SSH access with user-provided public keys.
- **Optional Fail2ban Setup:** Includes a script to optionally configurat Fail2Ban SSH protection.
- **Reproducible Deployments:** This script has been validated to work on Ubuntu based systems, including Ubuntu for WSL.
- **ZShell:** Includes a lightweight ZSH theme that replicates the default Ubuntu Bash shell, but with autocompletions, autosugestions, syntax highlighting, and git integration.

# Technologies Used
- **Languages:** Shell Script (Bash)
- **Tools:** Git, Docker, GitHub CI/CD
- **Platforms:** Ubuntu (Server 22.04 LTS, 24.04 LTS, 25.04, WSL)


## Repository layout

```
bootstrap.sh          # entry point for typical setup
scripts/              # individual setup scripts
  docker.sh           # install Docker
  fail2ban.sh         # configure fail2ban (optional)
  hostname.sh         # interactive hostname setter
  ssh.sh              # append SSH public keys
  ufw.sh              # configure firewall rules
  zsh.sh              # install zsh with custom .zshrc
secrets/              # place pubkey.secrets here
zsh/                  # custom .zshrc 
```

## How to Use
To use this project, simply clone the repository and run the bootstrap script from your terminal.

1. Install git and curl:

```bash
sudo apt update && sudo apt install -y git curl
```

2. Clone the repository and change into it:

```bash
git clone https://gitlab.ast.adenm.solutions/adenmann/spinup spinup
cd spinup
```

3. Provide your public keys in `secrets/pubkey.secrets`:

```bash
echo "ssh-ed25519 AAAA... user@example" > secrets/pubkey.secrets
```

4. Run the bootstrap script:

```bash
bash bootstrap.sh
```

The bootstrap process installs Zsh, Docker, configures UFW for SSH, and adds
your provided public keys. Start a new shell session or re-login to use Zsh.

### Optional steps

Run additional scripts as needed:

```bash
bash scripts/fail2ban.sh  # set up fail2ban
bash scripts/hostname.sh  # set the hostname
```

## Architecture

Each script performs a single task and can be executed independently. The
`bootstrap.sh` script simply runs the most common scripts in sequence, ensuring
repeatability and minimal prerequisites. Secrets and custom configuration files
live inside the `secrets/` and `zsh/` directories so they can be versioned
separately from the setup logic.

## Lessons Learned & Future Improvements:
- **Idempotency:** A key challenge was designing scrimpts to be idempotent, meaning they could run multiple times without cuasing errors or unwanted side effects.
- **Future Work:** Use checksums to validate each script file before running to avoid malicious use, add robust error handling, add update and uninstall scripts.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for
more details.
