# Test cases — flat-bridge

```
tests/
├── help
│   ├── --help
│   └── -h
│
├── errors
│   ├── no argument
│   ├── unknown option
│   ├── --name without argument
│   ├── -d without argument
│   └── multiple packages
│
├── install mode
│   ├── --user
│   ├── --system
│   ├── default (user mode)
│   └── --user --system (last wins)
│
├── custom binary directory
│   ├── -d <path>
│   └── --bin-dir <path>
│
├── bridge name
│   ├── -n <name>
│   └── --name <name>
│
├── combinations
│   ├── -n + -d
│   └── -d + -n
│
├── remove mode
│   ├── -r
│   ├── --remove
│   ├── -r -n (named bridge)
│   ├── -r --system
│   ├── -r on missing bridge
│   └── -r on locked directory → permission denied
│
└── generated bridge verification
    ├── content: flatpak run <pkg> "$@"
    ├── executable permissions
    ├── argument forwarding: bridge passes $@ to flatpak run
    └── -- separator: opts before --, app args after --
```
