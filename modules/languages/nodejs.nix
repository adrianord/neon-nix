{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nodejs;
  npm_prefix = "$HOME/.npm/node_modules";
in
{
  options = lib.neon.language.mkOptions "nodejs";

  config = mkIf cfg.enable {
    home._ = {
      home.sessionVariables = {
        NPM_CONFIG_PREFIX = npm_prefix;
      };
      home.sessionPath = [
        "${npm_prefix}/bin"
      ];
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
            "editor.formatOnType" = false;
            "editor.formatOnSave" = true;
            "files.autoSave" = "onFocusChange";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
          };
          "[json]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
        };
      };
    };
  };
}
