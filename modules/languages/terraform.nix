{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.terraform;
in
{
  options = lib.neon.language.mkOptions "terraform";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs;[
          terraform
          terraform-ls
        ];
        programs.zsh = {
          initExtra = ''
            complete -o nospace -C terraform terraform
          '';
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
  ]);
}
