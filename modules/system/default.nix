{ self, ... }: {
	flake.nixosModules.base = { pkgs, ... }: {
		imports = [
			core
			audio
		];
	};
}
