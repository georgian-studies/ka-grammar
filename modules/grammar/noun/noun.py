def generate_singular(root, kum_root=None):
    if kum_root is None:
        kum_root = root
    if root.endswith("ა"):
        stem = root[:-1]
        return {
            "nominative": root,
            "ergative": root + "მ",
            "dative": root + "ს",
            "genitive": kum_root + "ის",
            "instrumental": kum_root + "ით",
            "adverbial": kum_root + "ად",
            "vocative": stem + "ავ",
        }
    if root.endswith("ე"):
        return {
            "nominative": root,
            "ergative": root + "მ",
            "dative": root + "ს",
            "genitive": kum_root + "ის",
            "instrumental": kum_root + "ით",
            "adverbial": kum_root + "დ",
            "vocative": root,
        }
    if root.endswith("ი"):
        stem = root[:-1]
        return {
            "nominative": root,
            "ergative": stem + "მა",
            "dative": stem + "ს",
            "genitive": kum_root + "ის",
            "instrumental": kum_root + "ით",
            "adverbial": kum_root + "ად",
            "vocative": root,
        }
    if root.endswith("ო") or root.endswith("უ"):
        return {
            "nominative": root,
            "ergative": root + "მ",
            "dative": root + "ს",
            "genitive": kum_root + "ს",
            "instrumental": kum_root + "თ",
            "adverbial": kum_root + "დ",
            "vocative": root,
        }
    return {
        "nominative": root + "ი",
        "ergative": root + "მა",
        "dative": root + "ს",
        "genitive": kum_root + "ის",
        "instrumental": kum_root + "ით",
        "adverbial": kum_root + "ად",
        "vocative": root + "ო",
    }

def generate_declension(entry):
    root = entry.get("root", "")
    kum_root = entry.get("kumSvadkvecadi_root", root)
    singular = generate_singular(root, kum_root)
    appended = generate_singular(kum_root + "ებ")
    return {
        "nominative": {"singular": singular["nominative"], "plural": appended["nominative"]},
        "ergative": {"singular": singular["ergative"], "plural": appended["ergative"]},
        "dative": {"singular": singular["dative"], "plural": appended["dative"]},
        "genitive": {"singular": singular["genitive"], "plural": appended["genitive"]},
        "instrumental": {"singular": singular["instrumental"], "plural": appended["instrumental"]},
        "adverbial": {"singular": singular["adverbial"], "plural": appended["adverbial"]},
        "vocative": {"singular": singular["vocative"], "plural": appended["vocative"]},
    }
