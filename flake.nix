{
  description = "Nix flake for unifly - UniFi network management CLI & TUI";

  nixConfig = {
    extra-substituters = [ "https://unifly-flake.cachix.org" ];
    extra-trusted-public-keys = [
      "unifly-flake.cachix.org-1:UqLoinbuUxFsDIHzjWKacwilVELow9MDeclA16+U/Ak="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      systems,
      git-hooks-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks-nix.flakeModule
      ];
      systems = import systems;

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          packages.unifly = pkgs.callPackage ./pkgs/unifly.nix {
            apple_sdk = pkgs.apple-sdk;
          };
          packages.unifly-docs = pkgs.callPackage ./docs/generator.nix { };
          packages.default = self'.packages.unifly;

          apps.generate-docs = {
            type = "app";
            program = "${pkgs.writeShellScript "generate-docs" ''
              echo "==> Generating settings documentation..."
              mkdir -p docs
              cp -f ${self'.packages.unifly-docs}/README.md docs/configuration.md
              chmod +w docs/configuration.md
              echo "==> Done!"
            ''}";
          };

          apps.update = {
            type = "app";
            program = "${pkgs.writeShellScript "update-project" ''
              echo "==> Updating unifly package version and hashes..."
              ${pkgs.nix-update}/bin/nix-update --flake --version=latest unifly

              echo "==> Updating flake lock file..."
              nix flake update

              echo "==> Formatting files..."
              nix fmt

              echo "==> Regenerating documentation..."
              nix run .#generate-docs

              echo "==> Done!"
            ''}";
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.pre-commit.devShell ];
            nativeBuildInputs = with pkgs; [
              pkg-config
              cargo
              rustc
            ];
            buildInputs = with pkgs; [
              openssl
              dbus
            ];
            shellHook = ''
              # Copy the nix-generated pre-commit config file to the workspace
              # to avoid symlink failures on exfat filesystems where symlinking is not allowed.
              cp -f ${config.pre-commit.settings.configFile} .pre-commit-config.yaml
              chmod +w .pre-commit-config.yaml

              # Run pre-commit install to write the executable script in .git/hooks/pre-commit
              if [ -d .git ]; then
                pre-commit install
              fi
            '';
          };

          formatter = pkgs.nixfmt-tree;

          pre-commit = {
            check.enable = true;
            settings = {
              install.enable = false;
              hooks = {
                nixfmt-tree-check = {
                  enable = true;
                  name = "nixfmt-tree";
                  description = "Format Nix files using the project formatter";
                  entry = "${pkgs.nixfmt-tree}/bin/treefmt";
                  files = "\\.nix$";
                };
              };
            };
          };
        };

      flake = {
        overlays.default = final: prev: {
          unifly = final.callPackage ./pkgs/unifly.nix {
            apple_sdk = final.apple-sdk;
          };
        };

        nixosModules.unifly =
          { config, pkgs, ... }:
          {
            imports = [ ./modules/nixos.nix ];
            nixpkgs.overlays = [ self.overlays.default ];
          };

        homeManagerModules.unifly =
          { config, pkgs, ... }:
          {
            imports = [ ./modules/home-manager.nix ];
            nixpkgs.overlays = [ self.overlays.default ];
          };

        nixosModules.default = self.nixosModules.unifly;
        homeManagerModules.default = self.homeManagerModules.unifly;
      };
    };
}
