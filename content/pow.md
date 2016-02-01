+++
date = "2016-02-01T18:17:17+08:00"
draft = true
title = "pow"

+++

We redirecting to a service with no port.
Using pow to solve this

http://pow.cx/

http://pow.cx/manual.html

install
```
  curl get.pow.cx | sh
```
link project
```
  cd ~/.pow
  ln -s /path/to/myapp
```
write script for setting ruby env

cd project/.powrc
```
  if [ -f "$rvm_path/scripts/rvm" ]; then
    source "$rvm_path/scripts/rvm"
    rvm 2.1.5
  fi
```

restart app
```
touch tmp/restart.txt
```
