require_relative "../lib/autokey_send_keys_script"

describe AutokeySendKeysScript do
  it "generates a script that does nothing given no keys" do
    # Gavin and I checked on May 28, 2022 that send_keys accepts an empty string
    # without raising
    expect(AutokeySendKeysScript.new([]).to_s)
      .to eq('keyboard.send_keys("")')
  end

  it "renders a chord with specially named keys" do
    expect(AutokeySendKeysScript.new(["alt", "delete"]).to_s)
      .to eq('keyboard.send_keys("<alt>+<delete>")')
  end

  it "differentiates between normal and special" do
    expect(AutokeySendKeysScript.new(["super", "f"]).to_s)
      .to eq('keyboard.send_keys("<super>+f")')
  end
end