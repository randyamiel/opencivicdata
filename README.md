opencivicdata
=============

This is a development meta-repo, used to just get all of the OCD tools
in one single place, and update them all together.

First, install the `mr` tool. On Debian-like distributions, all you'll need
is to install a few tools:

```
sudo apt update
sudo apt install \
    git \
    make \
    myrepos \
    ansible \
    virtualbox \
    vagrant \
    libxml2-dev \
    libxslt1-dev
```

On OSX, using [Homebrew](http://brew.sh):

```
brew update
brew install git myrepos
```

Now, to pull down the repos:

```
make
```

You should have fresh and up to date checkouts in `repos/`.

Enter your virtualenv and run:

```
./scripts/setup-development.sh
```

And, if you need Ansible stuff:

```
cd repos
../scripts/ocd-dev.sh
```
