require "set"

class Key < Struct.new(:name)
  def to_s
    if name.length > 1
      "<#{name}>"
    else
      name
    end
  end

  def name
    super.downcase
  end
end
