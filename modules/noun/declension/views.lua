local export = {}
export.__index = export
export.case_order = {
    "nominative",
    "ergative",
    "dative",
    "genitive",
    "instrumental",
    "adverbial",
    "vocative",
}

function export.new()
    local self = setmetatable({}, export)
    function self:render(forms)
        error("not implemented")
    end
    return self
end

function export:iterate_cases(forms)
    local iterator = function()
        for _, case in ipairs(self.case_order) do
            local singular_form = forms.singular[case] or ""
            local plural_form = forms.plural[case] or ""
            coroutine.yield(case, singular_form, plural_form)
        end
    end
    return coroutine.wrap(iterator)
end

function export:render_html(forms)
    local table = '<table>\n<tr><th>Case</th><th>Singular</th><th>Plural</th></tr>\n'
    for case, singular_form, plural_form in self:iterate_cases(forms) do
        table = table .. string.format('<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n', case, singular_form, plural_form)
    end
    return table .. '</table>'
end

function export:render_wikitext(forms)
    local table = '{| class="wikitable"\n'
    table = table .. '! Case !! Singular !! Plural\n'

    for case, singular_form, plural_form in self:iterate_cases(forms) do
        table = table .. string.format('|-\n| %s || %s || %s\n', case, singular_form, plural_form)
    end

    table = table .. '|}'
    return table
end

return export