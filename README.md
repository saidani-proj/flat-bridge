# flat-bridge

**flat-bridge** is a Bash script that generates a wrapper script to run a Flatpak package via `flatpak run`.

## Usage

```bash
flat-bridge [options] <name>
```

### Options

| Option              | Description                                                |
|---------------------|------------------------------------------------------------|
| `--user`            | Install bridge in `~/.local/bin` (default)                 |
| `--system`          | Install bridge in `/usr/local/bin`                         |
| `-d, --bin-dir`     | Custom binary directory (overrides `--user`/`--system`)    |
| `-n, --name`        | Name of the bridge script (create mode only, default: package name) |
| `-r, --remove`      | Remove the bridge script (argument is the bridge name)     |
| `-h, --help`        | Show this help message                                     |

### Examples

```bash
# --- Create bridges ---

# Default: bridge name = package name, installed in ~/.local/bin
flat-bridge org.gimp.GIMP

# Custom bridge name
flat-bridge -n gimp org.gimp.GIMP

# System-wide install in /usr/local/bin
flat-bridge --system org.gimp.GIMP

# Custom bridge name in /usr/local/bin
flat-bridge --system -n gimp org.gimp.GIMP

# Custom directory
flat-bridge -d ~/my-binaries org.gimp.GIMP

# Custom name + custom directory
flat-bridge -n gimp -d ~/my-binaries org.gimp.GIMP

# --- Remove bridges (argument = bridge name, not package) ---

# Remove by default name (package name)
flat-bridge -r org.gimp.GIMP             # removes ~/.local/bin/org.gimp.GIMP

# Remove by custom name
flat-bridge -r gimp                      # removes ~/.local/bin/gimp

# Remove from /usr/local/bin
flat-bridge -r --system gimp             # removes /usr/local/bin/gimp

# Remove from custom directory
flat-bridge -r -d ~/my-binaries gimp     # removes ~/my-binaries/gimp

# Forward arguments to the Flatpak app
flat-bridge org.gimp.GIMP
gimp --new-instance ~/image.png

# Pass Flatpak options (before --) and app arguments (after --)
gimp --branch=stable -- --verbose
```

The generated bridge forwards all arguments to `flatpak run`. Use `--` to separate Flatpak options from app arguments.

## Tests

```bash
bash tests/run.sh
```

Tests are organized by category in `tests/`. Each `test_*.sh` file is independently executable.

## License

MIT
