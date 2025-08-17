{pkgs, ...}: {
  stylix = {
    fonts = {
      serif = {
        package = pkgs.liberation_ttf;
        name = "Liberation Serif";
      };

      sansSerif = {
        package = pkgs.liberation_ttf;
        name = "Liberation Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.iosevka-term-slab;
        name = "IosevkaTermSlab Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.go-font
  ];
}
