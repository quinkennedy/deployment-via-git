This directory contains all the scripts used for setting up and managing the computers

[individual actions](individual+actions/) contains a short list of actions that need to be done manually on each target machine before continuing with the instructions below.

###After all computers are set up
1. Download the `git` installer and install it on all computers.
    * We used Remote Desktop to accomblish this
* run `copy_ssh_key.sh` to copy your computer's ssh key to the taget machines
* create ssh keys on each of the target machines via `ssh-keygen -t rsa`
    * This should be run on each target machine individually
* clone git repo onto target machines at `~/Documents/DF3`
    * or setup your computer as a remote if the repo already exists
    * `git remote add [short_name] [username]@[computername]:/Path/To/Repo`
    	- example: `git remote add quin quinkennedy@lab-macbookpro-02.local:~/Documents/myRepos/DF3`
* add StartChrome.app (in `~/Documents/DF3/for machines/scripts/` on target machines) to Startup Items
* run copy_ssh_keys_to_me.sh to copy the ssh keys *from* the target machines *to* your computer
* run `./runpssh.sh < write_cab_name.txt` to set up the cabinet names so Chrome will launch with the appropriate data

###Manual Settings
These need to be manually configured on each target machine
* turn off keyboard repeat ('system prefs' -> 'keyboard' -> 'keyboard' -> 'key repeat' to 'off')
* have computers sleep when power button is pressed ('sys pref' -> 'energy saver' -> 'sleep computer when power button is pressed')
* turn up volume `osascript -e "set Volume 10"`

###General Usage
* periodically you can run `./runpssh.sh < git_pull.txt` to get your master branch on all the target machines
    - you probably want to edit `git_pull.txt` to reference your remote
    - this command seems to fail the first time I run it, and succeed the second, I'm not sure why, perhaps the default timeout is too short? or my computer doesn't like being pulled from by 9 hosts simultaneously?
* run `./runpssh.sh < launchChrome.txt` to launch Chrome to test
* run `./runpssh.sh < killChrome.txt` to kill Chrome
