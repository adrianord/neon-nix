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

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          kubectl
          kubectx
          kubernetes-helm
          kubernetes-helmPlugins.helm-diff
          k9s
          kind
          eksctl
          krew
          nodePackages.cdk8s-cli
          kustomize
          dive
        ];
        programs.zsh = {
          plugins = [
            {
              name = "kubectl";
              src = "${pkgs.kubectl}/share/zsh/site-functions/";
            }
            {
              name = "helm";
              src = "${pkgs.kubernetes-helm}/share/zsh/site-functions/";
            }
          ];
        };
        home.sessionPath = [ "$HOME/.krew/bin" ];

      };
    })
  ]);
}
