{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nodejs;
in
{
  options = lib.neon.language.mkOptions "nodejs";

  config = mkIf cfg.enable {
    home._ = {
      home.sessionVariables = {
        NPM_CONFIG_PREFIX = "$HOME/.node_modules";
      };
      home.packages = with pkgs;
        [
          nodejs
          jq
          yarn
        ] ++ (with pkgs.nodePackages; [
          pnpm
        ]);

      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions;[
          ms-vscode.vscode-typescript-next
          dbaeumer.vscode-eslint
          rvest.vs-code-prettier-eslint
          esbenp.prettier-vscode
          bradlc.vscode-tailwindcss
        ];
        userSettings = {
          eslint = {
            validate = [ "typescript" ];
            format.enable = true;
          };
          prettier = {
            proseWrap = "always";
          };
          "[typescript]" = {
            "editor.defaultFormatter" = "rvest.vs-code-prettier-eslint";
            "editor.formatOnPaste" = false;
            "editor.formatOnType" =  false;
            "editor.formatOnSave" = true;
            "files.autoSave" = "onFocusChange";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "vscode.typescript-language-features";
          };
        };
      };
    };
  };
}
