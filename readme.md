# My Nix Config ❄️
This flake contains all of my configs for nixos. It aims to be as modular as possible while still following the below philosophies. Unfortunately, this means that it isn't actually very modular, but hopefully looking at it can help you decide what to do in your config!

## Design Philosophies
The reasons why I do and don't use some tools.

### [Synaptic Standard](https://github.com/llakala/synaptic-standard)
The structure of this flake is heavily inspired by the synaptic standard. It doesn't follow it exactly, but loosely following the standard has made my config much more maintanable. The biggest alternative to synaptic, the [dedritic pattern](https://github.com/mightyiam/dendritic), sacrifices a lot of this maintanability (too much in my opinion) in order to make more modular and portable configurations. You should check it out too if that sounds worth it to you.
