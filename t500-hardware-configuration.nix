{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_generic" "uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  # neither of the options below had any effect
  #boot.extraModprobeConfig = "options snd slots=snd-hda-intel";
  #boot.extraModprobeConfig = "options snd-hda-intel model=thinkpad";


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/49527b03-de7b-4a0e-a265-8745003f987e";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7d8a93d7-e5e1-45e9-8734-c26a044c02c8"; }
    ];

  nix.maxJobs = 2;
  nix.extraOptions = "build-cores = 2";

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.systemWide = true;
  hardware.bluetooth.enable = true;
}
