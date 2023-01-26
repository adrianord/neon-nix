{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.yaml;
in
{
  options = lib.neon.language.mkOptions "yaml";

  config = mkIf cfg.enable {

    neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
      servers = [ "yamlls" ];
      tsLanguages = [ "yaml" ];
    };

    home._ = {
      home.packages = with pkgs; [
        yq-go
        nodePackages.yaml-language-server
      ];

      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          redhat.vscode-yaml
        ];
        userSettings = {
          redhat.telemetry.enabled = false;
          "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
        };
      };
    };
  };
}
