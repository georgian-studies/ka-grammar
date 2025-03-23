local export = {}

local conjugation_generator = require("modules/verb/conjugation_generator")

function export.generate_conjugation(arg)
    local root, preverb, thematic_suffix = arg:match("^([^;]+);([^;]+);([^;]+);?$")

    return conjugation_generator:generate(root, preverb, thematic_suffix)
end

return export
