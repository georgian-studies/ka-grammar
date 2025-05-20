from dataclasses import dataclass
from typing import Optional

from pydantic import BaseModel

# todo: validate nouns and verbs
class WordConfigurationDto(BaseModel):
    part_of_speech: str
    root: str
    preverb: Optional[str] = None
    thematic_suffix: Optional[str] = None
    kveca: Optional[bool] = None
    kveca_in_plural: Optional[bool] = None # todo validate, that is only True if kveca is False
    kumSvadi_root: Optional[str] = None
    drop_vocative: Optional[bool] = None
    versioner: Optional[str] = None


@dataclass(slots=True, frozen=True)
class NounCases:
    nominative__saxelobiTi: str
    ergative__moTxrobiTi: str
    dative__micemiTi: str
    genitive__naTesaobiTi: str
    instrumental__moqmedebiTi: str
    adverbial__viTarebiTi: str
    vocative__wodebiTi: str

@dataclass(slots=True, frozen=True)
class NounForms:
    singular: NounCases
    plural: NounCases

@dataclass(slots=True, frozen=True)
class VerbScreevePersonForms:
    singular: str
    plural: str

@dataclass(slots=True, frozen=True)
class VerbScreeveForms:
    I: VerbScreevePersonForms
    II: VerbScreevePersonForms
    III: VerbScreevePersonForms


@dataclass(slots=True, frozen=True)
class VerbForms:
    present_indicative__awmyo: VerbScreeveForms
    present_imperfect__uwyveteli: VerbScreeveForms
    present_subjunctive__awmyos_kavSirebiTi: VerbScreeveForms
    future_indicative__myofadi: VerbScreeveForms
    future_conditional__xolmeobiT_pirobiTi: VerbScreeveForms
    future_subjunctive__myofadis_kavSirebiTi: VerbScreeveForms

    aorist_indicative__wyvetili: VerbScreeveForms
    aorist_optative__II_kavSirebiTi: VerbScreeveForms

    perfect__I_rezultativi: VerbScreeveForms
    pluperfect__II_rezultativi: VerbScreeveForms
    perfect_subjunctive__III_kavSirebiTi: VerbScreeveForms

    imperative__brZandebiTi: VerbScreeveForms
