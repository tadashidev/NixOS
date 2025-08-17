{
  config,
  pkgs,
  modulesPath,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Aqua";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["vmd" "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["kvm-intel"];
    kernelParams = [
      "mitigations=off"
      "resume_offset=533760" # For hibernation, there is a better way?
    ];
    extraModulePackages = [];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd"];
    };

    "/home" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    "/swap" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "btrfs";
      options = ["subvol=swap" "noatime"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

  boot.resumeDevice = "/dev/disk/by-label/NIXOS";

  hardware = {
    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
    graphics.extraPackages = [pkgs.intel-media-driver];
  };

  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
    usePercentageForPolicy = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
  };
  # I do not want socket activation.
  systemd.services.upower.wantedBy = ["multi-user.target"];

  environment.systemPackages = [
    pkgs.intel-gpu-tools
  ];

  time.timeZone = "Etc/GMT+5";
}
