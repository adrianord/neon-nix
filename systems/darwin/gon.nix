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
        languages = lib.neon.language.enableLanguages [
          "dotnet"
          "go"
          "lua"
          "nix"
          "nodejs"
          "protobuf"
          "python"
          "rust"
          "terraform"
          "yaml"
        ];
        darwin = {
          utils = {
            enable = true;
            includeUnfree = true;

          };
          configure = true;
        };

        programs = {
          aws.enable = true;
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
          "bloomrpc"
          "balenaetcher"
        ];
        brews = [
          "firefoxpwa"
        ];
      };
    }
  ];
}
