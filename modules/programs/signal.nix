{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.signal;
in
{
  options = {
    neon.programs.signal = {
      enable = mkEnableOption "Enable signal";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux { })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "signal"
        ];
      };
    })

  ]);
}
