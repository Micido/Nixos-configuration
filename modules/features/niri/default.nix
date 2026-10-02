{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, config, ... }: {   
    systemd.user.services.niri.enableDefaultPath = false;

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };
    
  perSystem = { pkgs, lib, self', ... }: {

    config.packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
	  (lib.getExe self'.packages.myNoctalia)
	];

	prefer-no-csd = {};	

        input = {
	  keyboard = {
            xkb.layout = "fr";
          };
	  focus-follows-mouse = {};
	};

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 5;
        layout.focus-ring = {
          active-color = "#908caa";
          inactive-color = "#6e6a86";
          urgent-color = "#eb6f92";
        };
        
	hotkey-overlay = {
          skip-at-startup = {};
	};                     
	
	overview = {
	  backdrop-color = "#191724";
	};

#	workspaces = let
#	  settings = { 
#	    layout.gaps = 5;
#	    layout.focus-ring = {
#	      active-color = "#908caa";
#	      inactive-color = "#6e6a86";
#	      urgent-color = "#eb6f92";
#	    };
#	  };
#	in {
#	  "w0" = settings;
#	  "w1" = settings;
#	  "w2" = settings;
#	  "w3" = settings;
#	  "w4" = settings;
#	};
        
        binds = {
          "Mod+Q".spawn-sh = lib.getExe self'.packages.kitty;
          "Mod+W".close-window = {};
	  "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

	  "Mod+C".center-column = {};
	  "Mod+Shift+F".fullscreen-window = {};
	  "Mod+F".maximize-column = {};
	  
	  "Mod+H".focus-column-left = {};
	  "Mod+L".focus-column-right = {};
          "Mod+K".focus-window-up = {};
          "Mod+J".focus-window-down = {};

	  "Mod+Shift+H".move-column-left = {};
	  "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-up = {};
          "Mod+Shift+J".move-window-down = {};

	  "Mod+Left".focus-column-left = {};
	  "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};

	  "Mod+comma".consume-or-expel-window-left = {};
	  "Mod+semicolon".consume-or-expel-window-right = {};

	  "Mod+ampersand".focus-workspace = 1;
	  "Mod+eacute".focus-workspace = 2;
	  "Mod+quotedbl".focus-workspace = 3;
	  "Mod+apostrophe".focus-workspace = 4;
	  "Mod+parenleft".focus-workspace = 5;

	  "Mod+Shift+ampersand".move-column-to-workspace = 1;
	  "Mod+Shift+eacute".move-column-to-workspace = 2;
	  "Mod+Shift+quotedbl".move-column-to-workspace = 3;
	  "Mod+Shift+apostrophe".move-column-to-workspace = 4;
	  "Mod+Shift+parenleft".move-column-to-workspace = 5;
        };
      };
    };

  };

}
