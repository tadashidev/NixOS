{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        exclusive = false;

        position = "top";

        start_hidden = true;

        modules-left = ["tray" "wlr/taskbar"];
        modules-center = ["niri/window"];
        modules-right = ["idle_inhibitor" "niri/language" "network" "battery" "clock"];

        "wlr/taskbar" = {
          on-click = "activate";
        };
      };
    };
  };
}
