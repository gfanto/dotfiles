 # ~/.config/fish/config.fish

set -x LANG "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"

set -x HISTCONTROL ignoreboth
set -x HISTSIZE 1000
set -x HISTFILESIZE 2000

set -x EDITOR nvim

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

alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

if type -q delta > /dev/null ^ /dev/null
  alias delta 'delta --syntax-theme=gruvbox'
end
if type -q bat > /dev/null ^ /dev/null
  alias bat 'bat --theme=gruvbox'
  alias batcat 'bat --theme=gruvbox --style=plain'
end

function alert -d "Alert alias for long running commands. Use like so: sleep 10; alert"
  set icon (test $status = 0 && echo terminal || echo error)
  set summary (history --reverse | tail -n1)
  notify-send --urgency=low -i "$icon" "$summary"
end

alias new "touch"
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
alias bluec "btc connect"
alias blued "btc disconnect"
alias dkc "docker-compose"
alias krmdang "docker rmi (docker images --filter 'dangling=true' -q --no-trunc)"
alias lua "rlwrap lua"
alias luajit "rlwrap luajit"

abbr s "sudo"

abbr k "docker"
abbr kps "docker ps"
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
abbr go "git checkout"
abbr gcl "git clean -fxfd"
abbr gd "git diff"
abbr gdr "git push origin --delete"
abbr gl "git lg"
abbr gm "git merge"
abbr gp "git pull"
abbr gr "git rebase"
abbr gs "git status"
abbr gsp "git squash"

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
    if test -n $file
      bat --style=header $file
    end
  end
end

function lc -d "Load file to copy clipborad"
  if count $argv > /dev/null
    if test -f $argv
      cat $argv | c2c
      echo $argv copied to clipboard
    else
      echo $argv not a file
    end
  else
    echo not enought arguments
  end
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

function search -d "Search string into path with fuzzy"
  if count $argv > /dev/null
    set fileline (rg -i $argv | fzf)
    set filesplit (string split ':' $fileline)
    if test -n $filesplit[1]
      bat --style=plain $filesplit[1]
    end
  end
end

function glog -d "Git commit history"
  if count $argv > /dev/null
    set commit (git log --pretty='format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -- $argv | fzf --preview="glog_view {} $argv" | re "\w+")
  else
    set commit (git log --pretty='format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative | fzf --preview="glog_view {}" | re "\w+")
  end

  if test -n commit
    if count $argv > /dev/null
      git diff $commit -- $argv
    else
      git diff $commit
    end
  end
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

# FZF GIT commands {{{

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
  # use fzf to choose source branch to snag files FROM
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 20% --layout=reverse --border)
  # avoid doing work if branch isn't set
  if test -n "$branch"
    # use fzf to choose files that differ from current branch
    set files (git diff --name-only $branch | fzf --height 20% --layout=reverse --border --multi)
  end
  # avoid checking out branch if files aren't specified
  if test -n "$files"
    git checkout $branch $files
  end
end

function fzum -d "View all unmerged commits across all local branches"
  set viewUnmergedCommits "echo {} | head -1 | xargs -I BRANCH sh -c 'git log master..BRANCH --no-merges --color --format=\"%C(auto)%h - %C(green)%ad%Creset - %s\" --date=format:\'%b %d %Y\''"

  git branch --no-merged master --format "%(refname:short)" | fzf --no-sort --reverse --tiebreak=index --no-multi \
    --ansi --preview="$viewUnmergedCommits"
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

set -x FZF_DEFAULT_OPTS "--reverse --height=90%"
set -x GOPATH "$HOME/.go"
set -x GOROOT "/opt/go"
set -x CARGO_TARGET_DIR "$HOME/.cache/cargo"
set -x PYTHONBREAKPOINT "ipdb.set_trace"
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

set -g PATH "$PATH:/usr/local/bin"
set -g PATH "$PATH:/opt/node/bin"
set -g PATH "$PATH:$HOME/.local/bin"
set -g PATH "$PATH:$HOME/.cargo/bin"
set -g PATH "$PATH:$HOME/.poetry/bin"
set -g PATH "$PATH:$HOME/.bin"
set -g PATH "$PATH:$GOPATH/bin"
set -x PATH "$PATH"

if test -f ~/.autojump/share/autojump/autojump.fish; . ~/.autojump/share/autojump/autojump.fish; end
if type -q starship > /dev/null ^ /dev/null
    starship init fish | source
end

bind \cp ctrlp
if bind -M insert > /dev/null 2>&1
  bind -M insert \cp ctrlp
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# IMPORTANT: this must be the last one
if test -d ~/.python3
  source ~/.python3/bin/activate.fish
end
# END

if test -f ~/.config/fish/personal.fish
  source ~/.config/fish/personal.fish
end
