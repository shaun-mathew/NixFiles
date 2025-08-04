{
  pkgs,
  lib,
  config,
  dotfiles,
  pkgs-unstable,
  ...
}: {
  imports = [
    (import ./neovim {
      inherit config lib dotfiles;
      pkgs = pkgs-unstable;
    })
  ];
}
