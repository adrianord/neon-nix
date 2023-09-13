{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.coreutilsRs;
in
{
  options = {
    neon.programs.coreutilsRs = {
      enable = mkEnableOption "Enable coreutils rs";
      zshIntegration = mkEnableOption "Enable zsh integrations";
    };
  };

  config = mkIf cfg.enable
    (mkMerge [
      ({
        home._ = {
          home.packages = with pkgs; [
            eza
            bat
            ripgrep
            du-dust
            fd
          ];
        };
      })

      (mkIf cfg.zshIntegration {
        home._.programs.zsh = {
          shellAliases = {
            ls = "eza";
            cat = "bat";
            grep = "rg";
            find = "fd";
            du = "dust";
          };
        };
      })
    ]);
}
