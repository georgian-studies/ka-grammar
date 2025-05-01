local export = {}

local screeves_table = require('modules/grammar/verb/screeves_table')
local cases_table = require('modules/grammar/noun/cases_table')
local json = require("vendors/dkjson")

function export.iterate_screeves(verb_forms)
    local iterator = function()
        for _, screeve in ipairs(screeves_table.order) do
            local screeve_name = screeves_table.names[screeve]
            local screeve_forms = verb_forms[screeve]

            coroutine.yield(screeve_name, screeve_forms)
        end
    end
    return coroutine.wrap(iterator)
end

function export.iterate_cases(noun_forms)
    local iterator = function()
        for _, case in ipairs(cases_table.order) do
            local case_name = cases_table.names[case]
            local case_forms = noun_forms[case]
            coroutine.yield(case_name, case_forms)
        end
    end
    return coroutine.wrap(iterator)
end

function export.render_verb_wikitext(forms)
    local table = [[
{| class="wikitable"
|+
! rowspan="2" |Screeves
! colspan="3" |Singular
! colspan="3" |Plural
|-
!I
!II
!III
!I
!II
!III
]]

    for screeve_name, screeve_forms in export.iterate_screeves(forms) do
        table = table .. string.format('|—\n|%s\n|%s\n|%s\n|%s\n|%s\n|%s\n|%s\n', screeve_name, screeve_forms.I.singular, screeve_forms.II.singular, screeve_forms.III.singular, screeve_forms.I.plural, screeve_forms.II.plural, screeve_forms.III.plural)
    end

    table = table .. '|}'
    return table
end

function export.render_verb_html(forms)
    local html = [[
<table class="min-w-full table-fixed border-collapse text-sm">
  <caption class="sr-only">Verb conjugation forms</caption>

  <thead class="bg-slate-100">
    <tr>
      <th rowspan="2"
          class="px-3 py-2 font-semibold text-slate-700 border">Screeves</th>
      <th colspan="3"
          class="px-3 py-2 font-semibold text-slate-700 border text-center">Singular</th>
      <th colspan="3"
          class="px-3 py-2 font-semibold text-slate-700 border text-center">Plural</th>
    </tr>
    <tr>
      <th class="px-3 py-2 border">I</th>
      <th class="px-3 py-2 border">II</th>
      <th class="px-3 py-2 border">III</th>
      <th class="px-3 py-2 border">I</th>
      <th class="px-3 py-2 border">II</th>
      <th class="px-3 py-2 border">III</th>
    </tr>
  </thead>

  <tbody class="divide-y divide-gray-200">
]]

    for screeve_name, screeve_forms in export.iterate_screeves(forms) do
        html = html .. string.format([[
    <tr class="odd:bg-white even:bg-slate-50">
      <td class="px-3 py-2 font-medium text-slate-700 border">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
    </tr>]],
            screeve_name,
            screeve_forms.I.singular,
            screeve_forms.II.singular,
            screeve_forms.III.singular,
            screeve_forms.I.plural,
            screeve_forms.II.plural,
            screeve_forms.III.plural
        )
    end

    html = html .. [[
  </tbody>
</table>
]]
    return html
end

function export.render_noun_html(forms)
    local html = [[
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
]]

    for case_name, case_forms in export.iterate_cases(forms) do
        html = html .. string.format([[
    <tr class="odd:bg-white even:bg-slate-50">
      <td class="px-3 py-2 font-medium text-slate-700 border">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
      <td class="px-3 py-2 border whitespace-nowrap">%s</td>
    </tr>]],
            case_name,
            case_forms.singular,
            case_forms.plural
        )
    end

    html = html .. [[
  </tbody>
</table>
]]
    return html
end

function export.render_noun_wikitext(forms)
    local table = '{| class="wikitable"\n'
    table = table .. '! Case !! Singular !! Plural\n'

    for case_name, case_forms in export.iterate_cases(forms) do
        table = table .. string.format('|-\n| %s || %s || %s\n', case_name, case_forms.singular, case_forms.plural)
    end

    table = table .. '|}'
    return table
end

function export.render_json(forms)
    return json.encode(forms, { indent = false })
end

return export