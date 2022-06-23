require "yaml"
require_relative "../lib/generate"
require_relative "../lib/autokey_binding"
require_relative "../lib/autokey_send_keys_script"

describe "generating Autokey config" do
  it "generates a hotkey directory from a hotkey mapping" do
    mapping = YAML.load(<<-YAML)
---
default:
  Super+w: Alt+F4
    YAML
    expect(generate(mapping)).to eq({
      ".super+w.json" => AutokeyBinding.new(["super"], "w"),
      "super+w.py" => AutokeySendKeysScript.new(["alt", "f4"], {}),
    })
  end

  it "generates app-specific keybindings" do
    mapping = YAML.load(<<-YAML)
---
default:
  Super+w: Alt+F4
some-app:
  Super+w: Ctrl+W
        YAML
        expect(generate(mapping)).to eq({
          ".super+w.json" => AutokeyBinding.new(["super"], "w"),
          "super+w.py" => AutokeySendKeysScript.new(["alt", "f4"], {"some-app" => ["ctrl", "w"]}),
        })
  end
end
