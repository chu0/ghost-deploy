# Ghost-deploy

Ghost-deploy is a shell script to make the latest
[Ghost](https://ghost.org/) flying on nginx. It basically wraps the
instructions from [Ghost Linux
Installation](http://docs.ghost.org/installation/linux/) and [Ghost
deploy](http://docs.ghost.org/installation/deploy/) in a script.

```bash
$ git clone https://github.com/jakobadam/ghost-deploy.git
$ sudo ./install.sh
```

Ghost is served via nginx on localhost.

Tested on:
* Ubuntu 14.04 Server

## Test with vagrant

```bash
$ vagrant up
$ vagrant ssh
$ cd /vagrant
$ sudo ./install.sh
```

Point browser to http://localhost:8080
