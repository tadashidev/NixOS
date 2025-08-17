{...}: {
  services.resolved.enable = true;

  networking = {
    networkmanager = {
      enable = true;

      wifi = {
        powersave = false;
        backend = "iwd";
      };
    };

    nameservers = [
      # Cloudflare DNS.
      "1.1.1.3"
      "1.0.0.3"
      "2606:4700:4700::1113"
      "2606:4700:4700::1003"
    ];

    firewall.enable = false;
  };
}
