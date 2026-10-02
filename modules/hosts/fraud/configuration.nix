{ self, inputs, ... }: {
  
  flake.nixosModules.fraudConfiguration = { pkgs, lib, ... }: {

    imports = with self.nixosModules; [
      fraudHardware
      zsh
      nvim
      kitty
      niri
      sddm
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];

    networking.hostName = "fraud";
    networking.networkmanager.enable = true;

		hardware.bluetooth.enable = true;
		services.blueman.enable = true;

		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    services.upower.enable = true;

    time.timeZone = "Europe/Paris";
    console.keyMap = "fr";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8"; 
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };

    services.udisks2.enable = true;

    services.xserver = {
      xkb = {
        layout  = "fr"; 
        variant = ""; 
      };
    };

    nixpkgs.config.allowUnfree = true;

    users.users.micido = {
      isNormalUser = true;
      description = "micido";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages = with pkgs; [
      firefox
      vim
      git
      fzf
      grc
      obsidian
			bluetui
      pstree
      zip unzip
      killall
      jq
      lsd
      lazygit
      fd
      pv
      ripgrep
      hwinfo
      udiskie
      fetch
      github-cli
      btop htop
      ffmpeg
			zathura
			tuxedo
      bat lolcat
      nnn
      aria2
      self.packages.${pkgs.stdenv.hostPlatform.system}.myZen
    ];

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}

