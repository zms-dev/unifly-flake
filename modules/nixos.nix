{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.unifly;
in
{
  options.programs.unifly = {
    enable = lib.mkEnableOption "unifly";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unifly;
      defaultText = lib.literalExpression "pkgs.unifly";
      description = "The unifly package to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
