require_relative "key"

class AutokeySendKeysScript < Struct.new(:default_keys, :app_specific_keys)
  def to_s
    chord = default_keys.map(&Key.method(:new)).join("+")
    python = "import re\n"
    python << "if False:\n"
    python << "  pass\n"
    app_specific_keys
      .reject { |_, chord| chord == default_keys }
      .each do |filter, chord|
        python << "elif re.compile('#{filter}').search(window.get_active_class()):\n"
        python << "  keyboard.send_keys('#{chord.map(&Key.method(:new)).join("+")}')\n"
      end
    python << "else:\n"
    python << "  keyboard.send_keys('#{chord}')"
    python
  end
end
