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
          ansible.enable = true;
          arc.enable = true;
          aws.enable = true;
          coreutilsRs.enable = true;
          coreutilsRs.zshIntegration = true;
          dagger.enable = true;
          datagrip.enable = true;
          datree.enable = true;
          direnv.enable = true;
          discord.enable = true;
          firefox.enable = true;
          flox.enable = true;
          gcloud.enable = true;
          ghostty.enable = true;
          git.enable = true;
          kitty.enable = true;
          kubernetes.enable = true;
          mirrord.enable = true;
          neovim.enable = true;
          oci.enable = true;
          pulumi.enable = true;
          signal.enable = true;
          utils.enable = true;
          vivaldi.enable = true;
          vscode.enable = false;
          zellij.enable = false;
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
          "nordvpn"
          "raspberry-pi-imager"
          "keepassxc"
          "unetbootin"
          "todoist"
          "slack"
          "1password"
          "moonlight"
          "linear-linear"
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
