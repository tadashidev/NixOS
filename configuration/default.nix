{
  config,
  nixpkgs,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lix;

    settings.experimental-features = ["nix-command" "flakes"];

    optimise = {
      automatic = true;
      persistent = true;
      dates = "weekly";
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };

    channel.enable = false;
    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = nixpkgs;
      };
    };
  };

  programs.nix-index-database.comma.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;

    packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-cjk-serif
      pkgs.noto-fonts-emoji
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "colemak";

  users = {
    mutableUsers = true;

    users = {
      tadashi = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        shell = pkgs.fish;

        # For virtual machines.
        initialPassword = "tadashi.dev";
      };
    };
  };

  imports = [
    ./network.nix
    ./essential-dev.nix
    ./gaming.nix
    ./misc.nix

    ./home-support.nix
  ];

  system.stateVersion = "25.05";
}
