{pkgs, lib, config, dotfiles,...}:
{

  programs.starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[](bold green) ";
          error_symbol = "[](bold red) ";
          vimcmd_symbol = "[](bold green) ";
          vimcmd_replace_one_symbol = "[](bold purple) ";
          vimcmd_replace_symbol = "[](bold purple) ";
          vimcmd_visual_symbol = "[](bold yellow) ";
        };
      };
  };

}
#➜
