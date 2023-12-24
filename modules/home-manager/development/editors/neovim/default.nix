{pkgs, lib, config, dotfiles,...}:

{

  programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        gcc
        wl-clipboard
        xclip
        tree-sitter
      ];
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };

}
