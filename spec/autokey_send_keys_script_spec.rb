require_relative "../lib/autokey_send_keys_script"

describe AutokeySendKeysScript do
  it "generates a script that does nothing given no keys" do
    # Gavin and I checked on May 28, 2022 that send_keys accepts an empty string
    # without raising
    expect(AutokeySendKeysScript.new([], {}).to_s)
      .to eq(<<EOF.chomp)
import re
if False:
  pass
else:
  keyboard.send_keys('')
EOF
  end

  it "renders a chord with specially named keys" do
    expect(AutokeySendKeysScript.new(["alt", "delete"], {}).to_s)
      .to eq(<<EOF.chomp)
import re
if False:
  pass
else:
  keyboard.send_keys('<alt>+<delete>')
EOF
  end

  it "differentiates between normal and special" do
    expect(AutokeySendKeysScript.new(["super", "f"], {}).to_s)
      .to eq(<<EOF.chomp)
import re
if False:
  pass
else:
  keyboard.send_keys('<super>+f')
EOF
  end

  it "downcases key names" do
    expect(AutokeySendKeysScript.new(["Super", "F"], {}).to_s)
      .to eq(<<EOF.chomp)
import re
if False:
  pass
else:
  keyboard.send_keys('<super>+f')
EOF
  end

  it "special-cases applications" do
    script = AutokeySendKeysScript.new(
      ["ctrl", "f"],
      {"Terminal" => ["ctrl", "shift", "f"]}
    ).to_s
    expect(script).to eq(<<EOF.chomp)
import re
if False:
  pass
elif re.compile('Terminal').search(window.get_active_class()):
  keyboard.send_keys('<ctrl>+<shift>+f')
else:
  keyboard.send_keys('<ctrl>+f')
EOF
  end

  it "avoids duplicate conditionals" do
    script = AutokeySendKeysScript.new(
      ["ctrl", "f"],
      {"Terminal" => ["ctrl", "f"]}
    ).to_s
    expect(script).to eq(<<EOF.chomp)
import re
if False:
  pass
else:
  keyboard.send_keys('<ctrl>+f')
EOF
  end
end
