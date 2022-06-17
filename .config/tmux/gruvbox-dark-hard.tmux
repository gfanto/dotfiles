# default statusbar colors
set-option -g status-style "fg=#bdae93,bg=#3c3836"

# default window title colors
set-window-option -g window-status-style "fg=#bdae93,bg=default"

# active window title colors
set-window-option -g window-status-current-style "fg=#d79921,bg=default"

# pane border
set-option -g pane-border-style "fg=#3c3836"
set-option -g pane-active-border-style "fg=#504945"

# message text
set-option -g message-style "fg=#d5c4a1,bg=#3c3836"

# pane number display
set-option -g display-panes-active-colour "#b8bb26"
set-option -g display-panes-colour "#d79921"

# clock
set-window-option -g clock-mode-colour "#b8bb26"

# copy mode highligh
set-window-option -g mode-style "fg=default,bg=#665c54"

# bell
set-window-option -g window-status-bell-style "fg=#3c3836,bg=#fb4934"

# hightlight match
set-option -g copy-mode-match-style "fg=#282828,bg=#fabd2f"
set-option -g copy-mode-current-match-style "fg=#282828,bg=#fabd2f"

set-option -g status-position top

set -g status-interval 2
set -g status-right " #[bg=#504945,fg=#a89984] %H:%M:%S #[bg=#a89984,fg=#1d2021] #(tmux-status-rs --mem-rel --mem-pos=2 --cores-pos=1 --bat-pos=3 --interval=2 --cores=0 --show-bat --show-cores --show-mem) "
set -g status-right-length 100
