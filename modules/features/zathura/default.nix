{ self, inputs, ... }: {
	
	perSystem = { pkgs, ... }: {
		packages.zathura = inputs.wrapper-modules.wrappers.zathura.wrap {
			inherit pkgs;
			settings = {
				recolor = true;
				recolor-keephue = true;
				
				default-bg = "#191724";
				default-fg = "#e0def4";

				statusbar-bg = "#555169";
				statusbar-fg = "#e0def4";

				inputbar-bg = "#6e6a86";
				inputbar-fg = "#ebbcba";

				notification-bg = "#e0def4";
				notification-fg = "#555169";

				notification-error-bg = "#f6c177";
				notification-error-fg = "#555169";

				notification-warning-bg = "#ebbcba";
				notification-warning-fg = "#555169";

				highlight-color = "rgba(0xeb, 0xbc, 0xba, 0.5)";
				highlight-active-color = "rgba(0xeb, 0x6f, 0x92, 0.5)";

				completion-bg = "#6e6a86";
				completion-fg = "#ebbcba";

				completion-highlight-bg = "#ebbcba";
				completion-highlight-fg = "#26233a";

				recolor-lightcolor = "#191724";
				recolor-darkcolor = "#ebbcba";
			};
		};
	};
}
