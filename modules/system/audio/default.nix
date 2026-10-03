{ self, ... }: {
	flake.nixosModules.audio = { pkgs, lib, ... }: {

		environment.systemPackages = with pkgs; [
			playerctl
			pavucontrol wiremix
			pulseaudioFull
			pipewire
		];

		security.rtkit.enable = true;
		
		services.pipewire = {
			enable = true;
			alsa = {
				enable = true;
				support32bit = true;
			};
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};

	};
}
