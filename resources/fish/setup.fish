#!/bin/fish

echo "1: Install bass:"
rm -rf bass && git clone https://github.com/edc/bass.git && make -C bass install

echo "2: Install agnoster:"
rm -rf agnoster && git clone https://github.com/hauleth/agnoster.git && mv agnoster/functions/{agnoster.fish,fis_mode_prompt.fish} $HOME/.config/fish/functions/

fish
