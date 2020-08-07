# ~~doob~~

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
    # Unset all configuration
    emulate -L zsh -o extended_glob
    unset -m 'POWERLEVEL9K_*'
    autoload -Uz is-at-least && is-at-least 5.1 || return
    zmodload zsh/langinfo
    if [[ ${langinfo[CODESET]:-} != (utf|UTF)(-|)8 && $+commands[locale] == 1 ]]; then
        local -a loc
        if loc=(${(@M)$(locale -a 2>/dev/null):#*.(utf|UTF)(-|)8}) && (( $#loc )); then
            local LC_ALL=${loc[(r)(#i)C.UTF(-|)8]:-${loc[(r)(#i)en_US.UTF(-|)8]:-$loc[1]}}
        fi
    fi

    # Left segment
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
        vi_mode
        vcs
        dir
    )

    # Right segment
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        status
        command_execution_time
        battery
        time
    )

    # Icon font
    typeset -g POWERLEVEL9K_MODE=nerdfont-complete

    # Separator style
    typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='|'
    typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='|'
    typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
    typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''

    # Prompt style
    typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=2
    typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=1
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='->'

    # Vi mode
    typeset -g POWERLEVEL9K_VI_MODE_FOREGROUND=0
    typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
    typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
    typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=REPLACE
    typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=INSERT
    typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=14
    typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=5
    typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=3
    typeset -g POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND=6

    # Version contol system
    typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=15
    typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=15
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=15
    typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=15
    typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=7
    typeset -g POWERLEVEL9K_VCS_BACKGROUND=8

    # Directory
    typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
    typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
    typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
    typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
    typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
    typeset -g POWERLEVEL9K_DIR_FOREGROUND=15
    typeset -g POWERLEVEL9K_DIR_BACKGROUND=8

    # Status
    typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
    typeset -g POWERLEVEL9K_STATUS_OK=true
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_ERROR=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
    typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
    typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=2
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=0
    typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1
    typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=0
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=1
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=0
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=1
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=0

    # Command execution time
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION='祥'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=7
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=0

    # Battery
    typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
    typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false
    typeset -g POWERLEVEL9K_BATTERY_STAGES=''
    typeset -g POWERLEVEL9K_BATTERY_CHARGING_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_BATTERY_LOW_VISUAL_IDENTIFIER_EXPANSION=''
    typeset -g POWERLEVEL9K_BATTERY_FOREGROUND=15
    typeset -g POWERLEVEL9K_BATTERY_BACKGROUND=8
    typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=1

    # Time
    typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%I:%M %p}'
    typeset -g POWERLEVEL9K_TIME_FOREGROUND=0
    typeset -g POWERLEVEL9K_TIME_BACKGROUND=6

    # Reload configuration
    (( ! $+functions[p10k] )) || p10k reload
}
