{ self, inputs, moduleWithSystem, ... }: {
  
  flake.nixosModules.fraudConfiguration = moduleWithSystem (
		{ self', pkgs, lib, ... }: {
			imports = with self.nixosModules; [
    	  fraudHardware
    	  zsh
    	  nvim
    	  kitty
    	  niri
    	  sddm
				base
    	];

    	fonts.packages = with pkgs; [
    	  nerd-fonts.fira-code
    	  nerd-fonts.fira-mono
    	];

    	networking.hostName = "fraud";
    	networking.networkmanager.enable = true;

			hardware.bluetooth.enable = true;
			services.blueman.enable = true;

    	services.upower.enable = true;

    	services.udisks2.enable = true;

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
				self'.packages.zathura
				tuxedo
    	  bat lolcat
    	  nnn
    	  aria2
    	  self'.packages.myZen
    	];
		}
	);
}

