{
  pkgs,
  lib,
  config,
  ...
}: let
  tmux-keys = ''
    bind ^X lock-server
    bind ^D detach
    #bind * list-clients
    bind : command-prompt
    bind * setw synchronize-panes
    bind r command-prompt "rename-window %%"
    bind R source-file ~/.config/tmux/tmux.conf
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    #bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -selection clipboard"

    bind p previous-window
    bind n next-window
    bind ^A last-window
    bind-key a send-prefix
    bind c new-window -c "$HOME"
    bind '"' choose-window
    bind S choose-session

    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    bind ^W select-pane -l

    bind J swap-pane -D
    bind K swap-pane -U

    #repeat key in prefix mode
    bind -r -T prefix , resize-pane -L 20
    bind -r -T prefix . resize-pane -R 20
    bind -r -T prefix - resize-pane -D 7
    bind -r -T prefix = resize-pane -U 7
    bind z resize-pane -Z

    bind x kill-pane
    bind s split-window -v -c "#{pane_current_path}"
    bind v split-window -h -c "#{pane_current_path}"
    bind P set pane-border-status

  '';

  tmux-config = ''
    set -g renumber-windows on       # renumber all windows when any window is closed
    set -g set-clipboard on          # use system clipboard
    set -g status-position top       # macOS / darwin style
    set -g detach-on-destroy off     # don't exit from tmux when closing a session
    set -g status-position top       # macOS / darwin style
    set -g pane-active-border-style 'fg=magenta,bg=default'
    set -g pane-border-style 'fg=brightblack,bg=default'
    set -g allow-passthrough on

  '';
in {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    historyLimit = 1000000;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    terminal = "xterm-kitty";
    shell = "${pkgs.fish}/bin/fish";

    plugins = with pkgs; [
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g;" $target | ${pkgs.moreutils}/bin/sponge $target; sed "s|nvim --cmd lua.*|nvim|g" $target | ${pkgs.moreutils}/bin/sponge $target'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = tmuxPlugins.tmux-thumbs;
        extraConfig = "set -g @thumbs-command 'echo -n {} | ${pkgs.xsel}/bin/xsel --clipboard --input'";
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules "session user host date_time"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
          set -g @catppuccin_window_default_text "#{b:pane_current_path}"
        '';
      }
    ];

    extraConfig = pkgs.lib.concatStringsSep "\n" [tmux-keys tmux-config];
  };

  home.packages = with pkgs; [xsel];
}
