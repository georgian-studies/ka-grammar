local export = {}

local screeves_table = require('modules/verb/screeves_table')

function export.iterate_screeves(forms)
    local iterator = function()
        for _, screeve in ipairs(screeves_table.order) do
            local screeve_name = screeves_table.names[screeve]
            local screeve_forms = forms[screeve]

            coroutine.yield(screeve_name, screeve_forms)
        end
    end
    return coroutine.wrap(iterator)
end

function export.render_wikitext(forms)
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

function export.render_html(forms)
    local html = [[
<table class="wikitable">
  <caption></caption>
  <thead>
    <tr>
      <th rowspan="2">Screeves</th>
      <th colspan="3">Singular</th>
      <th colspan="3">Plural</th>
    </tr>
    <tr>
      <th>I</th>
      <th>II</th>
      <th>III</th>
      <th>I</th>
      <th>II</th>
      <th>III</th>
    </tr>
  </thead>
  <tbody>
]]

    for screeve_name, screeve_forms in export.iterate_screeves(forms) do
        html = html .. string.format([[
    <tr>
      <td>%s</td>
      <td>%s</td>
      <td>%s</td>
      <td>%s</td>
      <td>%s</td>
      <td>%s</td>
      <td>%s</td>
    </tr>
]],
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

return export