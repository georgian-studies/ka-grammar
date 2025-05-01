import json
import html

def render_json(forms):
    return json.dumps(forms, indent=2)

def render_noun_html(forms):
    html_output = []
    html_output.append('<table class="min-w-full table-fixed border-collapse text-sm">')
    html_output.append('<caption class="sr-only">Noun declension forms</caption>')
    html_output.append('<thead class="bg-slate-100">')
    html_output.append('  <tr>')
    html_output.append('    <th class="px-3 py-2 font-semibold text-slate-700 border">Case</th>')
    html_output.append('    <th class="px-3 py-2 font-semibold text-slate-700 border">Singular</th>')
    html_output.append('    <th class="px-3 py-2 font-semibold text-slate-700 border">Plural</th>')
    html_output.append('  </tr>')
    html_output.append('</thead>')
    html_output.append('<tbody class="divide-y divide-gray-200">')
    for case, values in forms.items():
        html_output.append('  <tr class="odd\\:bg-white even\\:bg-slate-50">')
        html_output.append(f'    <td class="px-3 py-2 font-medium text-slate-700 border">{html.escape(case)}</td>')
        html_output.append(f'    <td class="px-3 py-2 border whitespace-nowrap">{html.escape(values["singular"])}</td>')
        html_output.append(f'    <td class="px-3 py-2 border whitespace-nowrap">{html.escape(values["plural"])}</td>')
        html_output.append('  </tr>')
    html_output.append('</tbody>')
    html_output.append('</table>')
    return "\n".join(html_output)

def render_verb_html(forms):
    html_output = []
    html_output.append('<table class="min-w-full table-fixed border-collapse text-sm">')
    html_output.append('<caption class="sr-only">Verb conjugation forms</caption>')
    html_output.append('<thead class="bg-slate-100">')
    html_output.append('  <tr>')
    html_output.append('    <th rowspan="2" class="px-3 py-2 font-semibold text-slate-700 border">Screeves</th>')
    html_output.append('    <th colspan="3" class="px-3 py-2 font-semibold text-slate-700 border text-center">Singular</th>')
    html_output.append('    <th colspan="3" class="px-3 py-2 font-semibold text-slate-700 border text-center">Plural</th>')
    html_output.append('  </tr>')
    html_output.append('  <tr>')
    html_output.append('    <th class="px-3 py-2 border">I</th>')
    html_output.append('    <th class="px-3 py-2 border">II</th>')
    html_output.append('    <th class="px-3 py-2 border">III</th>')
    html_output.append('    <th class="px-3 py-2 border">I</th>')
    html_output.append('    <th class="px-3 py-2 border">II</th>')
    html_output.append('    <th class="px-3 py-2 border">III</th>')
    html_output.append('  </tr>')
    html_output.append('</thead>')
    html_output.append('<tbody class="divide-y divide-gray-200">')
    for screeve, persons in forms.items():
        html_output.append('  <tr class="odd\\:bg-white even\\:bg-slate-50">')
        html_output.append(f'    <td class="px-3 py-2 font-medium text-slate-700 border">{html.escape(screeve)}</td>')
        for person in ["I", "II", "III"]:
            singular = persons.get(person, {}).get("singular", "—")
            plural = persons.get(person, {}).get("plural", "—")
            html_output.append(f'    <td class="px-3 py-2 border whitespace-nowrap">{html.escape(singular)}</td>')
            html_output.append(f'    <td class="px-3 py-2 border whitespace-nowrap">{html.escape(plural)}</td>')
        html_output.append('  </tr>')
    html_output.append('</tbody>')
    html_output.append('</table>')
    return "\n".join(html_output)
