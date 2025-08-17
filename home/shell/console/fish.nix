{
  lib,
  pkgs,
  ...
}: let
  rose-pine-fish-target = "themes/Rosé Pine.theme";
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "b82982c55582cfaf6f220de1893c7c73dd0cb301";
    hash = "sha256-Dvaw1k7XOU2NUQbTJAXPgAOPN1zTLVrc7NZDY5/KHeM=";
  };
in {
  programs.fish = {
    enable = true;

    preferAbbrs = true;
    shellAbbrs = {
      ls = "eza";
      lg = {
        command = "git";
        expansion = "log --oneline --decorate";
      };
      wip = "git add .; and git commit --message 'WIP: Work In Progress' --no-verify";
    };

    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "pure-fish";
          repo = "pure";
          rev = "v4.11.3";
          hash = "sha256-mMUFR/n4aLsmZNbVAYmx57AMXT6U2P+wTuuN3opCeqs=";
        };
      }
    ];

    interactiveShellInit =
      ''
        # A smarter `cd` command.
        zoxide init fish --cmd cd | source

        # Pure Fish configuration.
        set --global pure_show_jobs true
        set --global pure_enable_nixdevshell true
        set --global pure_symbol_nixdevshell_prefix '❄️ ' # This looks  better with an additional space in Ghostty.
      ''
      # This theme is applied here, and installed at the end of this file.
      + ''
        fish_config theme choose "Rosé Pine"
      '';
  };

  stylix.targets.fish.enable = false;
  xdg.configFile."fish/${rose-pine-fish-target}".source = "${rose-pine-fish}/${rose-pine-fish-target}";

  # Avoid slow rebuilds.
  programs.man.generateCaches = lib.mkForce false;
}
