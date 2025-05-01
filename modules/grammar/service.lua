local views = require("modules/grammar/views")
local json = require("vendors/dkjson")

local export = {}

function export:render_word(view_type, arg_json_string)

    local arg, _, err = json.decode(arg_json_string, 1, nil)
    if err then
        error("Failed to decode JSON: " .. err)
    end

    local forms
    local result

    if arg.part_of_speech == 'noun' then
        local noun = require("modules/grammar/noun/noun")
        forms = noun.generate_declension(arg)
        forms:validate()

        if view_type == "json" then
            result = views.render_json(forms)
        elseif view_type == "html" then
            result = views.render_noun_html(forms)
        elseif view_type == "wikitext" then
            result = views.render_noun_wikitext(forms)
        else
            error("Unsupported view type: " .. tostring(view_type))
        end
    elseif arg.part_of_speech == 'verb' then

        local conjugation_generator = require("modules/grammar/verb/conjugation_generator")

        forms = conjugation_generator.generate_from_dict(arg)
        forms:validate()

        if view_type == "json" then
            result = views.render_json(forms)
        elseif view_type == "html" then
            result = views.render_verb_html(forms)
        elseif view_type == "wikitext" then
            result = views.render_verb_wikitext(forms)
        else
            error("Unsupported view type: " .. tostring(view_type))
        end
    else
        error("Invalid argument 'part_of_speech' at position 1: " .. (arg.part_of_speech or "nil"))
    end

        print(result)
end

return export