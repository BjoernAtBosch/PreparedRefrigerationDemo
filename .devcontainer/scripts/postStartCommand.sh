#!/bin/bash

set -e

echo "               ▒▒▒▒▒▒▒▒▒
         ▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▒▒              ▓▓ ▒▒
    █▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓  ▓▓  ▒▒       ▓▓▓▓ ▓▓▒▒
  ██       ███  ▓▓  ▓▓  ▓▓ ▒▒   ██ ▓ ▓▓▓▓▒▒
              ███ ▓▓ ▓▓▓ ▓▓  ▒▒ ██▓▓▓▓ ▓▒▒
                ██  ▓▓ ▓▓ ▓▓▓ ▒▒█ ▓▓▓▓▓▒▒                           ▓▓                       ▓▓▓
                  ██ ▓▓ ▓▓  ▓▓ ▒▒ ▓▓▓▓▒▒    ▓▓       ▓▓             ▓▓                             ▓▓
                   ██ ▓▓ ▓▓  ▓▓█▒▒▓▓▓▒▒      ▓▓     ▓▓   ▓▓▓▓▓▓▓    ▓▓   ▓▓▓▓▓▓▓    ▓▓▓▓▓▓▓  ▓▓  ▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓
                    ██ ▓▓ ▓▓  ▓▓█▓▓▓▓         ▓▓   ▓▓▓  ▓▓▓    ▓▓   ▓▓  ▓▓     ▓▓  ▓▓        ▓▓    ▓▓           ▓▓   ▓▓
                     ██ ▓▓ ▓▓  ▓▓▓▓▓          ▓▓   ▓▓   ▓▓▓▓▓▓▓▓▓   ▓▓  ▓▓     ▓▓  ▓▓        ▓▓    ▓▓      ▓▓▓▓▓▓▓   ▓▓▓▓▓
                      ██ ▓▓ ▓▓██▓▓             ▓▓ ▓▓    ▓▓▓         ▓▓  ▓▓     ▓▓  ▓▓        ▓▓    ▓▓     ▓▓    ▓▓        ▓▓▓
                       ██ ▓▓  ▓▓▓              ▓▓▓▓▓    ▓▓▓         ▓▓  ▓▓▓    ▓▓  ▓▓▓       ▓▓    ▓▓     ▓▓    ▓▓         ▓▓
                        ██ ▓▓ █▓                ▓▓▓       ▓▓▓▓▓▓▓   ▓▓    ▓▓▓▓▓      ▓▓▓▓▓▓  ▓▓      ▓▓▓    ▓▓▓ ▓▓   ▓▓▓▓▓▓
                         ██  ██
                          ████
"

echo "###########################################"
echo "#  Creating your Vehicle App              #"
echo "###########################################"

# start fresh, regardless of cached data
sudo rm -rf ~/.velocitas

velocitas create $VELOCITAS_CREATE_ARGS

# Since we kind of hijack the same devContainer and these directories
# might have been created by a different user ID, we make sure to delete
# cached velocitas packages in order to avoid conflicts.
sudo rm -rf ~/.velocitas

echo "###########################################"
echo "# DONE! Please rebuild your devContainer. #"
echo "###########################################"
