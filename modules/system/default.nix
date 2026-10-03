{ self, ... }: {
	flake.nixosModules.base = { pkgs, ... }: {
		imports = with self.nixosModules; [
			core
			audio
		];
	};
}
