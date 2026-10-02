{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable nixpkgs

    nvim = {
      url = "github:Micido/neovim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
				wrappers.follows = "wrapper-modules";
      };
    };

    flake-parts.url = "github:hercules-ci/flake-parts"; # Flake parts
    import-tree.url = "github:vic/import-tree"; # Import tree

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules"; # Wrapper modules
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: 
    inputs.flake-parts.lib.mkFlake 
      { inherit inputs; }
      ( inputs.import-tree ./modules );
}
