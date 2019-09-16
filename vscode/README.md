# Local Setup

Create a symbolic link to `settings.json`. See
https://vscode.readthedocs.io/en/latest/getstarted/settings/#settings-file-locations
for the location of this file. OSX example:

```sh
cd ~/Library/Application Support/Code/User && mv .settings.json settings.json-backup.bak && ln -s ~/rvconfig/vscode/settings.json settings.json
```

