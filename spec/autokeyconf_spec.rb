require "yaml"
require_relative "../lib/generate"
require_relative "../lib/autokey_binding"
require_relative "../lib/autokey_send_keys_script"

describe "generating Autokey config" do
  # input: hash (in the real program, parsed from a yaml file)
  # output: set of written files (a Hash that maps file paths to contents)
  let(:mapping) do
    YAML.load(<<-YAML)
---
Super+w: Alt+F4
YAML
  end

  let(:hotkey_directory) do
    {
      ".Super+w.json" => AutokeyBinding.new(["super"], "w"),
      "Super+w.py" => AutokeySendKeysScript.new(["Alt", "F4"]),
    }
  end

  it "generates a hotkey directory from a hotkey mapping" do
    expect(generate(mapping)).to eq(hotkey_directory)
  end
end
