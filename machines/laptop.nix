{
  config,
  lib,
  pkgs,
  ...
}: {
  # When we move to nix 24.11
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["modesetting"];
  hardware.amdgpu.initrd.enable = true;
  services.tlp.enable = true;
  boot = {
    kernelModules = ["kvm-amd" "acpi_call"];
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
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };
  hardware.cpu.amd.updateMicrocode = true;
  services.fstrim.enable = lib.mkDefault true;
}
