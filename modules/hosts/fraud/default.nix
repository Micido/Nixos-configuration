{ self, inputs, config, ... }: {
  
  flake.nixosConfigurations.fraud = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      fraudConfiguration
    ];
  };
}
