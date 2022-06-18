require_relative "key"

class AutokeySendKeysScript < Struct.new(:keys)
  def to_s
    chord = keys.map(&Key.method(:new)).join("+")
    "keyboard.send_keys(\"#{chord}\")"
  end
end
