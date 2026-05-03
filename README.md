# My Nix Config ❄️
This flake contains all of my nix related configurations. I organize my config in a way that fits me, which means I use some more niche language features. Make sure you're comfortable with nix before trying to copy anything!

## Design Philosophies
The reasons why I do and don't use some tools.

### [Synaptic Standard](https://github.com/llakala/synaptic-standard)
The structure of this flake is heavily inspired by the synaptic standard. I don't follow it exactly, but loosely following it has made my config much more maintanable. The biggest alternative to synaptic, the [dedritic pattern](https://github.com/mightyiam/dendritic), sacrifices a lot of this maintanability (too much in my opinion) in order to make more modular and portable configurations. You should check it out too if that sounds worth it to you.

### [Wrapper Modules](https://github.com/BirdeeHub/nix-wrapper-modules)
There are a lot of options for configuring programs on nix. For starters, you can just configure them like you would on most other distros by just placing the config files in the right location.
But, I constantly switch between mutliple computers, so I would have to pull in dotfiles all the time, and because I already pull in my nix config, it makes more sense for me to pull in my dotfiles along with it.
Nix Wrapper Modules is a tool that makes it easy to 'wrap' a program. Wrapping a program lets you bundle the configuration with the program by setting flags & environment variables, among other things. It also comes with a few pre-built modules which make it easy to configure the programs the modules are built for.

## Systems

### Amethyst
This is my main workstation. I do most of my programming, gaming, etc. on here. It has mostly standard desktop stuff & a vm for running FL Studio.

### Granite
This is my homelab. Right now it runs a lot of docker stuff 'cause I haven't gotten to changing that yet. Not sure what I'll switch to currently.

### Quartz
This is where it gets interesting. This is a macbook m1 running NixOS with the asahi linux kernel. It was actually extremely easy to install. I did end up wiping it and reinstalling to get more space though; I used to have a lot of leftover stuff on MacOS, so I couldn't get more than the 30GB. It usually lasts thoughout the day on battery despite the fact that I haven't configured any power saving options yet.
