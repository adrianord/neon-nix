{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.terraform;
in
{
  options = lib.neon.mkLanguageOptions config "terraform";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs;[
          terraform
          terraform-ls
          tflint
        ] ++ (with pkgs.nodePackages; [
          cdktf-cli
        ]);
        home.file.terraformrc = {
          text = ''
            plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
          '';
          target = ".terraformrc";
        };
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = {
        servers = [ "terraformls" ];
        tsLanguages = [ "terraform" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          hashicorp.terraform
        ];
      };
    })

    (mkIf cfg.zsh.enable {
      home._.programs.zsh = {
        initContent = ''
          complete -o nospace -C terraform terraform
        '';
      };
    })
  ]);
}
