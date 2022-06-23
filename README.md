# autokeyconf

[AutoKey](https://github.com/autokey/autokey) is a Linux application that can
remap keyboard shortcuts, or even bind them to Python scripts.  `autokeyconf`
automates the process of setting up a basic shortcut remapping (useful since
AutoKey itself only provides a GUI, which makes it tedious to configure if you
have a lot of shortcuts).

## Examples

```yaml
default:
  Super+W: Alt+F4
  Super+C: Ctrl+C

firefox:
  Super+W: Ctrl+W

Gnome-terminal:
  Super+C: Ctrl+Shift+C
```

See also `example_config.yaml`, which provides macOS-style keyboard shortcuts.

## Command Line Usage

```bash
./autokeyconf example_config.yaml
```

