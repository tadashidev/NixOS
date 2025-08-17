{...}: {
  services.logind.lidSwitch = "suspend-then-hibernate";
  systemd.sleep.extraConfig = "HibernateDelaySec=30min";

  services = {
    geoclue2.enable = true;
    udisks2.enable = true;
  };
}
