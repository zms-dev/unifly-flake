{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.unifly;
  tomlFormat = pkgs.formats.toml { };

  profileOpts =
    { ... }:
    {
      options = {
        controller = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Controller base URL (e.g., 'https://192.168.1.1').";
        };
        site = lib.mkOption {
          type = lib.types.str;
          default = "default";
          description = "Site name or UUID.";
        };
        auth_mode = lib.mkOption {
          type = lib.types.enum [
            "integration"
            "session"
            "hybrid"
            "cloud"
          ];
          default = "integration";
          description = "Authentication mode: integration (API key), session (username/password), hybrid, or cloud.";
        };
        api_key = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "API key (plaintext — prefer keyring or env var).";
        };
        api_key_env = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Environment variable name containing the API key.";
        };
        host_id = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Host/console ID for cloud connector mode.";
        };
        host_id_env = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Environment variable name containing the host/console ID.";
        };
        username = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Username for session auth.";
        };
        password = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Password for session auth (plaintext — prefer keyring).";
        };
        totp_env = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Environment variable name containing a TOTP token for MFA.";
        };
        ca_cert = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Path to custom CA certificate.";
        };
        insecure = lib.mkOption {
          type = lib.types.nullOr lib.types.bool;
          default = null;
          description = "Override insecure TLS setting.";
        };
        timeout = lib.mkOption {
          type = lib.types.nullOr lib.types.ints.unsigned;
          default = null;
          description = "Override connection timeout in seconds.";
        };
      };
    };

  defaultsOpts =
    { ... }:
    {
      options = {
        output = lib.mkOption {
          type = lib.types.enum [
            "table"
            "json"
            "yaml"
            "csv"
          ];
          default = "table";
          description = "Default output format.";
        };
        color = lib.mkOption {
          type = lib.types.enum [
            "auto"
            "always"
            "never"
          ];
          default = "auto";
          description = "Color output mode.";
        };
        insecure = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Global default for insecure TLS verification.";
        };
        timeout = lib.mkOption {
          type = lib.types.ints.unsigned;
          default = 30;
          description = "Global connection timeout in seconds.";
        };
        theme = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Theme name for the TUI (e.g., 'nord', 'dracula', 'silkcircuit-neon').";
        };
        show_donate = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to show the donate button in the TUI status bar.";
        };
        effects = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether tachyonfx animations are enabled in the TUI.";
        };
        chart_quality = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.enum [
              "block"
              "braille"
              "octant"
            ]
          );
          default = null;
          description = "TUI chart glyph quality.";
        };
      };
    };

  demoOpts =
    { ... }:
    {
      options = {
        enabled = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable demo mode PII sanitization.";
        };
        redact_names = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Names to redact (case-insensitive substring match across all text).";
        };
        keep_names = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Names to keep visible even if they'd otherwise match a redact pattern.";
        };
        redact_ssids = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Replace WiFi SSID names with generic alternatives.";
        };
        redact_wan_ips = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Replace public/WAN IP addresses with RFC 5737 documentation IPs.";
        };
        redact_macs = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Replace MAC addresses with locally-administered fakes.";
        };
        redact_isp = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Replace ISP name and upstream DNS in health data.";
        };
        seed = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Fixed seed for deterministic replacements across sessions.";
        };
      };
    };
  filterNulls =
    attrs:
    let
      clean =
        v:
        if builtins.isAttrs v then
          if lib.isDerivation v then v else lib.filterAttrs (n: v': v' != null) (lib.mapAttrs (n: clean) v)
        else
          v;
    in
    clean attrs;
in
{
  options.programs.unifly = {
    enable = lib.mkEnableOption "unifly";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unifly;
      defaultText = lib.literalExpression "pkgs.unifly";
      description = "The unifly package to use.";
    };

    settings = lib.mkOption {
      type = lib.types.submodule {
        freeformType = tomlFormat.type;
        options = {
          default_profile = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = "default";
            description = "Default profile name.";
          };
          defaults = lib.mkOption {
            type = lib.types.submodule defaultsOpts;
            default = { };
            description = "Global default settings.";
          };
          profiles = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule profileOpts);
            default = { };
            description = "Named controller profiles.";
          };
          demo = lib.mkOption {
            type = lib.types.submodule demoOpts;
            default = { };
            description = "Demo mode settings for PII sanitization in TUI/recordings.";
          };
        };
      };
      default = { };
      description = ''
        Configuration written to {file}`~/.config/unifly/config.toml`.
        See <https://hyperb1iss.github.io/unifly/guide/configuration/> for settings.
      '';
      example = lib.literalExpression ''
        {
          default_profile = "default";
          defaults = {
            output = "table";
            theme = "silkcircuit-neon";
          };
          profiles = {
            default = {
              controller = "https://192.168.1.1";
              site = "default";
              auth_mode = "session";
              username = "admin";
            };
          };
        }
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."unifly/config.toml" = lib.mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "unifly-config.toml" (filterNulls cfg.settings);
    };
  };
}
