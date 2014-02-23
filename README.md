**Important:** The scripts in this project assume you have pssh in your PATH. See [Dependencies](#dependencies) for setup instructions.

##Overview
This repo contains the scripts and instructions used during the installation and deployment of [Deluxx Fluxx III](http://deluxxfluxx.com/). Deluxx Fluxx III included nine (9) arcade cabinets which were each driven by a Mac Mini. The arcade games themselves were developed to run in the Chrome web browser. We used many off-the-shelf components for the arcade inputs, but for some of the more unique cabinets we wrote custom software to run on [Ardiuno Leonardo](http://arduino.cc/en/Main/ArduinoBoardLeonardo#.UwpQYl6C4Qg) microcotrollers to translate the various inputs to keyboard and mouse interactions which Chrome could use as input.

The high-level strategy for setup and management was:
* bootstrap the computers
* use git to sync changes in the project to the machines
* use ssh to remotely manage the machines

For more detailed instructions, start in the [scripts](scripts/) directory.

####Credits
* Artists: [Faile](http://www.faile.net/), [BAST](http://www.bastny.com/)
* Sound Design: [Seth Jabour](http://sethjabour.com/)
* Development Team: [Eric Ishii-Eckhardt](https://github.com/ericie), [Matthew Cooley](https://github.com/matthewcc), [Julio Terra](https://github.com/julioterra), [Quin Kennedy](https://github.com/quinkennedy)

##Post-mortem thoughts
While the scripts made setup fairly painless, git has a number of features that can get in the way when using it in a uni-directional deployment model. There were a few instances where code or a config file had been changed on a machine. We would migrate these changes into the repo manually, so had to be sure to discard changes on the remote machines before re-deploying.

This deployment model makes more sense when you are doing active development on the target machines, then you can easily merge those changes back into the "main" codebase.

Originally we were hoping to be able to `git push` to each of the machines, but OSX is missing some utilities necessary to support remote-pushes. We re-architected our scripts to ssh into each target machine and `git pull` from the respective development repo.

##Dependencies
pssh (and dependencies) are installed with `pip install -r requirements.txt`. I recommend using [VirtualEnv](http://www.virtualenv.org/en/latest/virtualenv.html) to "sandbox" these dependencies. See instructions below for using VirtualEnv.

###Virtual Env
####Installing VirtualEnv
1. make sure you have pip installed, if not, follow the instructions [here](http://www.pip-installer.org/en/latest/installing.html)
	* with easy_install you can `sudo easy_install pip`
* `sudo pip install virtualenv`
* `virtualenv venv`
* `source venv/bin/activate`
* `pip install -r requirements.txt`

if you install anything new into the VirtualEnv, then you should:

1. `pip freeze > requirements.txt`
* commit the new `requirements.txt` to git
* collaborators should run `pip install -r requirements.txt`

####VirtualEnv Usage

1. `source venv/bin/activate`
* ...Do whatever it is you want in the project using the VirtualEnv sandbox...
* `deactivate` when you are done using the sandbox

[reference](http://docs.python-guide.org/en/latest/dev/virtualenvs/)