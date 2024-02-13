{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "shaun-mathew";
    userEmail = "shaunmathew123@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
