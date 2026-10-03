{ self, ... }: {
	flake.nixosModules.user = { pkgs, ... }: {
		users.users.micido = {
			isNormalUser = true;
			description = "micido";
			extraGroups = [
				"networkmanager"
				"wheel"
			];
		};
	};
}
