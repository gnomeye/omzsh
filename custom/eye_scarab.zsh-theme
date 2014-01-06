## COLOR

FG_BLUE=%F{004}
FG_GREY=%F{007}
FG_DARK=%F{240}
FG_GREY=%F{244}
FG_GREEN=%F{002}
FG_RED=%F{001}
FG_YELLOW=%F{003}

## FUNCTION

local return_code="%(?..${FG_RED}%?%{$reset_color%})"
## PROMPT

PROMPT=$'%{$reset_color%}${FG_BLUE}%M ${FG_GREY}%~ '
RPROMPT='$(vi_mode_prompt_info)${return_code}$(git_prompt_info)'

## GIT

ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG_DARK}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${FG_RED}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${FG_GREEN}✔"

## VI

MODE_INDICATOR="${FG_YELLOW}<%{$reset_color%} "


