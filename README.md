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
    myrepos
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
