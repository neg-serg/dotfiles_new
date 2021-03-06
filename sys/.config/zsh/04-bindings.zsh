neg_dirs(){
    if [[ ! -z "${HOME}" ]]; then
        local -U neg_dirs=("${HOME}"/{1st_level,dw,src/1st_level})
        for t in {1..$#neg_dirs}; do
            typeset -x "NEGCD[${t}]=$neg_dirs[${t}]"
            bindkey "^[${t}" negcd-${t}
            eval "negcd-$t() { cd \"${NEGCD[$t]}\" && redraw-prompt }"
            eval "zle -N negcd-$t"
        done
    fi
}

bindings_init(){
    bindkey -e
    typeset -gx KEYTIMEOUT=10

    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh

    autoload -Uz zleiab && zle -N zleiab
    autoload -Uz inplace_mk_dirs && zle -N inplace_mk_dirs
    autoload -Uz imv
    autoload -Uz rationalise-dot && zle -N rationalise-dot
    autoload -Uz fg-widget && zle -N fg-widget
    autoload -Uz redraw-prompt
    autoload -Uz magic-abbrev-expand && zle -N magic-abbrev-expand
    autoload -Uz special-accept-line && zle -N special-accept-line
    _nothing() {}; zle -N _nothing

    autoload -Uz cd-rotate
    cd-back() { cd-rotate +1 }
    cd-forward() { cd-rotate -0 }
    zle -N cd-back && zle -N cd-forward
    bindkey "^[-" cd-forward
    bindkey "^[=" cd-back

    bindkey "^[" zvm_readkeys_handler
    autoload up-line-or-beginning-search && zle -N up-line-or-beginning-search
    autoload down-line-or-beginning-search && zle -N down-line-or-beginning-search
    bindkey "^[[A" up-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search
    bindkey "^p" up-line-or-beginning-search
    bindkey "^n" down-line-or-beginning-search
    bindkey " " magic-abbrev-expand
    bindkey . rationalise-dot
    bindkey "^xD" describe-key-briefly
    bindkey "^z" fg-widget
    bindkey '^J' fasd-complete
    bindkey '^@' fasd-complete
    bindkey '^m' special-accept-line
    bindkey " "  magic-space
    bindkey ",." zleiab
    bindkey . rationalise-dot
    bindkey -M isearch . self-insert # without this, typing a . aborts incremental history search
    bindkey '^xM' inplace_mk_dirs # load the lookup subsystem if it's available on the system

    for b in '3D' '3C' '5A' '5B'; bindkey "^[[1;$b" _nothing
    neg_dirs

    zstyle ':fzf-tab:*' continuous-trigger 'ctrl-space'
    zstyle ':fzf-tab:*' fzf-flags --height=20% --info=inline

    tab_then_fzf() {
        if [[ $LASTWIDGET = 'tab_then_fzf' ]]; then
            fzf-tab-complete
        else
            echo -n "\e[36m··\e[0m"
            zle expand-or-complete
            zle redisplay
        fi
    }

    zle -N tab_then_fzf
    bindkey '^@' tab_then_fzf
}
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
zvm_after_init_commands=(bindings_init)
