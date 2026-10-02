{ self, inputs, moduleWithSystem, ... }: {

  flake.nixosModules.sddm = { pkgs, lib, ... }: let
    custom-theme = (pkgs.sddm-astronaut.override {
      embeddedTheme = "purple_leaves"; 
      themeConfig = {
				Background = pkgs.fetchurl {
					url = "https://raw.githubusercontent.com/rose-pine/wallpapers/refs/heads/main/minecraft/grand-hall.png";
					sha256 = "sha256-vwS7Jf23BFMR5R0D/8jMBKlRF01NV6ee1wrW4Y66vOo=";
				};
        # Background = "/home/micido/Pictures/Wallpapers/grand-hall.png";
				PartialBlur = "false";
      };
    });
  in {
    environment.systemPackages = with pkgs; [
      custom-theme
    ];

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
				theme = "sddm-astronaut-theme";
				extraPackages = with pkgs; [
					custom-theme 
					kdePackages.qtmultimedia
				];
      };
    };

  };

}
