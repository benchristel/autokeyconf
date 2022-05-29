require_relative "../lib/autokey_binding.rb"

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
