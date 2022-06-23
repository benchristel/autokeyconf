require_relative "../lib/generate"

describe Keymap do
  it "falls back to the default if there's no app-specific binding" do
    keymap = Keymap.new({
      "default" => {"Super+J" => "Ctrl+J"},
      "Firefox" => {},
    })
    
    expect(keymap.output_for("Firefox", Chord.new("Super+J")))
      .to eq Chord.new("Ctrl+J")
  end

  it "falls back to passing the keypress through if there's no default defined" do
    keymap = Keymap.new({
      "default" => {},
      "Firefox" => {"Super+J" => "Ctrl+J"},
    })
    
    expect(keymap.output_for("default", Chord.new("Super+J")))
      .to eq Chord.new("Super+J")
  end
end
