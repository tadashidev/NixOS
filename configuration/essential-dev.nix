# The goal here is to have minimal development tools, without having to depend on the network or additional configurations in user accounts.
{
  lib,
  pkgs,
  ...
}: {
  documentation = {
    dev.enable = true;
    man.generateCaches = lib.mkForce false; # Avoid slow rebuilds.
  };

  programs.fish.enable = true;
  environment.systemPackages = [
    pkgs.git
    pkgs.micro

    pkgs.go
    pkgs.zig
    pkgs.python3

    pkgs.alejandra

    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.linux-manual
    pkgs.tlrc
  ];

  virtualisation.waydroid.enable = true;
}
