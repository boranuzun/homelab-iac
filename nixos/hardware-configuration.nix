# hardware-configuration.nix
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # Boot
  boot.initrd.availableKernelModules = [ 
    "ahci" 
    "xhci_pci" 
    "virtio_pci" 
    "virtio_scsi" 
    "sd_mod" 
    "sr_mod" 
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Enable QEMU Guest Agent for Proxmox integration
  services.qemuGuest.enable = true;

  # CPU microcode updates (not needed in VM but doesn't hurt)
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # Set the system architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}