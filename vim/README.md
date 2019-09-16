# Local Setup

Right now, I use a plugin-heavy NeoVim setup, and leave vim configuration quite
light. For now, refer to the nvim-vim-shared readme file.

Optionally, a large but fast syntax plugin can be installed. To use it, init
the git submodule via:

```sh
cd ~/rvconfig && git submodule init && git submodule update
```

And then symlink the vim plugins folder:

```sh
cd ~/.vim && mv pack pack-backup && ln -s ~/rvconfig/vim/vim-light/pack pack
```

Optional colors can also be symlinked to this folder

```sh
cd ~/.vim && mv colors colors-backup && ln -s ~/rvconfig/vim/vim-light/colors colors
```
