import json
from typing import Any

from jinja2 import Environment, DictLoader, select_autoescape

from contracts import NounForms, VerbForms

_TEMPLATES: dict[str, str] = {
    "noun.html": r"""
<table class="min-w-full table-fixed border-collapse text-sm">
  <caption class="sr-only">Noun declension forms</caption>
  <thead class="bg-slate-100">
    <tr>
      <th class="px-3 py-2 font-semibold text-slate-700 border">Case</th>
      <th class="px-3 py-2 font-semibold text-slate-700 border">Singular</th>
      <th class="px-3 py-2 font-semibold text-slate-700 border">Plural</th>
    </tr>
  </thead>
<tbody class="divide-y divide-gray-200">
  {% set rows = [
      ("Nominative (სახელობითი)", forms.singular.nominative__saxelobiTi, forms.plural.nominative__saxelobiTi),
      ("Ergative (მოთხრობითი)", forms.singular.ergative__moTxrobiTi, forms.plural.ergative__moTxrobiTi),
      ("Dative (მიცემითი)", forms.singular.dative__micemiTi, forms.plural.dative__micemiTi),
      ("Genitive (ნათესაობითი)", forms.singular.genitive__naTesaobiTi, forms.plural.genitive__naTesaobiTi),
      ("Instrumental (მოქმედებითი)", forms.singular.instrumental__moqmedebiTi,forms.plural.instrumental__moqmedebiTi),
      ("Adverbial (ვითარებითი)", forms.singular.adverbial__viTarebiTi, forms.plural.adverbial__viTarebiTi),
      ("Vocative (წოდებითი)", forms.singular.vocative__wodebiTi, forms.plural.vocative__wodebiTi),
  ] %}
  {% for label, singular, plural in rows %}
    <tr class="odd:bg-white even:bg-slate-50">
      <td class="px-3 py-2 font-medium text-slate-700 border">{{ label }}</td>
      <td class="px-3 py-2 border whitespace-nowrap">{{ singular }}</td>
      <td class="px-3 py-2 border whitespace-nowrap">{{ plural }}</td>
    </tr>
  {% endfor %}
</tbody>
</table>
""",
    "verb.html": r"""
<table class="min-w-full table-fixed border-collapse text-sm">
  <caption class="sr-only">Verb conjugation forms</caption>
  <thead class="bg-slate-100">
    <tr>
      <th rowspan="2" class="px-3 py-2 font-semibold text-slate-700 border">
        Screeves
      </th>
      <th colspan="3" class="px-3 py-2 font-semibold text-slate-700 border text-center">
        Singular
      </th>
      <th colspan="3" class="px-3 py-2 font-semibold text-slate-700 border text-center">
        Plural
      </th>
    </tr>
    <tr>
      {% for _ in range(2) %}
        <th class="px-3 py-2 border">I</th>
        <th class="px-3 py-2 border">II</th>
        <th class="px-3 py-2 border">III</th>
      {% endfor %}
    </tr>
  </thead>

  <tbody class="divide-y divide-gray-200">

    {% set rows = [
      ("Present indicative (აწმყო)", forms.present_indicative__awmyo),
      ("Present imperfect (უწყვეტელი)", forms.present_imperfect__uwyveteli),
      ("Present subjunctive (აწმყოს კავშირებითი)", forms.present_subjunctive__awmyos_kavSirebiTi),

      ("Future indicative (მყოფადი)", forms.future_indicative__myofadi),
      ("Future conditional (ხოლმეობითი პირობითი)", forms.future_conditional__xolmeobiT_pirobiTi),
      ("Future subjunctive (მყოფადის კავშირებითი)", forms.future_subjunctive__myofadis_kavSirebiTi),

      ("Aorist indicative (წყვეტილი)", forms.aorist_indicative__wyvetili),
      ("Aorist optative (II კავშირებითი)", forms.aorist_optative__II_kavSirebiTi),

      ("Perfect (I რესულტატივი)", forms.perfect__I_rezultativi),
      ("Pluperfect (II რესულტატივი)", forms.pluperfect__II_rezultativi),
      ("Perfect subjunctive (III კავშირებითი)", forms.perfect_subjunctive__III_kavSirebiTi),

      ("Imperative (ბრძანებითი)", forms.imperative__brZandebiTi),
    ] %}

    {% for label, scr in rows %}
      <tr class="odd:bg-white even:bg-slate-50">
        <td class="px-3 py-2 font-medium text-slate-700 border">{{ label }}</td>

        {# ── singular I II III ── #}
        <td class="px-3 py-2 border whitespace-nowrap">{{ scr.I.singular }}</td>
        <td class="px-3 py-2 border whitespace-nowrap">{{ scr.II.singular }}</td>
        <td class="px-3 py-2 border whitespace-nowrap">{{ scr.III.singular }}</td>

        {# ── plural I II III ── #}
        <td class="px-3 py-2 border whitespace-nowrap">{{ scr.I.plural }}</td>
        <td class="px-3 py-2 border whitespace-nowrap">{{ scr.II.plural }}</td>
        <td class="px-3 py-2 border whitespace-nowrap">{{ scr.III.plural }}</td>
      </tr>
    {% endfor %}

  </tbody>
</table>
""",
}

_env = Environment(
    loader=DictLoader(_TEMPLATES),
    autoescape=select_autoescape(enabled_extensions=("html", "xml")),
    trim_blocks=True,
    lstrip_blocks=True,
)

def render_json(forms: Any) -> str:
    return json.dumps(forms, indent=2, ensure_ascii=False)


def render_noun_html(forms: NounForms) -> str:
    tmpl = _env.get_template("noun.html")
    return tmpl.render(forms=forms)


def render_verb_html(forms: VerbForms) -> str:
    tmpl = _env.get_template("verb.html")
    return tmpl.render(forms=forms)
