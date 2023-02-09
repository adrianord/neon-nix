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
        languages = lib.neon.enableLanguages [
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
          discord.enable = true;
          firefox.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
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
        casks = [
          "obsidian"
          "spotify"
          "microsoft-remote-desktop"
          "balenaetcher"
          "bitwarden"
        ];
      };
    }
  ];
}
