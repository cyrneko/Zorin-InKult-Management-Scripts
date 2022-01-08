#!/bin/bash

# testing with some options...
while getopts ":h" option; do
   case $option in
      h) # display Help
         echo "it didn't!"
         exit;;
   esac
done

echo "oh god did it break?"
exit 0