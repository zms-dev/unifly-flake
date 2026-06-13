# Unifly Nix Flake

[![CI](https://github.com/zms-dev/unifly-flake/actions/workflows/ci.yml/badge.svg)](https://github.com/zms-dev/unifly-flake/actions/workflows/ci.yml)
[![Dependency Updates](https://github.com/zms-dev/unifly-flake/actions/workflows/update.yml/badge.svg)](https://github.com/zms-dev/unifly-flake/actions/workflows/update.yml)
[![Nix Built](https://img.shields.io/badge/Nix-Flake-blue.svg?logo=nixos&logoColor=white)](https://nixos.org)

Declarative Nix packaging and configuration management for [Unifly](https://github.com/hyperb1iss/unifly) — an elegant UniFi network management CLI & TUI.

This flake provides reproducible packages, NixOS modules, and Home Manager modules to configure and run Unifly.

---

## 📦 Packaged Components

This flake packages:
*   **Unifly CLI & TUI**: The core binary for managing your UniFi controller.
*   **Home Manager Module**: Configures Unifly and declaratively outputs `~/.config/unifly/config.toml` from Nix options.
*   **NixOS Module**: Installs the binary system-wide.

---

## 🚀 Getting Started

### 1. Direct Execution

Run the CLI/TUI directly using `nix run` without installing:

```bash
# Launch the interactive TUI or view help
nix run github:zms-dev/unifly-flake -- --help
```

---

### 2. NixOS Configuration

To install Unifly system-wide, add the flake to your inputs and enable the module:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    unifly.url = "github:zms-dev/unifly-flake";
  };

  outputs = { nixpkgs, unifly, ... }: {
    nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
      modules = [
        unifly.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
```

```nix
# configuration.nix
{
  programs.unifly = {
    enable = true;
  };
}
```

---

### 3. Home Manager Configuration

For user-specific installation and declarative TOML config generation, add the module to Home Manager:

```nix
# home.nix
{
  imports = [
    inputs.unifly.homeManagerModules.default
  ];

  programs.unifly = {
    enable = true;
    
    # Declarative config generation
    settings = {
      default_profile = "home";
      
      defaults = {
        output = "table";
        theme = "silkcircuit-neon";
        effects = true;
      };

      profiles = {
        home = {
          controller = "https://192.168.1.1";
          site = "default";
          auth_mode = "session";
          username = "admin";
        };
      };
    };
  };
}
```

---

## ⚙️ Configuration Settings

When using the Home Manager module, you can configure the settings under `programs.unifly.settings`. 

Detailed documentation of all available settings options, types, and defaults is available in:
*   **[Unifly Configuration Settings Documentation](./docs/configuration.md)**
