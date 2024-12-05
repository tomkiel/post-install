fish_config theme choose "Dracula Official"

#eval (dircolors $HOME/.dir_colors | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')
eval (dircolors $HOME/.dir_colors/dircolors | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')


## NVM
set -U default_node (nvm use default)
export NPM_CURRENT_HOME=$HOME/.nvm/versions/node/(nvm current)
export NPM_CONFIG_PREFIX=$NPM_CURRENT_HOME
set -x NVM_DIR ~/.nvm

## Pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

pyenv init - | source

### VAAPI
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_ENABLE_WAYLAND=1


## Custom binaries
set -Ux USER_LOCAL $HOME/.local/bin
fish_add_path $USER_LOCAL

## Rust Development 
set -Ux CARGO_HOME $HOME/.cargo
fish_add_path $CARGO_HOME/bin

### Flutter
fish_add_path -g -p /opt/flutter/bin


#Android Studio
set -Ux ANDROID_HOME $HOME/Android/Sdk
fish_add_path -g -p $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path -g -p $ANDROID_HOME/platform-tools
fish_add_path -g -p $ANDROID_HOME/build-tools/35.0.0
fish_add_path -g -p $ANDROID_HOME/emulator
fish_add_path -g -p /opt/android-studio/bin


#SDKMAN
set -Ux SDKMAN_HOME $HOME/.sdkman

function sdk
  bash -c '. ~/.sdkman/bin/sdkman-init.sh; sdk "$@"' sdk $argv
end

#JAVA
fish_add_path -g -p $SDKMAN_HOME/candidates/java/current/bin

#MAVEN
fish_add_path -g -p $SDKMAN_HOME/candidates/maven/current/bin

### Other
if status is-interactive
    # Commands to run in interactive sessions can go here
end
