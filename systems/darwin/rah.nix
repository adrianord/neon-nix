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
          "bash"
          "dotnet"
          "go"
          "just"
          "latex"
          "lua"
          "markdown"
          "nix"
          "nodejs"
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
          arc.enable = true;
          aws.enable = true;
          coreutilsRs.enable = true;
          coreutilsRs.zshIntegration = true;
          direnv.enable = true;
          discord.enable = true;
          ghostty.enable = true;
          git.enable = true;
          kitty.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
          pulumi.enable = true;
          signal.enable = true;
          utils.enable = true;
          vivaldi.enable = true;
          zsh.enable = true;
        };
      };
    })

    {
      homebrew = {
        casks = [
          "zoom"
          "obsidian"
          "nordvpn"
          "slack"
          "cursor"
          "utm"
          "chromium"
        ];
      };
    }
    ({ pkgs, ... }: {
      home._.home.packages = with pkgs; [
        postgresql
      ];
    })
  ];
}
