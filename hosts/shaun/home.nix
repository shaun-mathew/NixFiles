{
  config,
  pkgs,
  dotfiles,
  ...
}: {
  imports = [
    ../../modules/home-manager/common
    ../../modules/home-manager/development
    ../../modules/home-manager/misc
  ];

  home.username = "shaun";
  home.homeDirectory = "/home/shaun";
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
