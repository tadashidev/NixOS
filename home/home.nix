{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "tadashi";
    homeDirectory = "/home/tadashi";
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/zp/wallhaven-zpxzrj.png";
      hash = "sha256-NKrcH3NdGSaauU25pz9LQvitszlDghFiG5TxXkl8Qj8=";
    };
    polarity = "dark";
  };

  imports = [
    ./fonts.nix
    ./services
    ./shell
    ./apps
  ];

  home.packages = [pkgs.home-manager];

  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.sessionVariables.GOPATH}/bin"
  ];

  home.stateVersion = "25.05";
}
