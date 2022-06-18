require_relative "autokey_binding"
require_relative "autokey_send_keys_script"

def generate(mapping)
  files_to_write = {}
  mapping.to_h.each do |keys_pressed, keys_sent|
    keys = keys_pressed.to_s.split("+").map(&:downcase)
    modifiers = keys[0...-1]
    non_modifier = keys[-1]
    files_to_write[".#{keys_pressed}.json"] = AutokeyBinding.new(modifiers, non_modifier)
    files_to_write["#{keys_pressed}.py"] = AutokeySendKeysScript.new(keys_sent.to_s.split("+"))
  end
  files_to_write
end
