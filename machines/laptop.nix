{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["modesetting"];
  hardware.amdgpu.initrd.enable = true;
  services.tlp.enable = true;
  boot = {
    kernelModules = [
      "kvm-amd"
      "acpi_call"
      "i2c-dev"
      "ddcci_backlight"
    ];
    kernelParams = [
      "mem_sleep_default=deep"
      "pcie_aspm.policy=powersupersave"

      ## Supposed to help fix for suspend issues: SSD not correctly working, and Keyboard not responding:
      ## Not needed for the 6.1+ kernels?
      # "iommu=pt"

      ## Fixes for s2idle:
      ##    https://www.phoronix.com/news/More-s2idle-Rembrandt-Linux
      "acpi.prefer_microsoft_dsm_guid=1"

      "amd_pstate=active"
    ];

    blacklistedKernelModules = ["nouveau"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      ddcci-driver
    ];
  };
  hardware.cpu.amd.updateMicrocode = true;
  services.fstrim.enable = lib.mkDefault true;
}
