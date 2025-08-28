{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./chromium.nix
  ];

  programs = {
    git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    fastfetch.enable = true;
    btop.enable = true;

    cava.enable = true;
    mpv.enable = true;

    zathura.enable = true;
  };

  stylix.targets = {
    btop.enable = false;
    cava.rainbow.enable = true;
  };

  home.packages = [
    pkgs.glow

    pkgs.irssi

    pkgs.keepassxc

    pkgs.anki-bin

    pkgs.youtube-music
    pkgs.mcpelauncher-ui-qt

    pkgs.quickemu
    pkgs.samba # For Quickemu.

    pkgs.onlyoffice-desktopeditors

    # Compression & decompression.
    pkgs.xz
    pkgs.zip
    pkgs.unzip
    pkgs.zstd
    pkgs.brotli
  ];
}
