class Filename
  def initialize(raw)
    @raw = raw
  end

  def to_s
    @raw.gsub(/[\/\\]/) { |match| replacement[match] }
  end

  def replacement
    {"\\" => "backslash", "/" => "slash"}
  end
end