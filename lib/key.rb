require "set"

SpecialKeys = Set.new([
  "alt",
  "backspace",
  "ctrl",
  "delete",
  "down",
  "end",
  "home",
  "left",
  "meta",
  "right",
  "shift",
  "super",
  "up",
  *(1..35).map { |n| "f#{n}" },
])

class Key < Struct.new(:name)
  def to_s
    if SpecialKeys.include? name
      "<#{name}>"
    else
      name
    end
  end

  def name
    super.downcase
  end
end
