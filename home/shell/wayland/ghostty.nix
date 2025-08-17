{config, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = config.stylix.fonts.monospace.name;
      font-size = 14;
      theme = "rose-pine";

      mouse-hide-while-typing = true;

      keybind = [
        "alt+shift+e=scroll_page_fractional:-0.5"
        "alt+shift+o=scroll_page_fractional:0.3"
      ];

      window-padding-balance = true;
      window-padding-color = "extend";
    };
  };

  stylix.targets.ghostty.enable = false;
}
