{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.protobuf;
in
{
  options = lib.neon.mkLanguageOptions config "protobuf";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          protobuf
          grpcurl
          buf
          buf-language-server
        ];
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "bloomrpc"
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "bufls" ];
        tsLanguages = [ "proto" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          zxh404.vscode-proto3
        ];
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
