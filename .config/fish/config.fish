 # ~/.config/fish/config.fish

set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"

set -gx HISTCONTROL ignoreboth
set -gx HISTSIZE 1000
set -gx HISTFILESIZE 2000

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx PYTHONSTARTUP ~/.pythonrc

# set a fancy prompt (non-color, unless we know we "want" color)
switch $TERM
  case 'xterm-*'
  case '*-256color'
  case 'alacritty'
    set -g color_prompt "yes"
end

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
set -g force_color_prompt "yes"

if test -n "$force_color_prompt"
  if test -x /usr/bin/tput && tput setaf 1 > /dev/null ^ /dev/null
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    set -g color_prompt "yes"
  else
    set -u color_prompt
  end
end

# colored GCC warnings and errors
set -x GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if type -q lsd > /dev/null ^ /dev/null
  alias ls "lsd"
  alias ll 'lsd -ahl'
  alias l 'lsd'
  alias lt 'lsd --tree'
else
  alias ls 'ls --color=auto'
  alias ll 'ls -ahlF'
  alias l 'ls -CF'

  alias dir 'dir --color=auto'
  alias vdir 'vdir --color=auto'
end

if type -q fdfind > /dev/null ^ /dev/null
  alias fd "fdfind"
end

if type -q fzf > /dev/null ^ /dev/null
  alias fzf "env SHELL=/bin/bash fzf"
end

if type -q glow > /dev/null ^ /dev/null
  alias glow "glow --pager"
end

function alert -d "Alert alias for long running commands. Use like so: sleep 10; alert"
  set icon (test $status = 0 && echo terminal || echo error)
  set summary (history --reverse | tail -n1)
  notify-send --urgency=low -i "$icon" "$summary"
end

alias mv "mv -v -i"
alias cp "cp -v -r -i"
alias rm "rm -v -rf"
alias del "trash -v -rf"
alias md "mkdir -p"
alias sizeof "du -shc"
alias ugz "tar xvzf"
alias ubz "tar xvjf"
alias uxz "tar -xf"
alias uzip "unzip"
alias utar "tar -xvf"
alias tustat "netstat -tulpn"
alias myip "hostname -I"
alias update "sudo apt-get update"
alias upgrade "sudo apt-get upgrade -y"
alias install "sudo apt-get install -y"
alias uninstall "sudo apt-get remove -y"
alias purge "sudo apt-get purge -y"
alias autoremove "sudo apt-get autoremove -y"
alias freeze "apt list --installed ^ /dev/null"
alias why "apt-cache show"
alias package "apt-cache search"
alias about "lsb_release -a"
alias listdirs "ll -d */"
alias listfiles "ll -p | grep -v /"
alias serve "python -m http.server --bind 0.0.0.0"
alias sha1 "sha1sum | awk '{print \$1}'"
alias c2c "xclip -selection c"
alias dkc "docker-compose"
alias krmdang "docker rmi (docker images --filter 'dangling=true' -q --no-trunc)"
alias lua "rlwrap lua"
alias luajit "rlwrap luajit"
alias lcargo "env CARGO_TARGET_DIR=./target cargo"

abbr s "sudo"

abbr k "docker"
abbr kps "docker ps -a"
abbr krun "docker run --rm -it"
abbr kexc "docker exec -it"
abbr klog "docker logs"
abbr kvol "docker volume"
abbr kkll "docker kill"
abbr kimg "docker image"

abbr g "git"
abbr ga "git add"
abbr gb "git branch"
abbr gc "git commit"
abbr gco "git checkout"
abbr gcl "git clean -fxfd"
abbr gd "git diff"
abbr gdr "git push origin --delete"
abbr gds "git stash && git stash drop"
abbr gf "git fetch --prune"
abbr gh "git stash"
abbr ghp "git stash pop"
abbr ghu "git stash --include-untracked"
abbr gl "git lg"
abbr gm "git merge"
abbr gp "git pull"
abbr gr "git rebase -i"
abbr gs "git status"
abbr gsp "git squash"

function weather -d"Get weather prevision"
  if count $argv > /dev/null
    set location (string join "+" $argv)
    curl "wttr.in/$location"
  else
    curl "wttr.in"
  end
end

function cht -d"Call cht.sh"
  if test (count $argv) -lt 2
    curl "cht.sh/$argv"
  else
    set topic $argv[1]
    set query (string join "+" $argv[2..-1])
    curl "cht.sh/$topic/$query"
  end
end

function new -d"Create new file"
  if count $argv > /dev/null
    mkdir -p (dirname $argv[1])
    touch $argv
  else
    echo "Not enought arguments, you must specify the file name"
  end
end

function copyfull -d"copy file path to clipboard"
  set file (fzf)
  echo (pwd)/$file | c2c
end

function copyrel -d"copy relative file path to clipboard"
  set file (fzf)
  echo $file | c2c
end

function ctrlp -d "ctrlp for shell"
  if set file (fzf --preview="bat --color=always --style=plain {}" --reverse)
    switch $file
      case '*.md'
        if type -q glow > /dev/null ^ /dev/null
          command glow --pager $file
        else
          bat --style=header $file
        end
      case '*'
        bat --style=header $file
    end
  end
end

function ctrlf -d "ripgrep search across files"
  set __old__INITIAL_QUERY $INITIAL_QUERY
  set __old__RG_PREFIX $RG_PREFIX
  set __old__FZF_DEFAULT_COMMAND $FZF_DEFAULT_COMMAND

  set -gx INITIAL_QUERY ""
  set -gx RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
  set -gx FZF_DEFAULT_COMMAND "$RG_PREFIX '$INITIAL_QUERY'"

  if set entry (fzf --bind "change:reload:$RG_PREFIX {q} || true" --ansi --disabled --query "$INITIAL_QUERY" --delimiter=":" --preview-window="+{2}-/2" --preview="bat --color=always --style=plain -H {2} {1}")
    set filename (echo $entry | awk -F ":" '{print $1}')
    set highlight (echo $entry | awk -F ":" '{print $2}')
    echo $entry | awk -F ":" '{print $2} {print $1}' | xargs bat --style=header -H
  end

  set -gx INITIAL_QUERY $__old__INITIAL_QUERY
  set -gx RG_PREFIX $__old__RG_PREFIX
  set -gx FZF_DEFAULT_COMMAND $__old__FZF_DEFAULT_COMMAND
end

function cd -d "Change director set up for jump back"
  if test -d $argv
    set -g __last_directory (pwd)
    builtin cd $argv
  else
    echo $argv not a directory
  end
end

function b -d "Jump back to previous location"
  if test -z $__last_directory
    builtin cd ..
  else
    set __tmp $__last_directory
    set -e __last_directory
    builtin cd $__tmp
  end
end

function j -d "Autojump set up for jump back"
  set -g __last_directory (pwd)
  command j $argv
end

function fcs -d"cheat.sh with fzf topic"
  set topic (curl "cht.sh/:list" ^ /dev/null | fzf)
  if test -n topic
    cht $topic $argv
  end
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

# FZF GIT commands {{{

function fgl -d "Git commit history"
  if set commit (git log --pretty='format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative | fzf --preview="git show {1} | delta --no-gitconfig")
    echo $commit | awk '{print $1}' | xargs git show
  end
end

function fgh -d "Git stashes"
  if set stash (git stash list | fzf --delimiter=":" --preview="git stash show -p {1} | delta --no-gitconfig")
    echo $stash | awk -F ":" '{print $1}' | xargs | git stash show -p
  end
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fco -d "Use `fzf` to choose which branch to check out" --argument-names branch
  set -q branch[1]; or set branch ''
  git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 10% --layout=reverse --border --query=$branch --select-1 | xargs git checkout
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function snag -d "Pick desired files from a chosen branch"
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 20% --layout=reverse --border)
  if test -n "$branch"
    set files (git diff --name-only $branch | fzf --height 20% --layout=reverse --border --multi)
  end
  if test -n "$files"
    git checkout $branch $files
  end
end

# }}}

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

set -gx FZF_DEFAULT_OPTS "--reverse --height=90%"
set -gx GOPATH "$HOME/.go"
set -gx GOROOT "/opt/go"
set -gx CARGO_TARGET_DIR "$HOME/.cache/cargo"
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

set PATH "$PATH:/usr/local/bin"
set PATH "$PATH:/opt/node/bin"
set PATH "$PATH:$HOME/.local/bin"
set PATH "$PATH:$HOME/.cargo/bin"
set PATH "$PATH:$HOME/.poetry/bin"
set PATH "$PATH:$HOME/.bin"
set PATH "$PATH:$GOPATH/bin"
set -gx PATH "$PATH"

if test -d ~/.python3
  source ~/.python3/bin/activate.fish
end

if status --is-interactive
  if test -f ~/.autojump/share/autojump/autojump.fish; . ~/.autojump/share/autojump/autojump.fish; end

  if type -q starship > /dev/null ^ /dev/null
      starship init fish | source
  end

  bind \cp ctrlp
  if bind -M insert > /dev/null 2>&1
    bind -M insert \cp ctrlp
  end

  bind \cf ctrlf
  if bind -M insert > /dev/null 2>&1
    bind -M insert \cp ctrlf
  end

  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

if test -f ~/.config/fish/sys_config.fish
  source ~/.config/fish/sys_config.fish
end
