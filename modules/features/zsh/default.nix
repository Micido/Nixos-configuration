{ self, inputs, moduleWithSystem, ... }: {

  flake.nixosModules.zsh = moduleWithSystem (
    { pkgs, self', ... }: {
      # Overlay
      nixpkgs.overlays = [
        (f: p: { zsh = self'.packages.zsh; })
      ];
      
      # Zsh
      programs.zsh = {
        enable = true;
				enableCompletion = true;
				enableBashCompletion = true;
				autosuggestions.enable = true;
				syntaxHighlighting.enable = true;
				histSize = 10000;
      };
      
      # Default shell
      users.defaultUserShell = pkgs.zsh;

			# Zoxyde
			programs.zoxide = {
			  enable = true;
				enableZshIntegration = true;
			};
    }
  );

  perSystem = { pkgs, lib, self', ... }: {
    packages = {
      zsh = inputs.wrapper-modules.wrappers.zsh.wrap {
        inherit pkgs;
	
				# Added pkgs
				runtimePkgs = with pkgs; [ carapace fzf ];
  			
  			      # Aliases
				zshAliases = {
				  ls = "${lib.getExe pkgs.lsd}";
				  tree = "${lib.getExe pkgs.lsd} --tree";
				  cat = lib.getExe pkgs.bat;
				  lg = lib.getExe pkgs.lazygit;
				  man = "man -P \"${lib.getExe pkgs.bat} -p\"";
				  nrs = "sudo nixos-rebuild switch --flake /home/micido/.dotfile";
				};
  			
				# .zshrc
				zshrc.content = ''
				  # Carapace
				  autoload -U compinit && compinit
					export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
				  zstyle ':completions:*' format $'\e[2;37mCompleting %d\e[m'
				  source <(${lib.getExe pkgs.carapace} _carapace zsh)
				  zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  			
  			  # Word style
  			  autoload -U select-word-style
  			  select-word-style bash
				  
				  # Case glob
				  setopt NO_CASE_GLOB
  			
				  # Nix your shell
				  if command -v ${lib.getExe pkgs.nix-your-shell} > /dev/null; then
						${lib.getExe pkgs.nix-your-shell} zsh | source /dev/stdin
  			  fi

					bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word

					# Fzf
					export FZF_ALT_C_OPTS="
						--walker-skip .git,node_modules,target
						--preview '${lib.getExe pkgs.lsd} --tree {}'"
					export FZF_CTRL_T_OPTS="
						--walker-skip .git,node_modules,target
						--preview '${lib.getExe pkgs.bat} -n --color=always {}'
						--bind 'ctrl-/:change-preview-window(down|hidden|)'"
					export FZF_DEFAULT_OPTS=$'--color=fg:#908caa,bg:#191724,hl:#ebbcba,fg+:#e0def4,bg+:#26233a
						--color=hl+:#ebbcba,info:#9ccfd8,prompt:#908caa,pointer:#c4a7e7
						--color=marker:#d4c0ee,spinner:#f6c177,header:#31748f,border:#403d52
						--color=gutter:#26233a,preview-fg:#e0def4'
				  source <(${lib.getExe pkgs.fzf} --zsh)
  			
				  # Oh my posh
				  eval "$(${lib.getExe self'.packages.ohMyPosh} init zsh)"
				'';
      };

      ohMyPosh = inputs.wrapper-modules.wrappers.oh-my-posh.wrap {
        inherit pkgs;
				configFile = ./config.toml;
      };
    };
  };

}
