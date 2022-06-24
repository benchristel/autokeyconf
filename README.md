# autokeyconf

[AutoKey](https://github.com/autokey/autokey) is a Linux application that can
remap keyboard shortcuts, or even bind them to Python scripts. `autokeyconf`
automates the process of setting up a basic shortcut remapping (useful since
AutoKey itself only provides a GUI, which makes it tedious to configure if you
have a lot of shortcuts).

## Configuration Format

`autokeyconf` uses a YAML configuration format. Here is an example:

```yaml
default:
  Super+W: Alt+F4
  Super+C: Ctrl+C

firefox:
  Super+W: Ctrl+W

Gnome-terminal:
  Super+C: Ctrl+Shift+C
```

The top-level keys of the config (e.g. `firefox` and `Gnome-terminal`) are
application filters, which restrict the keybindings under them to a specific
app or set of apps. They're interpreted as regular expressions, and matched
against the window class of the active window. The `default` key is special
and defines a global set of keybindings that apply when no filter matches,
or when the matching filter doesn't configure an app-specific keybinding for
the given keypress.

The keybindings are written as `Input: Output`: the stuff on the left is the
keys you press, and the stuff on the right is the keys the application sees.

Key names are case-insensitive, so `ctrl+w` is the same as `Ctrl+W` and
`CTRL+W`.

The full list of key names (cribbed from AutoKey's source code) is:

```
LEFT
RIGHT
UP
DOWN
BACKSPACE
TAB
ENTER
SCROLL_LOCK
PRINT_SCREEN
PAUSE
MENU

CONTROL
ALT
ALT_GR
SHIFT
SUPER
HYPER
CAPSLOCK
NUMLOCK
META

F1..F35

ESCAPE
INSERT
DELETE
HOME
END
PAGE_UP
PAGE_DOWN

# Numpad
NP_INSERT
NP_DELETE
NP_HOME
NP_END
NP_PAGE_UP
NP_PAGE_DOWN
NP_LEFT
NP_RIGHT
NP_UP
NP_DOWN
NP_DIVIDE
NP_MULTIPLY
NP_ADD
NP_SUBTRACT
NP_5
```

For more examples, see `example_config.yaml`, which provides macOS-style
keyboard shortcuts.

## Command Line Usage

```bash
./autokeyconf example_config.yaml
```
