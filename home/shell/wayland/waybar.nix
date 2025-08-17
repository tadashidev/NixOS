{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        exclusive = true;

        position = "top";

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
