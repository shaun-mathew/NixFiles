
{config, pkgs, pkgs-unstable, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "catppuccin_mocha";
    };
  };


  xdg.configFile."btop/themes" = {
    recursive = true;
    source = ./themes;
  };

}
