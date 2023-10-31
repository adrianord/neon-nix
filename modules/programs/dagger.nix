{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.dagger;
in
{
  options = {
    neon.programs.dagger = {
      enable = mkEnableOption "Enable dagger cli";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ =
        {
          home.packages = [
            pkgs.dagger
          ];
          programs.zsh.initExtra = ''
            source <(dagger completion zsh)
          '';
        };
    })
  ]);
}
