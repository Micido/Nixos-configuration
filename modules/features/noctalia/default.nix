{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    config.packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = {
        inherit (builtins.fromJSON (builtins.readFile ./noctalia.json));
      };
    };
  };
}
