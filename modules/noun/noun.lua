local export = {}

local declension_categories = {
    ["1"] = require("modules/noun/declension/categories/category_1_declension_generator"),
    ["2"] = require("modules/noun/declension/categories/category_2_declension_generator"),
}

function export.generate_declension(arg)
    local root, category = arg:match("^([^;]+);([^;]+)$")
    if not declension_categories[category] then
        error("Invalid declension category: " .. category)
    end
    return declension_categories[category]:generate(root)
end

return export
