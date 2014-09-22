# Ghost-deploy

Ghost-deploy is a shell script to make the latest
[Ghost](https://ghost.org/) blog flying on nginx. It basically wraps the
instructions from [Ghost Linux
Installation](http://docs.ghost.org/installation/linux/) and [Ghost
deploy](http://docs.ghost.org/installation/deploy/) in a script. That means Ghost is served via nginx which forwards connections to node.js. Node.js is started through an init.d script.  


```bash
$ git clone https://github.com/jakobadam/ghost-deploy.git
$ cd ghost-deploy
$ sudo ./install.sh
```

Point browser to http://serverip

Additional tasks:

Set domain:
```bash
$ sudo ./set-domain.sh blog.example.com
```

Add disqus:
```bash
$ sudo ./add-disqus.sh disqus_name
```

Add google analytics:
```bash
$ sudo ./add-ga.sh UA-XXXX-X
```

Tested on:
* Ubuntu 14.04 Server

## Test with vagrant

**Note:** The box in the vagrant file is a vagrant-kvm box

```bash
$ vagrant up --provider=kvm
$ vagrant ssh ubuntu
$ cd /vagrant
$ ./install.sh
```

Point browser to http://localhost:8080
