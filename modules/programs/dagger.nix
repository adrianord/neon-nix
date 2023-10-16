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
    (mkIf pkgs.stdenv.hostPlatform.isLinux { })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      home._ =
        {
          home.packages = with pkgs; [
            dagger
          ];
          programs.zsh.initExtra = ''
            source <(dagger completion zsh)
          '';
        };
    })
  ]);

}
