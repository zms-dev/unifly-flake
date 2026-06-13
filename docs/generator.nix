{ pkgs, lib, ... }:

let
  eval = lib.evalModules {
    modules = [
      ../modules/home-manager.nix
      # Mock base option structure
      (
        { lib, ... }:
        {
          config._module.args.pkgs = pkgs;
          options = {
            home.packages = lib.mkOption {
              type = lib.types.listOf lib.types.package;
              default = [ ];
            };
            xdg.configFile = lib.mkOption {
              type = lib.types.attrsOf lib.types.anything;
              default = { };
            };
          };
        }
      )
    ];
  };

  doc = pkgs.nixosOptionsDoc {
    options = {
      programs.unifly.settings = eval.options.programs.unifly.settings;
    };
    warningsAreErrors = false;
  };
in
pkgs.runCommand "unifly-docs" { } ''
  mkdir -p $out
  cat <<EOF > $out/README.md
  # Unifly Configuration Options

  These options are available when configuring Home Manager settings under:
  \`programs.unifly.settings\`

  They translate to the local TOML configuration file: \`~/.config/unifly/config.toml\`

  $(cat ${doc.optionsCommonMark})
  EOF

  # Clean up absolute nix store source paths to be relative links for GitHub
  sed -i -E 's|file:///nix/store/[a-z0-9]{32}-source/|../|g' $out/README.md
  sed -i -E 's|/nix/store/[a-z0-9]{32}-source/|../|g' $out/README.md
  sed -i -E 's|home-manager\\\.nix|home-manager.nix|g' $out/README.md
''
