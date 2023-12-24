{ pkgs, config, ... }:

{
  imports = [
    ../pistol.nix
    ../broot.nix
  ];
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x $fx'';

      mkdir = ''
      %{{
        printf "Create Directory: "
        read DIR
        mkdir $DIR
      }}
      '';

      mkfile = ''
      %{{
        printf "Create File: "
        read FILE
        $EDITOR $FILE
      }}
      '';

      zoxide = ''
        %{{
          printf "Jump Directory: "
          read DIR
          result="$(${pkgs.zoxide}/bin/zoxide query --exclude $PWD $DIR | sed 's/\\/\\\\/g;s/"/\\"/g')"
            lf -remote "send $id cd \"$result\""
        }}
      '';

      trash = ''
        %{{
          printf "Trash selection? [y/n]: "
          read ans
          if [ "$ans" = "y" ]; then
            ${pkgs.trash-cli}/bin/trash-put $fx
          else
            echo "aborting"
          fi
          echo "" 
        }}
      '';

      broot-jump = ''
        ''${{
          res=$(br-select)
          if [ -f "$res" ]; then
            cmd="select"
          elif [ -d "$res" ]; then
            cmd="cd"
          fi
          lf -remote "send $id $cmd \"$res\""
        }}
      '';

      bulkrename = ''
        ''${{
            ${pkgs.vimv}/bin/vimv -- $(basename -a -- $fx)

            lf -remote "send $id load"
            lf -remote "send $id unselect"
          }}

      '';

      quit-and-cd = ''
      &{{
        pwd > $LF_CD_FILE
        lf -remote "send $id quit"
      }}
      '';

      extract = ''
      ''${{
        set -f
        filename=$(basename -- "$f")
        directory="''${filename%.*}"
        mkdir -p $directory
        case $f in
          *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) ${pkgs.gnutar}/bin/tar xjvf $f --directory=$directory;;
          *.tar.gz|*.tgz) ${pkgs.gnutar}/bin/tar xzvf $f --directory=$directory;;
          *.tar.xz|*.txz) ${pkgs.gnutar}/bin/tar xJvf $f --directory=$directory;;
          *.tar) ${pkgs.gnutar}/bin/tar xvf $f --directory=$directory;;
          *.zip) ${pkgs.unzip}/bin/unzip $f -d $directory;;
          *.rar) ${pkgs.unrar}/bin/unrar x $f --directory=$directory;;
          *.7z) ${pkgs.p7zip}/bin/7z x $f --directory=$directory;;
          *) echo "Unsupported format";;
        esac
      }}
      '';

      tar = ''
      ''${{
          timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
          ${pkgs.gnutar}/bin/tar -czvf "archive_$timestamp.tar.gz" $(realpath --relative-to="$PWD" $fx)
      }}
      '';


      zip = ''
      ''${{
          timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
          ${pkgs.zip}/bin/zip -r "archive_$timestamp.zip" $(realpath --relative-to="$PWD" $fx)
      }}
      '';

      
      toggle_preview = ''
       %{{
        if [ "$lf_preview" = "true" ]; then
          lf -remote "send $id :set preview false; set ratios 1:j"
        else
          lf -remote "send $id :set preview true; set ratios 1:2:3"
        fi
      }}
      '';

    };


    keybindings = {

      aa = "mkfile";
      aA = "mkdir";
      at = "tar";
      az = "zip";
      x = "extract";

      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "zp" = "toggle_preview";
      "<enter>" = "open";

      "g~" = "cd";
      "g/" = "cd /";
      "gj" = "zoxide";
      "f" = "broot-jump";

      "<delete>" = "trash";

      "q" = "quit-and-cd";
      "Q" = "quit";

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      incsearch = true;
      incfilter = true;
    };

    extraConfig = 
    let 
      previewer = 
        pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5
        
        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode memory --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi
        
        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode memory < /dev/null > /dev/tty
      '';
    in
    ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };

  # ...
}
