# Local Setup

Create a symbolic link to `.ctags`:

```sh
cd ~ && mv .ctags .ctags-backup.bak && ln -s ~/rvconfig/ctags/.ctags .ctags
```

This may also be `~/.ctags.d/main.ctags -> ~/rvconfig/ctags/.ctags`
for Universal Ctags -- this file may be modified later to account for this if
need be.
