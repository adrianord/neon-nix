{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.yaml;
in
{
  options = lib.neon.language.mkOptions "yaml";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          yq-go
          nodePackages.yaml-language-server
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "yamlls" ];
        tsLanguages = [ "yaml" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._. programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          redhat.vscode-yaml
        ];
        userSettings = {
          redhat.telemetry.enabled = false;
          "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
        };
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
