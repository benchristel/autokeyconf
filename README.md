# autokeyconf

## Examples

You can use YAML anchors and merges to implement defaults or any other inheritance scheme.

```yaml
defaults: &defaults
  Super+W: Alt+F4
  Super+C: Ctrl+C

".*Firefox.*":
  <<: *defaults
  Super+W: Ctrl+W

".*Gnome-terminal.*":
  <<: *defaults
  Super+C: Ctrl+Shift+C
```

## Command Line Usage

```bash
./autokeyconf /path/to/mappings.yaml
```

