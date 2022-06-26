require_relative "key"
require_relative "python_string_contents"

class AutokeySendKeysScript < Struct.new(:default_keys, :app_specific_keys)
  def to_s
    python = "import re\n"
    python << "if False:\n"
    python << "  pass\n"
    app_specific_keys
      .reject { |_, chord| chord == default_keys }
      .each do |filter, chord|
        python << "elif re.compile('#{filter}').search(window.get_active_class()):\n"
        python << "  keyboard.send_keys('#{send_keys_str chord}')\n"
      end
    python << "else:\n"
    python << "  keyboard.send_keys('#{send_keys_str default_keys}')"
    python
  end

  private

  def send_keys_str(keys)
    PythonStringContents.new keys.map(&Key.method(:new)).join("+")
  end

  def python_string_escape(s)
    s.gsub("'", "\\'")
  end
end
