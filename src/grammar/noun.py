from contracts import WordConfigurationDto, NounForms, NounCases



def generate_noun_forms(entry: WordConfigurationDto) -> NounForms:

    root = entry.root
    kumSvadi_root = entry.kumSvadi_root if entry.kumSvadi_root is not None else root

    if root.endswith(("ა", "ე")):
        vocative = "ვ" if root.endswith("ა") else "ო"

        if entry.kveca:
            singular = _generate_xmovanfuZiani_with_kveca(root, kumSvadi_root, vocative)
        else:
            if entry.drop_vocative:
                vocative = ""
            singular = _generate_xmovanfuZiani_without_kveca(root, kumSvadi_root, vocative)

        if entry.kveca_in_plural is not None:
            kveca_in_plural = entry.kveca_in_plural
        else:
            if root.endswith("ა"):
                kveca_in_plural = entry.kveca if entry.kveca is not None else False
            else:
                kveca_in_plural = False
        plural_root_base = (kumSvadi_root[:-1] if kveca_in_plural else kumSvadi_root)
    elif root.endswith(("ი", "ო", "უ")):
        # ჩაი, გეი, ჰრუშევსკი, ტრამვაი
        # სოკო, ბუ
        # todo: ღვინო
        singular = _generate_xmovanfuZiani_without_kveca(root, root, vocative="")

        # todo: shouldn't the default value be True for "ი"?
        kveca_in_plural = entry.kveca_in_plural if entry.kveca_in_plural is not None else False
        plural_root_base = kumSvadi_root[:-1] if kveca_in_plural else kumSvadi_root
    else:
        # პური, ბატონი, ნამუშევარი
        singular = _generate_TanxmovanfuZiani(root, kumSvadi_root)
        plural_root_base = kumSvadi_root

    plural_root = plural_root_base + "ებ"
    plural: NounCases = _generate_TanxmovanfuZiani(plural_root, plural_root)

    return NounForms(singular=singular, plural=plural)



def _generate_TanxmovanfuZiani(root: str, kumSvadi_root: str) -> NounCases:
    # პური, ბატონი
    return NounCases(
        nominative__saxelobiTi=root + "ი",
        ergative__moTxrobiTi=root + "მა",
        dative__micemiTi=root + "ს",
        genitive__naTesaobiTi=kumSvadi_root + "ის",
        instrumental__moqmedebiTi=kumSvadi_root + "ით",
        adverbial__viTarebiTi=kumSvadi_root + "ად",
        vocative__wodebiTi=root + "ო",
    )


def _generate_xmovanfuZiani_without_kveca(root: str, kumSvadi_root: str, vocative: str) -> NounCases:
    # ჩაი: [ჩაი, ჩაი, True]
    # გეი: [გეი, გეი, True]
    # ჰრუშევსკი: [ჰრუშევსკი, ჰრუშევსკი, True]
    # ტრამვაი: [ტრამვაი, ტრამვაი, True]
    # ანა: [ანა, ანა, ანა, True]
    # ირაკლი: [ირაკლი, ირაკლი, True]
    # ერეკლე: [ერეკლე, ერეკლე, True]
    return NounCases(
        nominative__saxelobiTi=root,
        ergative__moTxrobiTi=root + "მ",
        dative__micemiTi=root + "ს",
        genitive__naTesaobiTi=kumSvadi_root + "ს",
        instrumental__moqmedebiTi=kumSvadi_root + "თ",
        adverbial__viTarebiTi=kumSvadi_root + "დ",
        vocative__wodebiTi=root + vocative,
    )

def _generate_xmovanfuZiani_with_kveca(root: str, kumSvadi_root: str, vocative: str) -> NounCases:
    # მთა, მამა, ბიძა, ძმა, ხმა
    # დღე, ღამე
    kumSvadkvecadi_root = kumSvadi_root[:-1]

    # დღე, ღამე
    # მთა, მამა, ბიძა, ძმა, ხმა
    return NounCases(
        nominative__saxelobiTi=root,
        ergative__moTxrobiTi=root + "მ",
        dative__micemiTi=root + "ს",
        genitive__naTesaobiTi=kumSvadkvecadi_root + "ის",
        instrumental__moqmedebiTi=kumSvadkvecadi_root + "ით",
        adverbial__viTarebiTi=kumSvadi_root + "დ",
        vocative__wodebiTi=root + vocative,
    )