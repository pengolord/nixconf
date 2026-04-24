# My Nix Config ❄️
This flake contains all of my configs for nixos. It aims to be as modular as possible while still following the below philosophies. Unfortunately, this means that it isn't actually very modular, but hopefully looking at it can help you decide what to do in your config!

## Design Philosophies
The reasons why I do and don't use some tools.

### [Synaptic Standard](https://github.com/llakala/synaptic-standard)
The structure of this flake is heavily inspired by the synaptic standard. It doesn't follow it exactly, but loosely following the standard has made my config much more maintanable. The biggest alternative to synaptic, the [dedritic pattern](https://github.com/mightyiam/dendritic), sacrifices a lot of this maintanability (too much in my opinion) in order to make more modular and portable configurations. You should check it out too if that sounds worth it to you.

### [Wrapper Modules](https://github.com/BirdeeHub/nix-wrapper-modules)
There are a lot of options for configuring programs on nix. For starters, you can just configure them like you would on most other distros by just placing the config files in the right location.
However, I constantly switch between mutliple computers, so I would have to repeatedly pull in dotfiles. Because I already pull in my nix config, it makes more sense for me to pull in my dotfiles with it as well.
Nix Wrapper Modules is a tool that makes it easy to 'wrap' a program. Wrapping a program lets you bundle the configuration with the program by setting flags & environment variables, among other this. It also comes with a few pre-built modules which make it easy to configure the programs the modules are built for.
