# gh4lua
github client for minecraft lua .... and framework to rule them all

## How to use deploy
On github you need to have a repository with lua code and file "g4l.txt" in root of it.
g4l.txt must contain first line with `username/reponame <branch>` in it and list of files deployed with deploy.

then on your device you will do this:
```
mkdir <yourproject>
cd <yourproject>
pastebin get 3HX0xdzN deploy.lua -- or use newer incanation of code, but 3HX0xdzN will work
deploy user/repository [branch]
```

and your code will live in this repository. You can just rerun `deploy` to update it from github.
This repository contains additional files to use it as a template when you create your own repository of code.


## How to use v framework

Equip your "computer" with modem. Pull this repository. Now your "computer" will search script <computer-name>.lua
in /v/ . Make Computer with modem and huge monitor and call it "base", this is your main control center.

Make some turtles with modems, install framework there. Now you can call it something like starmetal, and your turtle
can automaticly mine starmetal, send stats to base and execute some commands.

## Commands
on the console of "base computer" you can enter commands to your network. commands consists of name and actual command like 
`reactor stop`, unfortunatly cc modems can't send messages to it self, so, to stop base, you can just say `stop`.
Here is two builtin commands for each device in the network.
stop will interrupt execution and allow you to use standart shell, yell will show message on deviuce's console.
You can add custum commands to your cripts like `forcestop` in `reactor.lua`.


## developing
All code contained in v directory.
* `v.lua` is a main framework lib
* `run.lua` is a script executer, it called from startup file and launches correctscript in right environment.
* `base.lua` is a script for base computer, it show stats on monitor and receives commands on console.
* all other scripts have names `<computer-name>.lua` and will be moved to separate directory some time.