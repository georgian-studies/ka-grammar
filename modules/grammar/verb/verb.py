def generate_conjugation(entry):
    root = entry.get("root", "")
    preverb = entry.get("preverb", "")
    versioner = entry.get("versioner", "")
    thematic_suffix = entry.get("thematic_suffix", "")

    def form(prefix, r, suffix=""):
        return prefix + versioner + r + thematic_suffix + suffix

    return {
        "present_indicative": {
            "I": {"singular": form("ვ", root), "plural": form("ვ", root, "თ")},
            "II": {"singular": form("", root), "plural": form("", root, "თ")},
            "III": {"singular": form("", root, "ს"), "plural": form("", root, "ენ")},
        },
        "aorist_indicative": {
            "I": {"singular": form(preverb + "ვ", root, "ე"), "plural": form(preverb + "ვ", root, "ეთ")},
            "II": {"singular": form(preverb, root, "ე"), "plural": form(preverb, root, "ეთ")},
            "III": {"singular": form(preverb, root, "ა"), "plural": form(preverb, root, "ეს")},
        },
        "imperative": {
            "I": {"singular": "—", "plural": form(preverb + "ვ", root, "ოთ")},
            "II": {"singular": form(preverb, root, "ე"), "plural": form(preverb, root, "ეთ")},
            "III": {"singular": "—", "plural": "—"},
        },
    }
