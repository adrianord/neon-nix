{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.utils;
in
{
  options = {
    neon.programs.utils = {
      enable = mkEnableOption "Utility packages";
    };
  };

  config = mkIf cfg.enable {
    home._.home.packages = with pkgs; [
      nix-diff
      wget
      nixos-generators
      gnupg
      unixtools.watch
      postman
      viddy
    ];
  };
}
