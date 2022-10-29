{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.toml;
in
{
  options = lib.neon.language.mkOptions "toml";

  config = mkIf cfg.enable {
    home._ = {
      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs; [
          vscode-extensions.bungcip.better-toml
        ];
      };
    };
  };
}
