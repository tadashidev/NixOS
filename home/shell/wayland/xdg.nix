{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-termfilechooser];
    configPackages = [pkgs.niri pkgs.xdg-desktop-portal-termfilechooser];
    config = {
      common = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
    };
  };

  home.sessionVariables.TERMCMD = "ghostty -e";

  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    '';
  };

  programs.yazi.enable = true;
}
