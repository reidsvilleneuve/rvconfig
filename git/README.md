# Local Setup

## gitconfig

Create `~/.gitconfig` and use `[include]` to reference `gitconfig`. Overwrite
values under it:

```sh
[include]
	path = ~/rvconfig/git/gitconfig
[user]
	name = Reid Villeneuve
	email = reidvilleneuve@someclient.com
```

## gitignore

Create a symbolic link to `gitignore`:

```sh
cd ~ && mv .gitignore .gitignore-backup.bak && ln -s ~/rvconfig/git/gitignore .gitignore
```
