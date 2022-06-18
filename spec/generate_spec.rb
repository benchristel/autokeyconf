describe "generate" do
  it "generates no files given empty config" do
    expect(generate({})).to eq({})
  end
end
