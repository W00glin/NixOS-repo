# My NixOS config
So I finally took the plunge. After awhile of hearing about this "hip" and "new" and "cool" declarative OS called NixOS, I finally decided to take the NixOS pill. I grabbed an old laptop. Nabbed the [NixOS installer w/GNOME](https://channels.nixos.org/nixos-24.05/latest-nixos-gnome-x86_64-linux.iso) from the site and gave it a spin.

![dogshite meme](./assets/bottom_tier_meme.jpgbottom_tier_meme.jpg)

What started off as a fairly harmless pilot exercise has turned into what some would call an obsession. Its pretty incredible what the distro can do. I absolutely think I can replace NixOS with all of my ansible playbooks now.

# This repo
So this repo will serve as the location of my current NixOS config and "roadmap" of things I would like to learn or otherwise configure for my NixOS machines. This repo was setup with help and guidance from `Enron5` on the NixOS community forums - [thread](https://discourse.nixos.org/t/using-git-to-handle-and-manage-configuration-nix/38337/4)

In short - 
```
Here are the steps I used (for my future reference and to help any else out there who may be as curious as I was when I started this thread):

    Move /etc/nixos/configuration.nix to the locally cloned GitHub repo in the user’s home directory.
        If you run $ ls -la then you’ll notice the owner and group permission for this file is still set to root.

    To resolve this, change ownership. In my case in my VBox demo appliance, the user is demo and the group is users. Here is the required command: $ sudo chown demo:users configuration.nix. In prod when I make the leap-of-faith and commit to migrating from my native Manjaro installation to NixOS, the user name will not be ‘demo’. So change accordingly.
        This is also required: $ chmod +w configuration.nix

    In /etc/nixos/, run:

    $ sudo ln -s ~/<your-github-repo-name>/configuration.nix .

    To emphasize: take note of the trailing “.” at the end.
    Additional point of clarification: The recommended command #3 here will only work inside /etc/nixos/ as working directory. If you try to complete the symbolic link by invoking the ln -s command from within the repo directory, it won’t work. So be careful with this too
```

### To-do

- [ ] Declarative config for setting up and using Docker/Podman
- [ ] Declarative config set the icon/theme
- [ ] Declarative config to set the background
- [ ] Investigate/use flakes
- [ ] Investigate/use home-manager
- [ ] Research and implement best practice for managing NixOS config
- [ ] Replace existing ansible playbooks w/NixOS configs

Like this? Cool. Take it, us it, enjoy it. 
