# Dotfiles

Keep my dotfiles here. For real.

## Usage

1. Clone the Git repository, and navigate to the dir
2. Install dependencies and my everyday soft:
```sh
make install-macos
```
3. Create symlinks for dotfiles via `stow`
```sh
make init
```
4. You also can create a .zshrc.local for your local envs and secrets
```sh
make init-local

# OR like this, equivalent to run init and init-local for the same time
make
```

Use help command if you need:
```sh
make help
```

