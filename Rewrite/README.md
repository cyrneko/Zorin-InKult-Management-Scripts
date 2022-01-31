# ***This is a re-write of the inkultsetup.sh script***
## **as the previous one was quite messy, and I bet I can make it smaller and better with my current knowledge, I decided to re-write the entire thing with basically the same end-goal**

The basic principles of running the script still apply
Set Permissions:
```bash
chmod +x Any-Script-Here.sh # +x assigns the "run" permission to this script, making it able to be executed.
```
then do the following to run the script:
```bash
./Any-Script-Here.sh # actually run the script, without any arguments.
```

available arguments for **InKultRewritten.sh** can be seen by running the script like this:
```bash
./InKultWritten.sh -h
```

you should then get an output something like this (just that yours would be colored):
```
 ___       _  __     _ _     ____       _               
|_ _|_ __ | |/ /   _| | |_  / ___|  ___| |_ _   _ _ __  
 | || '_ \| ' / | | | | __| \___ \ / _ \ __| | | | '_ \ 
 | || | | | . \ |_| | | |_   ___) |  __/ |_| |_| | |_) |
|___|_| |_|_|\_\__,_|_|\__| |____/ \___|\__|\__,_| .__/ 
                                                 |_|    
This script sets up Zorin installations at the InKult Youth Center in Germany.
------------
Syntax: ./InKultRewritten.sh [Options]

Example options:
./InKultRewritten.sh -h   |   shows a help page for this script
./InKultRewritten.sh -c   |   starts installation and setup for Zorin 16 Core.
./InKultRewritten.sh -l   |   starts installation and setup for Zorin 16 Lite.
./InKultRewritten.sh -o   |   attempts to install on other debian-based distributions.
--plank can be used in combination with -l to install plank-dock.
```

from there, run options as shown in the script to do the actions which are defined for each *option¹*


> ¹ an option is here defined as an extension to the command which is ran, for example `-h` to show the help dialog

### PS: I don't know why I suddenly started writing in English instead of German, it's just something that I do whenever I code ig
