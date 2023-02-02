{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (import ./overlay.nix)
    (import ../common/overlay.nix)
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_imx8;
  boot.kernelParams = [ "console=ttyLP0,115200n8" ];

  boot.loader.grub = {
    enable = lib.mkDefault true;
    extraFiles = {
      "imx8qm-mek-hdmi.dtb" = "${pkgs.linux_imx8}/dtbs/freescale/imx8qm-mek-hdmi.dtb";
    };
  };

  disabledModules = [ "profiles/all-hardware.nix" ];
  boot.initrd.includeDefaultModules = lib.mkForce false;

  hardware.deviceTree = {
    enable = true;
    filter = "imx8qm-*.dtb";
    name = "imx8qm-mek-hdmi.dtb";
  };
}
