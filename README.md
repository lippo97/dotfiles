# My dotfiles

Use GNU Stow tool to import.

# Cloning

``` bash
git clone git@github.com:lippo97/dotfiles --recursive
```

## Import a single configuration

```bash
stow <subfolder>
```

## Unlink a single configuration

```bash
stow -D <subfolder>
```

## Import every configuration

```bash
./apply link
```

## Unlink every configuration

```bash
./apply unlink
```
