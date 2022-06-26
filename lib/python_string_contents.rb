class PythonStringContents
  def initialize(raw)
    @raw = raw
  end

  def to_s
    escape @raw
  end

  private

  def escape(s)
    s.gsub(/['\\]/) { |match| '\\' + match }
  end
end