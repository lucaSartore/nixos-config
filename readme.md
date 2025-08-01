

### Things to edit manually


Here is a list of things you need to do manually after a configuration.
Those are either things that are too complicated to automate, or are
some sensitive informations that can't be put in the git repo

1) **Add your SSH Key**:
    Remember that there are two primary directory:
     - `~/.ssh`
     - `/root/.ssh`
    Also, remember that the key files should have the permissions set to `rw- --- ---`

2) **Change the repository's upstream**
    You have probably cloned the repo using https, but now you log on with ssh, so you'll need to do:
    ```
    git remote set-url origin git@github.com:lucaSartore/nixos-config.git
    ```
    if you want to be able to push to upstream (or log in using credentials, but this is easyer)

