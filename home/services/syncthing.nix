{...}: {
  services.syncthing = {
    enable = true;

    tray.enable = true;

    settings = {
      devices = {
        "Phone" = {
          id = "AG6UHOA-GGUR52J-BPYEO27-QWDFPC5-WO2GTXR-WGAFKFE-AZQ4J7M-DPZXMAZ";
        };
      };
      folders = {
        "~/Documents" = {
          id = "Documents";
          versioning.type = "staggered";
          devices = ["Phone"];
        };
        "~/Public/Syncthing" = {
          id = "General";
          versioning.type = "staggered";
          devices = ["Phone"];
        };
        "~/Pictures" = {
          id = "Pictures";
          versioning.type = "staggered";
          devices = ["Phone"];
        };
        # Don't forget to add an exception in `~/Pictures` to ignore this directory.
        "~/Pictures/DCIM" = {
          id = "Pictures-DCIM";
          versioning.type = "staggered";
          devices = ["Phone"];
        };
      };
    };
  };
}
