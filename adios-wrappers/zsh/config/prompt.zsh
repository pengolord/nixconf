# === Prompt Options ===

# Loads in autocomplete
autoload -Uz compinit
compinit

# Adds version control info to prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats 'on  %b '

# Sets the prompt
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %F{red}${vcs_info_msg_0_}%f
❯ '
