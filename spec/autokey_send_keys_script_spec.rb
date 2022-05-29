require_relative "../lib/autokey_send_keys_script"

describe AutokeySendKeysScript do
  it "renders python" do
    expect(AutokeySendKeysScript.new("<alt>+<delete>").to_s)
      .to eq('keyboard.send_keys("<alt>+<delete>")')
  end
end