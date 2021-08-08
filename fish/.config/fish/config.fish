export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/usr/local/Cellar/openvpn/2.5.3/sbin:$PATH"

abbr -a g git
abbr -a v nvim

abbr -a w cd ~/dev/work/
abbr -a d cd ~/dev/projects/
abbr -a n cd ~/notes/

alias ..='cd ..'
alias ...='cd ../..'

alias ef='v ~/.config/fish/config.fish'
alias eg='v ~/.gitconfig'
alias ev='v ~/.config/nvim/init.vim'
alias et='v ~/.tmux.conf'
alias ek='v ~/.config/karabiner/karabiner.json'
alias ea='v ~/.config/alacritty/alacritty.yml'

alias q='exit'
alias :q='exit'

alias t='tmux attach || tmux new-session'
alias ta='tmux attach -t'
alias tn='tmux new-session'
alias tl='tmux list-sessions'
alias tk='tmux kill-server'

if command -v exa > /dev/null
	abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a lll 'exa -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

fish_vi_key_bindings
