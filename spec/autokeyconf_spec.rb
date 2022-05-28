require "yaml"
require 'json'

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
      "global/.Alt+F4.json": AutokeyBinding.new(["super"], "w"),
      "global/Alt+F4.py": AutokeySendKeysScript.new("Alt+F4"),
    }
  end

  it "generates a hotkey directory from a hotkey mapping" do
    expect(generate(mapping)).to eq(hotkey_directory)
  end
end

def generate(mapping)
  {
    "global/.Alt+F4.json": AutokeyBinding.new(["super"], "w"),
    "global/Alt+F4.py": AutokeySendKeysScript.new("Alt+F4"),
  }
end

class AutokeyBinding < Struct.new(:modifiers, :hotkey)
  def to_s
    JSON.pretty_generate({
      usageCount: 0,
      omitTrigger: false,
      prompt: false,
      abbreviation: {
        wordChars: "[\\w]",
        abbreviations: [],
        immediate: false,
        ignoreCase: false,
        backspace: true,
        triggerInside: false
      },
      hotkey: {
        hotKey: hotkey,
        modifiers: modifiers.map {|m| "<#{m}>"},
      },
      modes: [
        3
      ],
      showInTrayMenu: false,
      filter: {
        regex: nil,
        isRecursive: false
      },
      type: "script",
      store: {},
      description: [*modifiers, hotkey].join("+")
    })
  end
end

class AutokeySendKeysScript < Struct.new(:chord)
end

describe AutokeyBinding do
  describe :to_s do
    it "renders JSON" do
      expect(AutokeyBinding.new(["foo"], "bar").to_s).to eq(<<-JSON.chomp)
{
  "usageCount": 0,
  "omitTrigger": false,
  "prompt": false,
  "abbreviation": {
    "wordChars": "[\\\\w]",
    "abbreviations": [

    ],
    "immediate": false,
    "ignoreCase": false,
    "backspace": true,
    "triggerInside": false
  },
  "hotkey": {
    "hotKey": "bar",
    "modifiers": [
      "<foo>"
    ]
  },
  "modes": [
    3
  ],
  "showInTrayMenu": false,
  "filter": {
    "regex": null,
    "isRecursive": false
  },
  "type": "script",
  "store": {
  },
  "description": "foo+bar"
}
      JSON
    end
  end
end
