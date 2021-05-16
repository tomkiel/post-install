set -U default_node (nvm use default)
export ANDROID_HOME=/home/tomkiel/Android/Sdk
export JAVA_HOME=/usr/lib64/jvm/java-11-openjdk-11
export NPM_CURRENT_HOME=$HOME/.nvm/versions/node/(nvm current)

#set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin/ $PATH
set -gx PATH $ANDROID_HOME/build-tools/30.0.0 $PATH
set -gx PATH /opt/android-studio/bin $PATH
set -gx PATH /opt/gradle/bin $PATH
set -gx PATH /opt/flutter/bin $PATH
set -gx PATH $JAVA_HOME/bin $PATH
set -gx PATH $BREW_HOME/ $PATH
set -x NVM_DIR ~/.nvm
set -gx PATH $HOME/.config/composer/vendor/bin $PATH
set -gx PATH /opt/swift/usr/bin $PATH
set -gx PATH /opt/hugo $PATH

export NPM_CONFIG_PREFIX=$NPM_CURRENT_HOME

set fish_function_path $fish_function_path "/usr/share/powerline/fish" powerline-setup
powerline-setup

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/tomkiel/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/tomkiel/Downloads/google-cloud-sdk/path.fish.inc'; end
