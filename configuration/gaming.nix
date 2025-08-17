{pkgs, ...}: {
  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = ["--rt"];
    };

    steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      gamescopeSession.enable = true;
    };
  };
}
