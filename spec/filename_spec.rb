require_relative "../lib/filename.rb"

describe Filename do
  it "passes a name with no special characters through unchanged" do
    expect(Filename.new("foo.py").to_s).to eq "foo.py"
  end

  it "replaces slashes" do
    expect(Filename.new("blah/\\.foo").to_s).to eq "blahslashbackslash.foo"
  end
end