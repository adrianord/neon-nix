{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.kubernetes;
in
{
  options = {
    neon.programs.kubernetes = {
      enable = mkEnableOption "Enable kubernetes CLI utilities";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        kubectl
        kubectx
        kubernetes-helm
        k9s
        kind
        eksctl
        krew
      ];
      programs.zsh.initExtra = ''
        source <(kubectl completion zsh)
        source <(helm completion zsh)
      '';
      home.sessionPath = [ "$HOME/.krew/bin" ];

    };
  };
}
