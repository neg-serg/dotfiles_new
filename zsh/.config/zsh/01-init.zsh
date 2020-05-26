unlimit
ulimit -c 0
limit stack 8192
limit core 0
limit -s

setopt append_history # this is default, but set for share_history
setopt share_history # import new commands from the history file also in other zsh-session
setopt extended_history # save each command's beginning timestamp and the duration to the history file
setopt histignorealldups # remove command lines from the history list when the first character on the line is a space

setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_verify # don't execute, just expand history
setopt hist_ignore_space # reduce whitespace in history
setopt inc_append_history # add comamnds as they are typed, don't wait until shell exit

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace
# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob # ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^^ ^ ^ ^ ^
setopt longlistjobs # display PID when suspending processes as well
setopt nonomatch # try to avoid the 'zsh: no matches found...'
setopt notify  # report the status of backgrounds jobs immediately
setopt hash_list_all  # whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt completeinword # not just at the end
setopt nohup  # don't send SIGHUP to background processes when the shell exits.
setopt auto_pushd # make cd push the old directory onto the directory stack.
setopt pushdminus # pushd -N goes to Nth dir in stack
setopt pushdsilent # do not print dirstack after each cd/pushd
setopt pushdtohome #pushd with no args pushes to home
setopt pushd_ignore_dups # don't push the same dir twice.
setopt nobeep # get rid of beeps
setopt noglobdots  # * shouldn't match dotfiles. ever.
setopt noshwordsplit  # use zsh style word splitting
setopt noflowcontrol # no c-s/c-q output freezing
setopt no_bg_nice # don't nice background jobs
setopt no_notify # do not notify about bg task ending
setopt no_monitor # do not notify about bg task ending

setopt c_bases  # print $(( [#16] 0xff ))
setopt prompt_subst # set the prompt
# make sure to use right prompt only when not running a command
setopt transient_rprompt # only show the rprompt on the current prompt
setopt interactivecomments # allow interactive comments
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word

setopt extendedglob # enable extended globbing
setopt interactivecomments # allow interactive comments after '#' in command line

# ~ substitution and tab completion after a = (for --x=filename args)
setopt magicequalsubst
# setopt glob_star_short # */** -> **

export PATH=/usr/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/go/bin:/home/neg/.cargo/bin
export EDITOR="nvim"
export VISUAL="${EDITOR}"
export PAGER="/usr/bin/nvimpager"
export READNULLCMD=${PAGER}
export MANPAGER="${PAGER}"

export TIMEFMT="[37m[34m⟬[37m[37m%J[34m⟭[39m[34m⟬[37m%U[34m⟭[39m[34m⟬[37muser %S[34m⟭[39m[34m⟬[37msystem %P[34m⟭[39m[34m⟬[37mcpu %*E total[34m⟭[39m[34m[39m[34m⟬[37mMem: %M kb max[34m⟭[39m"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export LS_COLORS

export HISTFILE=${ZDOTDIR}/zsh_history
export SAVEHIST=10000000
export HISTSIZE=$(( $SAVEHIST * 1.10 ))
export HISTORY_IGNORE="&:ls:[bf]g:exit:reset:clear:cd*:gs:gd"

export NEGCD1="${HOME}/1st_level"
export NEGCD2="${HOME}/dw"
export NEGCD3="${HOME}/src/1st_level"
export NEGCD4="${HOME}/src/wrk/infrastructure"

[[ -x =envoy ]] && { envoy ~/.ssh/{id_rsa,id_ecdsa}; source <(envoy -p) }

_zpcompinit_custom() {
    setopt extendedglob local_options
    autoload -Uz compinit
    local zcd=${ZDOTDIR:-$HOME}/.zcompdump
    local zcdc="$zcd.zwc"
    # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
    # in the background as this is doesn't affect the current session
    if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
        else
            compinit -C -d "$zcd"
            { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
    fi
}
_zpcompinit_custom

zmodload -i zsh/complist
autoload -Uz history-search-end
autoload -Uz split-shell-arguments
autoload -Uz lookupinit

if [[ -x =fasd ]]; then
    fasd_cache="${XDG_CACHE_HOME}/fasd-init-cache"
    if [ ! -s "${fasd_cache}" ]; then
        fasd --init auto >| "${fasd_cache}"
    fi
    source "${fasd_cache}"
    unset fasd_cache
fi

if [[ -x =direnv ]]; then
    _direnv_hook() {
        trap -- '' SIGINT;
        eval "$("/usr/bin/direnv" export zsh)";
        trap - SIGINT;
    }
    typeset -ag precmd_functions;
    if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
        precmd_functions=( _direnv_hook ${precmd_functions[@]} )
    fi
    typeset -ag chpwd_functions;
    if [[ -z ${chpwd_functions[(r)_direnv_hook]} ]]; then
        chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
    fi
fi

stty_setup() {
    stty time 0 2> /dev/null
    stty min 0 2> /dev/null
    stty line 6 2> /dev/null
    stty speed 38400 &> /dev/null
    stty eof  2> /dev/null  # stty eof ''
}
[[ $- =~ i ]] && stty_setup &!

[[ -f "${XDG_CONFIG_HOME}/dircolors/dircolors" ]] && \
    eval $(dircolors "${XDG_CONFIG_HOME}/dircolors/dircolors")

# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
