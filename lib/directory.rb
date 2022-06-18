require "fileutils"

class Directory
  def initialize(path)
    @path = path.to_s
  end

  def write(name_content_pairs)
    name_content_pairs.each do |name, content|
      full_path = File.join(@path, name.to_s)
      FileUtils.mkdir_p File.dirname full_path
      File.write full_path, content.to_s
    end
  end
end
