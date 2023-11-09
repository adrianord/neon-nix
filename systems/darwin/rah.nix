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
          "lua"
          "nix"
          "nodejs"
          "markdown"
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
          dagger.enable = true;
          datagrip.enable = true;
          datree.enable = true;
          direnv.enable = true;
          discord.enable = true;
          edge.enable = true;
          firefox.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
          pulumi.enable = true;
          utils.enable = true;
          vscode.enable = true;
          zsh.enable = true;
          git.enable = true;
          coreutilsRs.enable = true;
          coreutilsRs.zshIntegration = true;
          gcloud.enable = true;
          mirrord.enable = true;
          oci.enable = true;
          ansible.enable = true;
          zellij.enable = false;
          signal.enable = true;
          vivaldi.enable = true;
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
          "bitwarden"
          "nordvpn"
          "vmware-fusion"
          "raspberry-pi-imager"
          "keepassxc"
          "unetbootin"
          "todoist"
        ];
      };
    }
  ];
}
