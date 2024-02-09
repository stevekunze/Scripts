
> [!Note]
> Note that the "hsb" is needs to be defined in the .ssh/config file.

> [!CAUTION]
> You have to exclude the "/" at the start when specifing the path and username with .ssh/config file.
> If you do so, you will encounter the following error:
> Fatal: unable to open config file: Lstat: file does not exist Is there a repository at the following location?
> example with .ssh/config file:
> restic -r sftp:connectionname_in.ssh/config_file:restic-repo --password-file path/to/password/file backup /path/to/data/
> Example without .ssh/config
> restic -r sftp://user1234-sub1@example.your-storagebox.de:/restic-repo --verbose --password-file path/to/password/file backup /path/to/data/
> Here is the reason why that is (thanks to MichaelEischer from restic forums)
> Using the URL syntax, the separator between server and directory is the /. The colon is used to separate server name and port. For example sftp://host:10022//dir/subdir would connect to host:10022 and access /dir/subdir (notice the double slash!)
