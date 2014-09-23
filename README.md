# rake-compiler-dev-box

A virtual machine for using rake-compiler.

[rake-compiler](https://github.com/luislavena/rake-compiler) is **totally awesome**, and you should be using it if you maintain a Ruby gem with C or Java extensions to build native binaries for your users.

_However_, getting your local environment set up to build for all the assorted platforms can be a pain.  Thankfully, we have the amazing tool [Vagrant](http://www.vagrantup.com) for "lightweight, reproducible, and portable development environments."

rake-compiler + Vagrant = easy native gems for all.

## Dependencies

* [Vagrant](http://www.vagrantup.com)
* A supported [Vagrant provider](https://docs.vagrantup.com/v2/providers/index.html) — [VirtualBox](https://docs.vagrantup.com/v2/virtualbox/index.html), [Hyper-V](https://docs.vagrantup.com/v2/hyperv/index.html), and [VMware Fusion](https://docs.vagrantup.com/v2/vmware/index.html) should all work.

## How to Build the Virtual Machine

Easy-peasy:

    $ git clone https://github.com/tjschuck/rake-compiler-dev-box.git
    $ cd rake-compiler-dev-box
    $ vagrant up

That's it!  Go grab a cup of coffee, though -- it can take a couple of minutes to build the first time.

## Building Your Native Gems

Once you have your gem ready to package, clone or move your repo into the same directory as the rake-compiler-dev-box:

    $ pwd
    /Users/tjschuck/Code/rake-compiler-dev-box
    $ git clone git@github.com:codahale/bcrypt-ruby.git
    Cloning into 'bcrypt-ruby'...
    [...], done.

Now fire up your virtual machine (if you haven't already):

    $ vagrant up

And SSH in:

    $ vagrant ssh

You'll now be inside the virtual machine.  The directory on your host machine with your gem in it and the scripts to build it will be mounted at `/vagrant`:

    vagrant@precise64:~$ cd /vagrant
    vagrant@precise64:/vagrant$ ls
    bcrypt-ruby  bin  bootstrap.sh  LICENSE.txt  README.md  sample_gem  Vagrantfile

To build all gem binaries (native, Java, and Windows versions), run:

    vagrant@precise64:/vagrant$ package_all YOUR_GEM'S_DIR_NAME

And wait for everything to build.  Replace `YOUR_GEM'S_DIR_NAME` with the correct value -- above, it would be `bcrypt-ruby`. There's a `sample_gem` dir in there as well if you'd like to experiment.

All of your gem binaries will be put into `pkg`:

    vagrant@precise64:/vagrant$ ls bcrypt-ruby/pkg/
    bcrypt-ruby-3.1.0            bcrypt-ruby-3.1.0-x86-linux.gem
    bcrypt-ruby-3.1.0.gem        bcrypt-ruby-3.1.0-x86-mingw32
    bcrypt-ruby-3.1.0-java       bcrypt-ruby-3.1.0-x86-mingw32.gem
    bcrypt-ruby-3.1.0-java.gem   bcrypt-ruby-3.1.0-x86-mswin32-60
    bcrypt-ruby-3.1.0-x86-linux  bcrypt-ruby-3.1.0-x86-mswin32-60.gem

Happy compiling!

### Limiting Target Rubies

Some gems might choose not to support older versions of Ruby (like [Nokogiri](http://nokogiri.org), which no longer supports 1.8).

If you wish to limit the versions of Ruby that your cross-compiled Windows binaries supports, you can use the environment variables `BASE_VERSION` and `RUBY_CC_VERSION`:

* `BASE_VERSION`: the native version of Ruby that will be used as a base for cross-compilation

* `RUBY_CC_VERSION`: a colon-separated list of target versions for cross-compilation

_Note: If you wish to target 1.8.x, your base version must be 1.8.x -- versions 1.9+ cannot cross-build 1.8._

#### Examples:

Use Ruby 1.9.3 to cross-compile a fat binary that includes 1.9 and 2.0 binaries:

    vagrant@precise64:/vagrant$ BASE_VERSION=1.9.3 RUBY_CC_VERSION=1.9.3:2.0.0 package_all nokogiri

Use Ruby 2.0.0 to cross-compile a fat binary that includes 2.0 and 2.1 binaries:

    vagrant@precise64:/vagrant$ BASE_VERSION=2.0.0 RUBY_CC_VERSION=2.0.0:2.1.3 package_all nokogiri

By default, with no environment variables, rake-compiler-dev-box will try to cross-compile for all available versions, using 1.8 as a base.

## VM Management

Log out of the virtual machine (`exit` or `^D`).

To shut down the virtual machine:

    $ vagrant halt

To start it up again:

    $ vagrant up

To completely remove the VM, clearing it from disk and destroying all contents:

    $ vagrant destroy

To reinstantiate it for future compiling, it can be recreated with:

    $ vagrant up

See the [Vagrant docs](http://docs.vagrantup.com/) for more info.

## :heart: :heart: :heart:

* [Luis Lavena](https://github.com/luislavena) for [rake-compiler](https://github.com/luislavena/rake-compiler)
* [rails-dev-box](https://github.com/rails/rails-dev-box) for the inspiration
* [Harvest](http://www.getharvest.com), my awesome employer.  [We're hiring](http://www.getharvest.com/careers)!
