{ self, inputs, ... }: {

	flake.nixosModules.bootloader = { pkgs, lib, ... }: {
		boot = {
			loader = {
				timeout = 2;
				efi = { canTouchEfiVariables = true; };
				grub = {
					efiSupport = true;
					device = "nodev";
					theme = pkgs.minimal-grub-theme;
				};
			};

			plymouth = {
				enable = true;
				theme = "cubes";
				themePackages = with pkgs; [
					(adi1090x-plymouth-themes.override {
        	  selected_themes = [ "cubes" ];
        	})
				];
			};

		};
	};
}
