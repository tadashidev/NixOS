{pkgs, ...}: let
  rose-pine-micro = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/w3dg/0c8c6885c222219e9b145d4b26d07bec/raw/444b0900816202cfc268d01b6c290ba149649230/rosepine-wip.micro";
    hash = "sha256-XNahULWkjwmfL2RXQ42rVbNU8jcppQzj6/UwaLcR4gE=";
  };
in {
  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "rose-pine";
    };
  };

  stylix.targets.micro.enable = false;
  xdg.configFile."micro/colorschemes/rose-pine.micro".source = rose-pine-micro;
}
