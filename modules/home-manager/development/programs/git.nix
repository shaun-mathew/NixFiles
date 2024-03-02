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
      credential.helper = "/usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret";
    };
  };
}
