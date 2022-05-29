def generate(mapping)
    {
      "global/.Alt+F4.json": AutokeyBinding.new(["super"], "w"),
      "global/Alt+F4.py": AutokeySendKeysScript.new("Alt+F4"),
    }
  end