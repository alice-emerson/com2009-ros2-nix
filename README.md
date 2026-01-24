# COM2009 Development Environment

## Setup

With `nix develop`:

```sh
nix develop 'github:alice-emerson/com2009-ros2-nix'
```

In a `.envrc` with [nix-direnv](https://github.com/nix-community/nix-direnv):

```sh
use flake 'github:alice-emerson/com2009-ros2-nix'
```

## Binary Cache

Without any additional setup, everything should be successfully built from
 source, but this will take some time. 
 [nix-ros-overlay](https://github.com/lopsided98/nix-ros-overlay/tree/master)
 maintains a binary cache, see the instructions in their README for details.