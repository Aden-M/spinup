##############################################################################
# ~/.zshrc – lightweight prompt with robust Git status colouring            #
##############################################################################

# Exit early if the shell isn’t interactive
[[ $- != *i* ]] && return

##### 1) History & general options ###########################################
HISTFILE=$HOME/.zsh_history
setopt prompt_subst EXTENDED_GLOB INC_APPEND_HISTORY \
       HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY \
       HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS \
       HIST_REDUCE_BLANKS HIST_VERIFY
HISTSIZE=5000
SAVEHIST=10000

##### 2) Completion ###########################################################
autoload -Uz compinit && compinit -u
zstyle ':completion:*' rehash true

##### 3) Plugins #############################################################
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-autocomplete
)
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

for plugin in "${plugins[@]}"; do
  plugin_dir="${ZSH_PLUGIN_DIR}/${plugin}"
  [[ -d $plugin_dir ]] || continue
  main=''
  for candidate in "$plugin_dir"/*.plugin.zsh(N) "$plugin_dir"/${plugin}.zsh(N); do
    [[ -r $candidate ]] && main=$candidate && break
  done
  [[ -z $main ]] && for candidate in "$plugin_dir"/*.zsh(N); do
    [[ $candidate == *run-tests.zsh ]] && continue
    [[ -r $candidate ]] && main=$candidate && break
  done
  [[ -n $main ]] && source "$main"
done

# history‑substring‑search keybindings (if present)
if (( $+functions[history-substring-search-up] )); then
  for map in '' viins vicmd; do
    bindkey -M ${map:-main} '^[[A' history-substring-search-up
    bindkey -M ${map:-main} '^[[B' history-substring-search-down
  done
fi

##### 4) Colours & Debian chroot label ######################################
autoload -U colors && colors
[[ -z ${debian_chroot:-} && -r /etc/debian_chroot ]] && debian_chroot=$(< /etc/debian_chroot)

##### 5) Lightweight Git status function ####################################
# Uses git porcelain output for fast, reliable status detection.

_git_prompt_info() {
  local branch dirty staged untracked colour
  # Ensure we are inside a Git work‑tree
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    # Collect status (porcelain output is machine‑readable)
    local gs
    gs=$(git status --porcelain 2>/dev/null)
    [[ -n $gs ]] && {
      [[ $gs == *"?? "* ]] && untracked=1        # untracked files
      echo "$gs" | grep -q '^[MADRCU]' && staged=1   # any staged changes
      echo "$gs" | grep -q '^.M' && dirty=1          # any unstaged mods
    }

    # Colour priority: unstaged/untracked (bright red = 9) > staged (yellow) > clean (soft green = 10)
    if [[ -n $dirty || -n $untracked ]]; then
      colour=9      # bright/light red (ANSI colour 9)
    elif [[ -n $staged ]]; then
      colour=yellow # standard yellow
    else
      colour=#5fd700     # bright/light green (ANSI colour 10)
    fi

    GIT_SEGMENT="%F{$colour} (${branch})%f"
  else
    GIT_SEGMENT=""
  fi
}
add-zsh-hook precmd _git_prompt_info

##### 6) Prompt ##############################################################
PROMPT='${debian_chroot:+($debian_chroot)}%B%F{green}%n@%m%b%f:%B%F{blue}%~%b%f${GIT_SEGMENT}%(!.#.$) '

##### 7) XTerm/Rxvt window title ############################################
precmd_title() { print -Pn "\e]0;%n@%m: %~\a" }
case $TERM in
  (xterm*|rxvt*) add-zsh-hook precmd precmd_title ;;
esac

##### 8) Colourised ls + legacy aliases #####################################
if command -v dircolors >/dev/null; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
  alias ls='ls --color=auto'
fi
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
zmodload zsh/zprof
