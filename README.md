# My Nix Config ❄️
This flake contains all of my nix related configurations. I organize my config in a way that fits me, which means I use some more niche language features. Make sure you're comfortable with nix before trying to copy anything!

## Design Philosophies
The reasons why I do and don't use some tools.

### [Synaptic Standard](https://github.com/llakala/synaptic-standard)
The synaptic standard is a good (albeit incomplete) guide on how to make your config more structured. I like a lot of it. However, automatic imports require so much boilerplate that I decided to just manually specify paths for now. I'll definitely change this in the future.

### Package Wrappers
There are lots of ways to configure programs on nix. Here are the main ones:
#### Placing Dotfiles Manually
This is the method I would recommend for most normal users. You just place the configuration where it goes, just like on any other distro.
#### Home-manager
Home manager lets you configure stuff by symlinking their normal config locations to the nix store and providing other configurations such as environment variables, systemd services, etc. It's a very large dependency and does too much IMO.
#### Hjem
Hjem is a *super* simple helper that just symlinks stuff and nothing else. Great if you want to configure stuff declaratively and simply.
#### Wrapers
This is what I went with. Wrappers let you bundle the configuration with the program itself, meaning, instead of running neovim, you run neovim with an environment variable set that moves its configuration directory to the nix store. This is super nice and prevents cluttering your home directory. I use [mnw](https://github.com/Gerg-L/mnw/) and [adios-wrappers](https://github.com/llakala/adios-wrappers) to simplify the process, but you can use other frameworks or the built-in `symlinkJoin.`

## Systems

### Amethyst
This is my main workstation. I do most of my programming, gaming, etc. on here. It has mostly standard desktop stuff & a vm for running FL Studio.
Impermanent squad 💪

### Granite
This is my homelab. Right now it runs a lot of docker stuff 'cause I haven't gotten to changing that yet. Not sure what I'll switch to currently.

### Quartz
This is where it gets interesting. This is a macbook m1 running NixOS with the asahi linux kernel. It was actually extremely easy to install. I did end up wiping it and reinstalling to get more space though; I used to have a lot of leftover stuff on MacOS, so I couldn't get more than the 30GB. It usually lasts thoughout the day on battery despite the fact that I haven't configured any power saving options yet.
