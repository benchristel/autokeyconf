require_relative "autokey_binding"
require_relative "autokey_send_keys_script"

class Keymap
  def initialize(config)
    @config = config
      .transform_values { |mapping|
        mapping.transform_keys { |k| Chord.new(k).to_s }
      }
  end

  def input_chords
    chords = Set.new
    @config.each do |app_filter, mapping|
      mapping.each do |input, _|
        chords << Chord.new(input)
      end
    end
    chords
  end

  def app_filters
    @config.keys.reject { |k| k.to_s == "default" }
  end

  def output_for(filter, chord)
    if @config[filter][chord.to_s]
      Chord.new(@config[filter][chord.to_s])
    elsif @config["default"][chord.to_s]
      Chord.new(@config["default"][chord.to_s])
    else
      chord
    end
  end
end

class Chord
  def initialize(string)
    @keys = string.split("+").map(&:downcase)
  end

  def to_s
    @keys.join("+")
  end

  def to_a
    @keys
  end

  def ==(other)
    other.class == Chord && other.keys == @keys
  end

  def modifiers
    @keys[0...-1]
  end

  def hotkey
    @keys[-1]
  end

  protected

  def keys
    @keys
  end
end

def generate(config)
  keymap = Keymap.new(config)
  files_to_write = {}
  keymap.input_chords.each do |chord|
    files_to_write[".#{chord}.json"] =
      AutokeyBinding.new(chord.modifiers, chord.hotkey)

    app_specific_keys = {}
    keymap.app_filters.each do |filter|
      custom_output_for_app = keymap.output_for(filter, chord)
      app_specific_keys[filter] = custom_output_for_app.to_a if custom_output_for_app
    end

    files_to_write["#{chord}.py"] =
      AutokeySendKeysScript.new(keymap.output_for("default", chord).to_a, app_specific_keys)
  end
  files_to_write
end
