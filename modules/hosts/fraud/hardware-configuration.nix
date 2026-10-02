{ self, inputs, ... }: {

  flake.nixosModules.fraudHardware = { config, lib, pkgs, modulesPath, ... }: { 
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];
    
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" "rtsx_usb_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
    
    fileSystems."/" =
      { device = "/dev/disk/by-uuid/f217c7c6-1763-4521-8ba3-c1db5b01a98e";
        fsType = "ext4";
      };
    
    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/3BD8-2557";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
    
    swapDevices = [
      { device = "/dev/disk/by-uuid/a81e2530-4b64-4fae-8514-cec81074dcf0"; }
    ];
    
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
