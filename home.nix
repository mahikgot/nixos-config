{ config, pkgs, ... }:
{
	home.username = "marky";
	home.homeDirectory = "/home/marky";
	home.packages = with pkgs; [
		neovim
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
	
	programs.wezterm = {
		enable = true;
		enableZshIntegration = true;
	};

	home.file.".config/i3" = {
		source = ./config/i3;
		recursive = true;
	};
	home.stateVersion = "25.11";
}
