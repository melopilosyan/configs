# NOTE: Find the OS default .bashrc at /etc/skel/.bashrc

# Extentions installer requires ~/.local/bin in the PATH.
# Make it available diring the initial installation.
if [[ $PATH != *~/.local/bin* ]]; then PATH="$HOME/.local/bin:$PATH"; fi
mkdir -p ~/.local/bin

if ! grep -wq CONFIGS_DIR ~/.bashrc; then
  echo -e "\nexport CONFIGS_DIR=$CONFIGS_DIR" >> ~/.bashrc
  echo '[ -d $CONFIGS_DIR ] && source $CONFIGS_DIR/bash/bashrc' >> ~/.bashrc
fi

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
echo "\$include $CONFIGS_DIR/readline/inputrc" > ~/.inputrc

# Make functions available diring initial installation.
source "$CONFIGS_DIR/bash/functions.sh"
