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
        common =
          {

            font = {
              size = 14;
            };
          };

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
          alacritty.enable = true;
          aws.enable = true;
          cloudflare.enable = true;
          datree.enable = true;
          direnv.enable = true;
          discord.enable = true;
          firefox.enable = true;
          git.enable = true;
          kitty.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
          pulumi.enable = true;
          utils.enable = true;
          vscode.enable = true;
          zsh.enable = true;
        };
      };
    })
    {
      homebrew = {
        casks = [
          "zoom"
          "obsidian"
          "microsoft-remote-desktop"
          "balenaetcher"
        ];
      };
    }
  ];
}

