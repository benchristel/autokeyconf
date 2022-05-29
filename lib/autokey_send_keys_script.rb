class AutokeySendKeysScript < Struct.new(:chord)
  def to_s
    "keyboard.send_keys(\"#{chord}\")"
  end
end
