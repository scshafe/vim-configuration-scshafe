#! /bin/bash

CONFIGURATION_REPO_PATH=$PWD
VIM_CONFIGURATION_PATH="$HOME/.vim"
NEOVIM_CONFIGURATION_PATH="$HOME/.config/nvim"
BASHRC_CONFIG="$HOME/.bashrc"

echo "$CONFIGURATION_REPO_PATH"
echo "$VIM_CONFIGURATION_PATH"
echo "$NEOVIM_CONFIGURATION_PATH"

# ---- create configuration directories ----

if [[ ! -e $NEOVIM_CONFIGURATION_PATH ]]; then
	error = $(mkdir -p $NEOVIM_CONFIGURATION_PATH)
fi


if [[ ! -e $VIM_CONFIGURATION_PATH ]]; then
	error = $(mkdir -p $NEOVIM_CONFIGURATION_PATH)
fi


# ---- export environment variables ----

if [[ ! -e $BASHRC_CONFIG ]]; then
	error = $(touch "$BASHRC_CONFIG")
fi

CONFIGURATION_REPO_ENV_VARIABLE="$(whoami)_VIM_CONFIGURATION_REPO"

echo "$CONFIGURATION_REPO_ENV_VARIABLE"

if [[ -z $(grep "$CONFIGURATION_REPO_ENV_VARIABLE" $BASHRC_CONFIG) ]]; then
	echo "adding environment variables to $BASHRC_CONFIG"
	echo "$CONFIGURATION_REPO_ENV_VARIABLE=$CONFIGURATION_REPO_PATH" >> "$BASHRC_CONFIG"
	echo "adding path to configuration repo to $BASHRC_CONFIG"
	echo "export PATH=$PATH:$CONFIGURATION_REPO_PATH" >> "$BASHRC_CONFIG"
else
	echo "environment variables already set in .bashrc. Not adding anything"
fi


# ---- copy configuration over to new directories

echo "warning, this will overwrite current directories for neovim and vim configuration."
echo "Would you like to proceed?"

read -r ANSWER
#ANSWER = $(echo "$ANSWER" | tr '[:lower:]')

if [[ $ANSWER == [yY] ]]; then
	echo "copying configuration to local system directories"
	cp -r "$CONFIGURATION_REPO_PATH/.config/nvim" "$NEOVIM_CONFIGURATION_PATH"
	cp -r "$CONFIGURATION_REPO_PATH/.vim" "$VIM_CONFIGURATION_PATH"
fi





echo "changes to the bashrc must be sourced to make these scripts callable"



