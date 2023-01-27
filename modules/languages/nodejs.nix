{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nodejs;
  npm_prefix = "$HOME/.npm/node_modules";
  typescriptFormatter = "vscode.typescript-language-features";
  jsonFormatter = "vscode.json-language-features";
in
{
  options = lib.neon.language.mkOptions "nodejs";

  config = mkIf cfg.enable (mkMerge [
    ({
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
            typescript-language-server
            typescript
          ]);
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "tsserver" ];
        tsLanguages = [ "javascript" "typescript" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions;[
          ms-vscode.vscode-typescript-next
          dbaeumer.vscode-eslint
          bradlc.vscode-tailwindcss
          prisma.prisma
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
            "editor.defaultFormatter" = typescriptFormatter;
            "editor.formatOnPaste" = false;
            "editor.formatOnType" = false;
            "editor.formatOnSave" = true;
            "files.autoSave" = "onFocusChange";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = typescriptFormatter;
          };
          "[json]" = {
            "editor.defaultFormatter" = jsonFormatter;
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = jsonFormatter;
          };
        };
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
