{ self, ... }: {
	flake.nixosModules.user = { pkgs, ... }: {
		imports = [ zsh ];
		users.users.micido = {
			isNormalUser = true;
			description = "micido";
			shell = pkgs.zsh;
			extraGroups = [
				"networkmanager"
				"wheel"
			];
		};
	};
}
