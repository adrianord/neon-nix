{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.zen;
in
{
  options = {
    neon.programs.zen = {
      enable = mkEnableOption "Enable zen";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux { })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "zen"
        ];
      };
    })

  ]);
}
