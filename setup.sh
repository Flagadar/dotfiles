#!/bin/bash

name="Custom DE"
version=0.1

scriptdir="./dotfiles"

help()
{
echo
echo "My post install script with my dotfiles,"
echo "custom DE and needed utilities."
echo
echo "OPTIONS:"
echo
echo "  -i, --install"
echo "    Install everything, with my current dotfiles"
echo
echo "  -c, --check"
echo "    Outputs already installed dependencies," 
echo "    as well as their versions"
echo 
echo "  -u, --update"
echo "    Update out of date dependencies"
echo 
echo "  -h, --help"
echo "    Show this help"
echo 
echo " --------------------------------------------------------- "
echo 
echo "These options below are for my personal use," 
echo "they will ERASE YOUR CONFIGS!"
echo "Don't use them if you don't want the exact same"
echo "config as me"
echo 
echo "  -d, --dotfiles"
echo "    Update MY DOTFILES"
echo "    DON'T USE if you have your custom config!"
echo
echo "  -a, --all"
echo "    Update everything INCLUDING MY DOTFILES!" 
echo "    Don't use it if you have a custom config!"
echo
}

echo "$name, version $version"

optstring=":hi"

# Parse options
while getopts $optstring option; do
  case $option in
    i)# Install
      source $scriptdir/install.sh
      exit;;
    h)# Display help
      help
      exit;;
    ?)# Invalid
      echo "Error: -$OPTARG is not a valid option"
      help
      exit;;
  esac
done

#If no options passed
if [ $OPTIND -eq 1 ]; then 
  help
  exit
fi
