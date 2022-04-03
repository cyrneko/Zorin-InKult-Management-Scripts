# ***This is a re-write of the inkultsetup.sh script***
## **as the previous one was quite messy, and I bet I can make it smaller and better with my current knowledge, I decided to re-write the entire thing with basically the same end-goal**

---

The basic principles of running the script still apply

### Set Permissions (if they're not set already):
```bash
chmod +x Any-Script-Here.sh
# chmod +x assigns the "run" permission to this script, making it able to be executed.
```

### then do the following to run the script:
```bash
./Any-Script-Here.sh
# this is to actually run the script, without any arguments.

# you can also just double-click onto the .sh file and hit "Execute" in the upcoming window
```

### available arguments for **InKultRewritten.sh** can be seen by running the script like this:
```bash
# this ↓
./InKultRewritten.sh -h

# you can also simply run the script(s) *without* any arguments to get a GUI that you can interact with using your mouse
```

### you should then get an output, something like this is considered normal:
##### (for InKultRewritten.sh, InKultManagement.sh has a different help screen)
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
```

from there, run options as shown in the script to do the actions which are defined for each *option¹*


> ¹ an option or argument is here defined as an extension to the command which is ran to allow additonal actions. For example `-h` to show the help dialog, or `-o` to install on any given Debian-Based distribution

PS: I don't know why I suddenly started writing in English instead of German, it's just something that I do whenever I code ig

:trollface:
