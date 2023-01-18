{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (import ./overlay.nix)
    (import ../common/overlay.nix)
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_imx8;

  boot.loader = {
    grub.enable = lib.mkDefault false;
    # Enables the generation of /boot/extlinux/extlinux.conf.
    generic-extlinux-compatible.enable = lib.mkDefault true;
  };

  hardware.deviceTree.filter = "imx8qm-*.dtb";
}