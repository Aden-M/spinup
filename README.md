# ubuntu-bootstrap

ubuntu-bootstrap automates the initial setup of a fresh Ubuntu or Debian server. The included scripts
install common tools, harden SSH access, and configure a developer friendly Zsh
environment. A single bootstrap script drives the standard setup while other
utilities can be run individually, if needed.

## Features

- **Docker & Docker Compose** installation
- **Firewall** configuration via UFW
- **Optional Fail2ban** setup to protect SSH
- **Oh My Zsh** with a custom theme and plugins
- **SSH key enrollment** from `secrets/pubkey.secrets`
- **Hostname** configuration script

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
zsh/                  # custom .zshrc and theme
```

## Installation (Ubuntu/Debian)

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

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for
more details.
