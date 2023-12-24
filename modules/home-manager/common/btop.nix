
{config, pkgs, pkgs-unstable, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "tokyo-night";
    };
  };

}
