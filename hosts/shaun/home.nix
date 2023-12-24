{ config, pkgs, dotfiles, ... }:

{
  imports = [
    ../../modules/home-manager/common
    ../../modules/home-manager/development
  ];

  home.username = "shaun";
  home.homeDirectory = "/home/shaun";
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true; 

  home.stateVersion = "23.05";
  home.packages = with pkgs; [
  ];

  programs.home-manager.enable = true;

}

