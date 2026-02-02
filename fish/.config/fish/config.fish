export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="/usr/local/opt/llvm@14/bin:$PATH"
export PATH="$HOME/dev/projects/Odin:$PATH"
export PATH="$HOME/.binaries:$PATH"
export PATH="$HOME/.local/share/nvim/mason:$PATH"

set --universal pure_symbol_ssh_prefix true
set --universal pure_color_primary "#dc8cc3"
set --universal tide_pwd_color_anchors A47BEA
set --universal tide_pwd_color_dirs 7E5ABB
set --universal tide_character_color DF8E1D
set --universal tide_git_color_branch green
set --universal tide_git_color_conflicted red
set --universal tide_git_color_dirty red
set --universal tide_git_color_operation normal
set --universal tide_git_color_staged green
set --universal tide_git_color_stash normal
set --universal tide_git_color_untracked blue
set --universal tide_git_color_upstream normal
set --universal tide_prompt_pad_items true
set --universal tide_prompt_icon_connection ' '


fnm env --use-on-cd | source

set -ge THEME

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
alias gmu="git switch master && git pull"
abbr -a gp git push
abbr -a grm git rebase -i origin/master
abbr -a grc git rebase --continue
abbr -a gra git rebase --abort
abbr -a gs nvim +"Git"

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

if command -v eza >/dev/null
    abbr -a l eza
    abbr -a ls eza
    abbr -a ll 'eza -l'
    abbr -a lll 'eza -la'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

fish_vi_key_bindings

fzf_configure_bindings --directory=\cf
source /usr/local/Cellar/chruby-fish/1.0.0/share/fish/vendor_functions.d/chruby.fish
source /usr/local/Cellar/chruby-fish/1.0.0/share/fish/vendor_conf.d/chruby_auto.fish
chruby ruby-3.4.1

# pnpm
set -gx PNPM_HOME "/Users/basti/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
