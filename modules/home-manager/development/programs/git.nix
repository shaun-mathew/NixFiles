{pkgs, lib, config, dotfiles,...}:

{

  programs.git.enable = true;
  home.file.".gitconfig".text = ''
  [init]
    defaultBranch = main
  [user]
    email = "shaunmathew123@gmail.com"
    name = "shaun-mathew"
  [core]
    editor = nvim
  '';

}
