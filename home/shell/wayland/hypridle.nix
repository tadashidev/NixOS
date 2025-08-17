{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
      };

      listener = [
        {
          timeout = 60; # 1 minute.
          on-timeout = "brightnessctl -s set 1%";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 150; # 2 minutes, 30 seconds.
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
        {
          timeout = 240; # 4 minutes.
          on-timeout = "systemctl suspend-then-hibernate";
        }
      ];
    };
  };
}
