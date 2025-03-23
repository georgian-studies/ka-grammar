local noun = require("modules/noun/noun")
local noun_views = require("modules/noun/declension/views")

local verb = require("modules/verb/verb")
local verb_views = require("modules/verb/views")

local export = {}

function export:render_word(part_of_speech, arg)
    if part_of_speech == 'noun' then

        local forms = noun.generate_declension(arg)
        local result = noun_views:render_wikitext(forms)
        print(result)
    elseif part_of_speech == 'verb' then

        local forms = verb.generate_conjugation(arg)
        forms:validate()
        local result = verb_views.render_wikitext(forms)
        print(result)
    else
        print("Invalid argument 'part_of_speech' at position 1: " .. (part_of_speech or "nil"))
    end
end

return export