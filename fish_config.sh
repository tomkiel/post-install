#!/bin/bash

echo "#####################"
echo "-> Install Oh My Fish Shell"
curl -L https://get.oh-my.fish | fish

echo "#####################"
echo "-> Configure fish shell"
chsh -s /usr/bin/fish
omf update
omf install agnoster
omf install bass

echo "All done!"
echo "Reboot system to aplly all configurations!"