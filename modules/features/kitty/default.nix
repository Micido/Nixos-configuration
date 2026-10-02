{ self, inputs, moduleWithSystem, ...}: {

   flake.nixosModules.kitty = moduleWithSystem (
     { self' }: {
       environment.systemPackages = with self'.packages; [ kitty ];
     }
   );

  perSystem = { pkgs, ... }: {
    packages.kitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;

      # Env override
      environment = let
        fira-mono = pkgs.nerd-fonts.fira-mono;
        fira-code = pkgs.nerd-fonts.fira-code;
				fontsConf = pkgs.makeFontsConf {
					fontDirectories = [ fira-mono fira-code ];
				};
      in {
        "FONTCONFIG_FILE" = "${fontsConf}";
      };

      # Font
      font = {
        name = "FiraMono Nerd Font Mono";
				size = 11;
      };

      # Settings
      settings = {
        font_size = 11;
				scrollbar = "never";
				pixel_scroll = false;
				window_padding_width = 9;
				background_opacity = 0.8;
				confirm_os_window_close = 0;
				enable_audio_bell = false;
				cursor_trail = 1;
				cursor_trail_start_threshold = 1;
				cursor_trail_color = "#9ccfd8";
				cursor_shape = "beam";
				allow_remote_control = true;
      };

      # Theme
      themeFile = "rose-pine";
    };
  };

}
