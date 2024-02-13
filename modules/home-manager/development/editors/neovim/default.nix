{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: let
  configPath = pkgs.lib.concatStringsSep "/" [
    dotfiles
    "modules/home-manager/development/editors/neovim/config"
  ];
in {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs; [gcc wl-clipboard xclip tree-sitter cargo go];
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink configPath;
  };
}
