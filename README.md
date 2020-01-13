# gh4lua
github client for minecraft lua



## How to use
On github you need to have a repository with lua code and file "g4l.txt" in root of it. g4l.txt must contain first line with `username/reponame <branch>` in it and list of files deployed with deploy.

then on your device you will do this:
```
mkdir <yourproject>
cd <yourproject>
pastebin get 3HX0xdzN deploy.lua -- or use newer incanation of code, but 3HX0xdzN will work
deploy user/repository [branch]
```

and your code will live in this repository. You can just rerun `deploy` to update it from github.
This repository contains additional files to use it as a template when you create your own repository of code.
