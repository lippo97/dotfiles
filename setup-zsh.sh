#!/bin/sh

function download_and_setup_zsh () {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  rm ~/.zshrc{,.pre-oh-my-zsh}
  touch ~/.environment
}

printf "Do you want to download oh-my-zsh? [y/N] "
read answer

if [[ "$answer" = "y" || "$answer" = "Y" ]]; then
  download_and_setup_zsh
  stow zsh
else
  echo "Aborting..."
fi

