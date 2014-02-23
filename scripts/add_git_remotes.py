#!/usr/bin/env python

import os

with open("ip_address_list.txt") as f:
	content = f.readlines()

for entry in content:
	entry = entry.strip()
	machine = entry.split("@")[1].split(".")[0]
	command = "git remote add " + machine + " " + entry + ":~/Documents/DeluxxFluxxIII.git"
	os.system(command)

