class AutokeyBinding < Struct.new(:modifiers, :hotkey)
    def to_s
      JSON.pretty_generate({
        usageCount: 0,
        omitTrigger: false,
        prompt: false,
        abbreviation: {
          wordChars: "[\\w]",
          abbreviations: [],
          immediate: false,
          ignoreCase: false,
          backspace: true,
          triggerInside: false
        },
        hotkey: {
          hotKey: hotkey,
          modifiers: modifiers.map {|m| "<#{m}>"},
        },
        modes: [
          3
        ],
        showInTrayMenu: false,
        filter: {
          regex: nil,
          isRecursive: false
        },
        type: "script",
        store: {},
        description: [*modifiers, hotkey].join("+")
      })
    end
  end
  