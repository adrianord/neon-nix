{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.vscode;
in
{
  options = {
    neon.programs.vscode = {
      enable = mkEnableOption "Utility packages";
    };
  };
  imports = [
    ./userSettings.nix
    ./keybindings.nix
    ./extensions
  ];
  config = mkIf cfg.enable {
    home._.programs = {
      vscode = {
        enable = true;
        package = pkgs.vscode;
        profiles.default = {
          extensions = with pkgs; [
            vscode-extensions.asvetliakov.vscode-neovim
          ];
          userSettings = {
            vscode-neovim.neovimExecutablePaths.darwin = "nvim";
          };
        };
      };
      zsh = {
        shellAliases = { };
      };
    };
  };
}
