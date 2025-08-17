{...}: {
  imports = [
    ./fish.nix
    ./micro.nix
  ];

  home = {
    sessionVariables.EDITOR = "micro";
    shell.enableShellIntegration = true;
  };

  programs = {
    eza.enable = true;
    zoxide.enable = true;
    nix-index.enable = true;
    nix-your-shell.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
