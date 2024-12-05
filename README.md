# Environment Automation Scripts

This repository contains a collection of scripts to automate the setup and configuration of development environments for various Linux distributions. The scripts are tailored to simplify the installation of essential tools and configurations, ensuring a consistent and efficient environment setup.

## Supported Distributions

- Ubuntu-based distributions
- Fedora-based distributions
- rpm-ostree-based distributions

## Features

The scripts include the following functionalities:
- System updates and package installations
- Development tool installations (e.g., Neovim, Fish Shell, Git, Docker/Podman)
- Version managers setup (e.g., NVM, Pyenv, SdkMan)
- Visual Studio Code installation and configuration
- NVIDIA driver setup (optional)
- Fish Shell custom configurations
- Additional utilities and environment customizations

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/environment-setup-scripts.git
   cd environment-setup-scripts
   ```

2. Choose the script for your distribution:
   - For Ubuntu:
     ```bash
     ./ubuntu_setup.sh
     ```
   - For Fedora:
     ```bash
     ./fedora_setup.sh
     ```
   - For rpm-ostree:
     ```bash
     ./fedora_ostree_setup.sh
     ```

3. Ensure the script has execution permissions:
   ```bash
   chmod +x ./<script-name>.sh
   ```

4. Run the script:
   ```bash
   ./<script-name>.sh
   ```

## Customizations

You can customize the scripts by editing the respective files. Common customization options include:
- Adding or removing default packages
- Changing Git global configurations
- Adjusting Visual Studio Code extensions and settings
- Enabling or disabling optional setups (e.g., NVIDIA drivers)

## Example Script: Fedora Setup

```bash
#!/bin/bash

echo "Updating system packages..."
sudo dnf -y update

echo "Installing default packages..."
sudo dnf -y install neovim fish git curl wget make powerline-fonts

# Add more steps as per your requirements...
```

## Contributions

Feel free to contribute by submitting pull requests or reporting issues. All contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
