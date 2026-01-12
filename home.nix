{ config, pkgs, lib, ... }:
{
	home.username = "marky";
	home.homeDirectory = "/home/marky";
	home.packages = with pkgs; [
		firefox
    pulsemixer
    bluetui
    brightnessctl
    xclip
		polybarFull
		neovim
		ripgrep
		taskwarrior3
		evil-helix
		unzip
		bottom
	];

	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Mark Guiang";
				email = "mahikgot@gmail.com";
			};
		};
	};
	programs.zsh = {
		enable = true;
		initContent = lib.mkOrder 1500 "bindkey '^ ' autosuggest-accept";
		antidote = {
			enable = true;
			plugins = [
				"zsh-users/zsh-autosuggestions"
				"zsh-users/zsh-syntax-highlighting"
			];
		};
	};
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
		options = [
			"--cmd cd"
		];
	};
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
		fileWidgetCommand = "fd --type f -u";
		changeDirWidgetCommand = "fd --type d -u";
	};
	programs.fd = {
		enable = true;
		hidden = true;
	};
	
	programs.wezterm = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
		nix-direnv.enable = true;
	};
	programs.eza = {
		enable = true;
		git = true;
		enableZshIntegration = true;
		colors = "auto";
		icons = "auto";
	};
	home.file.".wezterm.lua" = {
		source = ./config/wezterm/.wezterm.lua;
	};
	home.file.".config/i3" = {
		source = ./config/i3;
		recursive = true;
	};
	home.file.".config/polybar" = {
		source = ./config/polybar;
		recursive = true;
	};
	home.file.".config/helix" = {
		source = ./config/helix;
		recursive = true;
	};


	home.stateVersion = "25.11";
}
