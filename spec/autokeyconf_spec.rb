require "yaml"

describe "generating Autokey config" do
  # input: hash (in the real program, parsed from a yaml file)
  # output: set of written files (a Hash that maps file paths to contents)
  let(:mapping) do
    YAML.parse(<<-YAML)
global:
  Super+W: Alt+F4
YAML
  end

  let(:hotkey_directory) do
    {
      "global/.Alt+F4.json": AutokeyBinding.new(["<super>"], "w"),
      "global/Alt+F4.py": AutokeySendKeysScript.new("Alt+F4"),
    }
  end

  it "generates a hotkey directory from a hotkey mapping" do
    expect(generate(mapping)).to eq(hotkey_directory)
  end
end

def generate(mapping)
  {
    "global/.Alt+F4.json": AutokeyBinding.new(["<super>"], "w"),
    "global/Alt+F4.py": AutokeySendKeysScript.new("Alt+F4"),
  }
end

class AutokeyBinding < Struct.new(:modifiers, :hotkey)
end

class AutokeySendKeysScript < Struct.new(:chord)
end