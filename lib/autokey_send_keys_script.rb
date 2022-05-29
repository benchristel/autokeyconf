require "set"

SpecialKeys = Set.new([
  "super",
  "alt",
  "delete"
])

class Key < Struct.new(:name)
  def to_s
    if SpecialKeys.include? name
      "<#{name}>"
    else
      name
    end
  end
end

class AutokeySendKeysScript < Struct.new(:keys)
  def to_s
    chord = keys.map(&Key.method(:new)).join("+")
    "keyboard.send_keys(\"#{chord}\")"
  end
end
