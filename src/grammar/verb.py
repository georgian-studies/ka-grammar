from contracts import VerbScreevePersonForms, VerbScreeveForms, VerbForms, WordConfigurationDto


def _blank() -> VerbScreeveForms:
    return VerbScreeveForms(I=VerbScreevePersonForms(singular="—", plural="—"), II=VerbScreevePersonForms(singular="—", plural="—"), III=VerbScreevePersonForms(singular="—", plural="—"))


def _form(
    *,
    preverb: str,
    prefix: str,
    versioner: str,
    root: str,
    thematic_suffix: str,
    suffix: str,
    use_thema: bool = True,
) -> str:
    ts = thematic_suffix if use_thema else ""
    return f"{preverb}{prefix}{versioner}{root}{ts}{suffix}"


def generate_verb_forms(entry: WordConfigurationDto) -> VerbForms:  # noqa: F821

    root: str = entry.root
    preverb: str = entry.preverb or ""
    versioner: str = entry.versioner or ""
    thematic_suffix: str = entry.thematic_suffix or ""

    present_indicative = VerbScreeveForms(
        I=VerbScreevePersonForms(
            singular=_form(preverb= "", prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix=""),
            plural=_form(preverb= "", prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="თ"),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix=""),
            plural=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="თ"),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="ს"),
            plural=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="ენ"),
        ),
    )

    present_imperfect = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დი"),
            plural=_form(preverb="", prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დით"),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დი"),
            plural=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="მით"),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="და"),
            plural=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დნენ"),
        ),
    )

    present_subjunctive = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დე"),
            plural=_form(preverb="", prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დეთ"),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დე"),
            plural=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დეთ"),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დეს"),
            plural=_form(preverb="", prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დნენ"),
        ),
    )

    # ---------- Future --------------------------------------------------- #
    future_indicative = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix=""),
            plural=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="თ"),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix=""),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="თ"),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="ს"),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="ენ"),
        ),
    )

    future_conditional = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დი"),
            plural=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დით"),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დი"),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დით"),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="და"),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დნენ"),
        ),
    )

    future_subjunctive = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დე"),
            plural=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დეთ"),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დე"),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დეთ"),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დეს"),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix=thematic_suffix, suffix="დნენ"),
        ),
    )

    # ---------- Aorist ---------------------------------------------------- #
    aorist_indicative = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix="", suffix="ე", use_thema=False),
            plural=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix="", suffix="ეთ", use_thema=False),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ე", use_thema=False),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ეთ", use_thema=False),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ა", use_thema=False),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ეს", use_thema=False),
        ),
    )

    aorist_optative = VerbScreeveForms(
         I=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix="", suffix="ო", use_thema=False),
            plural=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix="", suffix="ოთ", use_thema=False),
        ),
        II=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ო", use_thema=False),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ოთ", use_thema=False),
        ),
        III=VerbScreevePersonForms(
            singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ოს", use_thema=False),
            plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ონ", use_thema=False),
        ),
    )

    if versioner == "":
        perfect = VerbScreeveForms(
            I=VerbScreevePersonForms(singular=f"{preverb}მი{root}ია", plural=f"{preverb}გვ" f"ი{root}ია"),
            II=VerbScreevePersonForms(singular=f"{preverb}გი{root}ია", plural=f"{preverb}გი{root}იათ"),
            III=VerbScreevePersonForms(singular=f"{preverb}უ{root}ია", plural=f"{preverb}უ{root}იათ"),
        )
        pluperfect = VerbScreeveForms(
            I=VerbScreevePersonForms(singular=f"{preverb}მე{root}ა", plural=f"{preverb}გვ" f"ე{root}ა"),
            II=VerbScreevePersonForms(singular=f"{preverb}გე{root}ა", plural=f"{preverb}გე{root}ათ"),
            III=VerbScreevePersonForms(singular=f"{preverb}ე{root}ა", plural=f"{preverb}ე{root}ათ"),
        )
        perfect_subj = VerbScreeveForms(
            I=VerbScreevePersonForms(singular=f"{preverb}მე{root}ოს", plural=f"{preverb}გვ" f"ე{root}ოს"),
            II=VerbScreevePersonForms(singular=f"{preverb}გე{root}ოს", plural=f"{preverb}გე{root}ოთ"),
            III=VerbScreevePersonForms(singular=f"{preverb}ე{root}ოს", plural=f"{preverb}ე{root}ოთ"),
        )
    else:
        perfect = pluperfect = perfect_subj = _blank()

    imperative = VerbScreeveForms(
        I=VerbScreevePersonForms(singular="—", plural=_form(preverb=preverb, prefix="ვ", versioner=versioner, root=root, thematic_suffix="", suffix="ოთ", use_thema=False)),
        II=VerbScreevePersonForms(singular=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ე", use_thema=False), plural=_form(preverb=preverb, prefix="", versioner=versioner, root=root, thematic_suffix="", suffix="ეთ", use_thema=False)),
        III=VerbScreevePersonForms(singular="—", plural="—"),
    )

    return VerbForms(
        present_indicative__awmyo=present_indicative,
        present_imperfect__uwyveteli=present_imperfect,
        present_subjunctive__awmyos_kavSirebiTi=present_subjunctive,
        future_indicative__myofadi=future_indicative,
        future_conditional__xolmeobiT_pirobiTi=future_conditional,
        future_subjunctive__myofadis_kavSirebiTi=future_subjunctive,
        aorist_indicative__wyvetili=aorist_indicative,
        aorist_optative__II_kavSirebiTi=aorist_optative,
        perfect__I_rezultativi=perfect,
        pluperfect__II_rezultativi=pluperfect,
        perfect_subjunctive__III_kavSirebiTi=perfect_subj,
        imperative__brZandebiTi=imperative,
    )
