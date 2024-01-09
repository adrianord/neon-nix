{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.arc;
in
{
  options = {
    neon.programs.arc = {
      enable = mkEnableOption "Enable arc";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux { })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "arc"
        ];
      };
    })

  ]);
}
