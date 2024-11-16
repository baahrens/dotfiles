export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="/usr/local/opt/llvm@14/bin:$PATH"
export PATH="$HOME/dev/projects/Odin:$PATH"
export PATH="$HOME/.binaries:$PATH"

fnm env --use-on-cd | source

if test uname = Linux
    setxkbmap -option compose:menu
    fzf_configure_bindings --directory=/cf --variables=/e/cv
else
    set -x LC_ALL en_US.UTF-8
    set -x LC_CTYPE en_US.UTF-8
end

abbr -a g git
abbr -a gm git switch master
abbr -a g- git switch -
abbr -a gu git pull
abbr -a gp git push
abbr -a grm git rebase -i origin/master
abbr -a grc git rebase --continue
abbr -a gra git rebase --abort

abbr -a v nvim

abbr -a dot cd ~/.dotfiles/
abbr -a w cd ~/dev/work/
abbr -a d cd ~/dev/projects/
abbr -a n cd ~/notes/

abbr -a .. cd ..
abbr -a ... cd ../..
abbr -a .... cd ../../..

abbr -a q exit
abbr -a :q exit

abbr -a cl clear

if command -v exa >/dev/null
    abbr -a l exa
    abbr -a ls exa
    abbr -a ll 'exa -l'
    abbr -a lll 'exa -la'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

fish_vi_key_bindings
