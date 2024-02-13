{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      enableFishIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
