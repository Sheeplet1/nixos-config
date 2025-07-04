#!/bin/bash

################################################################################
# This script is used to bootstrap any terminal/zsh startup with BW (Bitwarden CLI)
# so that we can access any secrets stored in Bitwarden.
# Key prerequisites are:
# - BW_CLIENTID and BW_CLIENTSECRET environment variables must be set.
# - BW_PASSWORD environment variable must be set.
################################################################################

# Source our environment variables from the .bw_env file.
source "$HOME/.bw_env"

RED='\033[0;31m'
GREEN='\033[0;32m'
COLOR_OFF='\033[0m' # Text Reset

# Check if BW is installed. If BW is not installed, then we return early.
if ! command -v bw &>/dev/null; then
  echo -e "${RED}Error: Bitwarden CLI (bw) is not installed. Please install it first."
  return 1
fi

# Making sure we start with a clean slate and logging out of any previous sessions.
bw logout &>/dev/null

# Login with the API key that is stored in $BW_CLIENTID and $BW_CLIENTSECRET.
# We also check whether it was successful and return early if it was not.
echo -e "${COLOR_OFF}Logging into BW CLI with API key"

bw login --apikey &>/dev/null
if [ $? -ne 0 ]; then
  echo -e "${RED}Error: Failed to login to Bitwarden CLI. Please check your API key."
  return 1
fi

echo -e "${GREEN}Successfully logged into BW CLI with API key."

# Now we need to unlock the vault in order to access any secrets.
# We also check whether it was successful and return early if it was not.
echo -e "${COLOR_OFF}Unlocking BW vault with master password"

# We redirect the output to a file so that we can extract the session key into
# the BW_SESSION environment variable.
touch /tmp/bw_unlock_output.txt
bw unlock --passwordenv BW_PASSWORD &>/tmp/bw_unlock_output.txt
if [ $? -ne 0 ]; then
  echo -e "${RED}Error: Failed to login to Bitwarden CLI. Incorrect master password."
  return 1
fi

BW_SESSION="$(grep -o 'export BW_SESSION="[^"]*"' /tmp/bw_unlock_output.txt | cut -d= -f2- | tr -d '"')"
readonly BW_SESSION
export BW_SESSION

rm /tmp/bw_unlock_output.txt

echo -e "${GREEN}Successfully unlocked BW vault and set BW_SESSION environment variable."
