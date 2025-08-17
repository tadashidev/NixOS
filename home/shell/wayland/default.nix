{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;

    name = "Bibata-Modern-Classic";
    size = 22;

    gtk.enable = true;
  };

  gtk.enable = true;

  services = {
    playerctld.enable = true;
    swaync.enable = true;
    hyprpaper.enable = true;

    gammastep = {
      enable = true;
      provider = "geoclue2";
      temperature.night = 3000;
    };
  };

  imports = [
    ./xdg.nix
    ./niri.nix
    ./waybar.nix
    ./hypridle.nix
    ./ghostty.nix
  ];

  home.packages = [
    pkgs.brightnessctl

    pkgs.walker

    pkgs.wl-clipboard

    pkgs.xwayland-satellite
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
