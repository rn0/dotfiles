[ -n "$PS1" ] && source ~/.bash_profile

# HSTR configuration - add this to ~/.bashrc                                                                                                                                                                       
alias hh=hstr                    # hh to be alias for hstr                                                                                                                                                         
export HSTR_CONFIG=hicolor       # get more colors                                                                                                                                                                 
export HSTR_CONFIG=raw-history-view                                                                                                                                                                                
                                                                                                                                                                                                                   
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries                                                                                                                                                    
export HISTSIZE=100000                   # big big history                                                                                                                                                         
export HISTFILESIZE=100000               # big big history                                                                                                                                                         
shopt -s histappend                      # append to history, don't overwrite it                                                                                                                                   
                                                                                                                                                                                                                   
# Save and reload the history after each command finishes                                                                                                                                                          
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"                                                                                                                                        
                                                                                                                                                                                                                   
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)                                                                                                                                   
bind '"\C-r": "\C-a hstr -- \C-j"'                                                                                                                                                                                 
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
