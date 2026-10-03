{ self, inputs, ... }:{
	flake.nixosModules.nix = { pkgs, lib, ... }: {
		nix = {
			settings = {
				cores = 2;
				trusted-users = [ "root" ];
				experimental-features = [
					"nix-command"
					"flakes"
				]; 
			};
			optimise.automatic = true;
			gc = {
				automatic = true;
				dates = "weekly";
				options = "--delete-older-than 5d";
			};
		};

		nixpkgs.config.allowUnfree = true;
	};
}
