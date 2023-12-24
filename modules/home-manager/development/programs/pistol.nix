{pkgs, lib, config, dotfiles,...}:

{

  programs.pistol = {
    enable = true;
    associations = [
      {
          mime = "text/*";
          command = "${pkgs.bat}/bin/bat --paging=never  --color=always %pistol-filename%";
      }

      {
          mime = "application/json";
          command = "${pkgs.bat}/bin/bat --paging=never --color=always %pistol-filename%";
      }

      {
          mime = "application/pdf";
          command = "pdftotext -l 5 -nopgbrk -layout -q -- %pistol-filename% -";
      }

      {
        mime = "image/*";
        command = "${pkgs.kitty}/bin/kitty +kitten icat --silent --transfer-mode=stream --stdin=no %pistol-filename%";
      } 

    ];
  };
}

