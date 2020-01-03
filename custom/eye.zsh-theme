## COLOR

FG_DARK=%F{008}
FG_GREY=%F{007}
FG_RED=%F{001}
FG_GREEN=%F{002}
FG_YELLOW=%F{003}
FG_BLUE=%F{004}
FG_MAGE=%F{005}
FG_CYAN=%F{006}

## VARS

HOSTNAME=`hostname|cut -c -1` 
PREFIX="λ"
    
## FUNCTION

local return_code="%(?..${FG_RED}%?%f%k)"
## PROMPT

PROMPT=$'%{$reset_color%}${FG_YELLOW}%(4~|…/%2~|%3~) ${FG_GREY}%f%k'
RPROMPT='$(vi_mode_prompt_info)$(git_prompt_info)'

## GIT

ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG_YELLOW}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%k"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${FG_RED}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${FG_GREEN}✔"

## VI

MODE_INDICATOR="${FG_YELLOW}<%f%k "


