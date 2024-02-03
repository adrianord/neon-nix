{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.latex;
in
{
  options = lib.neon.mkLanguageOptions config "latex";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          texlab
          tectonic
          perl538Packages.LatexIndent
          zathura
        ];
      };
    })


    #(mkIf pkgs.stdenv.hostPlatform.isDarwin {
    #  homebrew = {
    #    taps = [ "zegervdv/zathura" ];
    #    brews = [
    #      "gcc"
    #      "zathura"
    #      "zathura-pdf-poppler"
    #    ];
    #  };
    #})

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "texlab" ];
        tsLanguages = [ "latex" ];
      };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
