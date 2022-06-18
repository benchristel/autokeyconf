require_relative "../lib/directory"
require "fileutils"

describe Directory do
  let(:test_dir) { "/tmp/autokeyconf-test" }
  let(:subject) { Directory.new(test_dir) }
  before :each do
    FileUtils.rm_rf test_dir
  end

  it "writes nothing to disk given no name-value pairs" do
    subject.write({})
    expect(File.exist? test_dir).to be false
  end

  it "writes a file to the given directory" do
    subject.write({
      "the-file.txt" => "Look Ma, I'm in a file!"
    })
    expect(File.read "#{test_dir}/the-file.txt")
      .to eq "Look Ma, I'm in a file!"
  end

  it "writes multiple files" do
    subject.write({
      "file-1" => "contents 1",
      "file-2" => "contents 2",
    })
    expect(File.read "#{test_dir}/file-1").to eq "contents 1"
    expect(File.read "#{test_dir}/file-2").to eq "contents 2"
  end

  it "creates parent directories" do
    subject.write({
      "foo/bar/file.txt" => "wow"
    })
    expect(File.read "#{test_dir}/foo/bar/file.txt").to eq "wow"
  end
end
