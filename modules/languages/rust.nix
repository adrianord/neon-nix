{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.rust;
in
{
  options = lib.neon.language.mkOptions "rust";

  config = mkIf cfg.enable {

    # Implicitly enable TOML
    neon.languages.toml = {
      enable = true;
      vscode.enable = cfg.vscode.enable;
      neovim.enable = cfg.neovim.enable;
      zsh.enable = cfg.zsh.enable;
    };

    home._ = {
      home.packages = with pkgs; [
        rust-analyzer
        trunk
        cargo-edit
        cargo-watch
        bacon
        wasm-pack
        wasm-bindgen-cli
        (rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" ];
          targets = [
            "aarch64-apple-darwin"
            "wasm32-unknown-unknown"
            "x86_64-apple-darwin"
            "x86_64-unknown-linux-gnu"
          ];
        })
      ];

      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer
          serayuzgur.crates
        ];

        userSettings = {
          rust-analyzer = {
            inlayHints = {
              parameterHints.enable = false;
              typeHints.enable = false;
              chainingHints.enable = false;
              closingBraceHints.enable = false;
            };
          };
        };
      };
    };
  };
}
