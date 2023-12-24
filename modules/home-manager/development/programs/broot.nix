{pkgs, lib, config, dotfiles,...}:
let
    br-select = pkgs.writeShellScriptBin "br-select" ''
    broot --conf ${config.home.homeDirectory}/${config.xdg.configFile."broot/br-select.toml".target}
  '';
in

{

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = false;
    };
  };

  xdg.configFile."broot/br-select.toml".text = ''
  [[verbs]]
  invocation = "ok"
  key = "enter"
  leave_broot = true
  execution = ":print_path"
  '';

  home.packages = with pkgs; [
    br-select
  ];

}
