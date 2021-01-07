if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  export PATH=$PATH:~/.local/bin
  #  exec startx &> .xsession-errors
fi
