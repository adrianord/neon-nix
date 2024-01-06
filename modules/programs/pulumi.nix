{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.pulumi;
in
{
  options = {
    neon.programs.pulumi = {
      enable = mkEnableOption "Enable pulumi";
    };
  };

  config = mkIf cfg.enable {
    home._.home = {
      sessionVariables = {
        PULUMI_AUTOMATION_API_SKIP_VERSION_CHECK = "true";
        PULUMI_SKIP_UPDATE_CHECK = "true";
      };
      packages = with pkgs; [
        pulumi
        pulumictl
        tf2pulumi
      ] ++ (with pkgs.pulumiPackages; [
        pulumi-language-nodejs
        pulumi-language-python
        pulumi-language-go
      ]);
    };
  };
}
