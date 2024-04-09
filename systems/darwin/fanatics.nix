{
  user = {
    name = "adrian.ordonez";
    email = "adrian.ordonez@betfanatics.com";
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
          "go"
          "just"
          "lua"
          "markdown"
          "nix"
          "nodejs"
          "python"
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
          kitty.enable = true;
          direnv.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
          pulumi.enable = true;
          utils.enable = true;
          zsh.enable = true;
          git.enable = true;
          coreutilsRs.enable = true;
          coreutilsRs.zshIntegration = true;
          ansible.enable = true;
        };
      };
    })

    {
      homebrew = {
        taps = [
          {
            name = "fanatics-gaming/homebrew-tap";
            clone_target = "git@github.com:fanatics-gaming/homebrew-tap";
            force_auto_update = true;
          }
          "fluxcd/homebrew-tap"
        ];
        casks = [
          "obsidian"
          "intellij-idea"
        ];
        brews = [
          "fanatics-gaming/homebrew-tap/fbg-platform-tools"
          "aws-sso-util"
          "fluxcd/tap/flux@0.41"
          "postgresql@15"
          {
            name = "libpq";
            link = true;
          }
        ];
      };
    }
  ];
}
