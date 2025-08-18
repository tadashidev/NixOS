{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.niri = {
    settings = {
      outputs."eDP-1" = {
        enable = true;
        mode = {
          width = 1920;
          height = 1080;
        };
        scale = 1.5;
      };

      input.keyboard.xkb = {
        layout = "us";
        variant = "colemak";
        options = "caps:swapescape,grp:alt_altgr_toggle";
      };

      cursor = {
        theme = config.home.pointerCursor.name;
        size = config.home.pointerCursor.size;
        hide-after-inactive-ms = 8000;
        hide-when-typing = true;
      };

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H:%M:%S.png";

      spawn-at-startup = [
        {command = [(lib.getExe (pkgs.callPackage (import ./niri-ipc) {}))];}
        {command = ["walker" "--gapplication-service"];}
        {command = ["sh" "-c" "sleep 3 && keepassxc"];}
      ];

      #hotkey-overlay.hide-not-bound = true;

      binds = with config.lib.niri.actions; {
        "Mod+Space".action = spawn "walker";
        "Mod+Return".action = spawn "ghostty";

        "Mod+Escape".action = toggle-overview;

        "Mod+X".action = close-window;
        "Mod+Shift+BackSpace".action = quit;

        # N(Left) E(Up) I(Right) O(Down).
        "Mod+N".action = focus-column-left;
        "Mod+N".allow-inhibiting = false;

        "Mod+E".action = focus-window-or-workspace-up;
        "Mod+E".allow-inhibiting = false;

        "Mod+I".action = focus-column-right;
        "Mod+I".allow-inhibiting = false;

        "Mod+O".action = focus-window-or-workspace-down;
        "Mod+O".allow-inhibiting = false;

        "Mod+Shift+N".action = consume-or-expel-window-left;
        "Mod+Shift+E".action = move-window-up-or-to-workspace-up;
        "Mod+Shift+I".action = consume-or-expel-window-right;
        "Mod+Shift+O".action = move-window-down-or-to-workspace-down;

        # Inhibiting escape.
        "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;

        "Mod+Equal".action = set-window-width "+8";
        "Mod+Minus".action = set-window-width "-8";
        "Mod+Shift+Equal".action = set-window-height "+8";
        "Mod+Shift+Minus".action = set-window-height "-8";
        "Mod+M".action = switch-preset-column-width;
        "Mod+K".action = switch-preset-window-height;

        "Mod+T".action = toggle-window-floating;
        "Mod+F".action = fullscreen-window;

        "Mod+Slash".action = show-hotkey-overlay;

        "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "2%+";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "2%-";

        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.01+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.01-";
        "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

        "XF86AudioNext".action = spawn "playerctl" "next";
        "XF86AudioPause".action = spawn "playerctl" "play-pause";
        "XF86AudioPlay".action = spawn "playerctl" "play-pause";
        "XF86AudioPrev".action = spawn "playerctl" "previous";

        # Nix moment: <https://github.com/sodiboo/niri-flake/issues/922>.
        "Print".action.screenshot-screen = [];

        "Shift+Print".action = screenshot-window {
          write-to-disk = true;
        };
        "Mod+Print".action = screenshot;
      };

      layout = {
        gaps = 8;

        preset-column-widths = [
          {proportion = 1.0;}
          {proportion = 1. / 2.;}
          {proportion = 1. / 3.;}
          {proportion = 2. / 3.;}
        ];
        preset-window-heights = [
          {proportion = 1.0;}
          {proportion = 1. / 2.;}
        ];
        focus-ring = {
          enable = true;
          width = 1;
        };
        border.enable = false;
        default-column-width = {};
        always-center-single-column = true;
        center-focused-column = "on-overflow";
        empty-workspace-above-first = true;
        shadow = {
          enable = false;
        };
        struts = let
          s = 0;
        in {
          top = s;
          bottom = s;
          left = s;
          right = s;
        };
      };

      window-rules = [
        {
          open-maximized = true;
          clip-to-geometry = true;
          geometry-corner-radius = let
            radius = 8.0;
          in {
            top-left = radius;
            top-right = radius;
            bottom-left = radius;
            bottom-right = radius;
          };
        }
      ];
    };
  };
}
