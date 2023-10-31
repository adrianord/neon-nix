{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.mirrord;
in
{
  options = {
    neon.programs.mirrord = {
      enable = mkEnableOption "Enable mirrord";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux { })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        taps = [
          "metalbear-co/mirrord"
        ];
        brews = [
          "mirrord"
        ];
      };
    })

    ({
      home._ =
        {
          programs.zsh.initExtra = ''
            source <(mirrord completions zsh)
          '';
        };
    })
  ]);
}
