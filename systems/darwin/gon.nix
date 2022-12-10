{
  user = {
    name = "aordonez";
    email = "adrianord@gmail.com";
    fullname = "Adrian Ordonez";
  };
  host = {
    arch = "aarch64";
    os = "darwin";
  };

  modules = [
    ({ lib, ... }: {
      home._.programs.emacs.enable = true;
      neon = {
        languages = lib.neon.language.enableLanguages
          {
            vscode = true;
            zsh = true;
            neovim = true;
            languages = [
              "codeql"
              "dotnet"
              "go"
              "nix"
              "nodejs"
              "python"
              "rust"
              "vale"
              "yaml"
            ];
          };
        darwin = {
          utils = {
            enable = true;
            includeUnfree = true;

          };
          configure = true;
        };

        programs = {
          alacritty.enable = true;
          kitty.enable = true;
          datree.enable = true;
          direnv.enable = true;
          discord.enable = false;
          firefox.enable = true;
          kubernetes.enable = true;
          neovim = { enable = true; configure = false; };
          pulumi.enable = true;
          utils.enable = true;
          vscode.enable = true;
          zsh.enable = true;
          git.enable = true;
        };
      };
    })
    {
      homebrew = {
        taps = [
          "homebrew/cask-fonts"
        ];
        casks = [
          "discord"
          "font-jetbrains-mono-nerd-font"
          "obsidian"
          "spotify"
          "todoist"
          "warp"
          "microsoft-remote-desktop"
        ];
      };
    }
  ];
}
