{ self, ... }: {
	flake.nixosModules.user = { pkgs, ... }: {
		imports = [ self.nixosModules.zsh ];
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
