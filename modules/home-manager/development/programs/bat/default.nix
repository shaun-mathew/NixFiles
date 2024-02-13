{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: {
  programs.bat = {
    enable = true;
    config = {theme = "Catppuccin-mocha";};
    extraPackages = with pkgs.bat-extras; [batdiff batman];
  };

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./themes;
  };
}
