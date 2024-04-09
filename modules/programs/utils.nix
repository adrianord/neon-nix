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
      gnupg
      nix-diff
      nixos-generators
      nmap
      parallel
      tree
      unixtools.watch
      viddy
      wget
    ];
  };
}
