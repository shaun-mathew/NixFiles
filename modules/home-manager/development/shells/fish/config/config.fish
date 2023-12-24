# Disable the interactive message
set -g fish_greeting

if command -q zoxide
    zoxide init fish --cmd j | source
end

if command -q starship
    starship init fish | source
end

#kitty-shell-integration
if set -q KITTY_INSTALLATION_DIR
    set --global KITTY_SHELL_INTEGRATION enabled
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Aliases
alias ll='eza --icons'
alias lah='eza --icons -lah'
alias open='xdg-open'
alias update-dots='nix run home-manager/release-23.11 -- switch --flake ~/dotfiles/#shaun'
alias nix-clean='nix-collect-garbage  --delete-old'
alias ssh='ssh -o ServerAliveInterval=30'

#Variables
set -gx EDITOR nvim
set -g fish_key_bindings fish_hybrid_key_bindings

set -gx NNN_TRASH 1

# Disable fzf Ctrl + R keybinding
bind --erase \cr
bind -M insert --erase \cr

if command -q direnv
    direnv hook fish | source
end
