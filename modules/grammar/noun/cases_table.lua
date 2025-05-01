local export = {}
export.__index = export
export.order = {
    "nominative",
    "ergative",
    "dative",
    "genitive",
    "instrumental",
    "adverbial",
    "vocative",
}

export.names = {
    ["nominative"] = "Nominative (სახელობითი)",
    ["ergative"] = "Ergative (მოთხრობითი)",
    ["dative"] = "Dative (მიცემითი)",
    ["genitive"] = "Genitive (ნათესაობითი)",
    ["instrumental"] = "Instrumental (მოქმედებითი)",
    ["adverbial"] = "Adverbial (ვითარებითი)",
    ["vocative"] = "Vocative (წოდებითი)",
}

function export.new(arg)
    local self = setmetatable(arg, export)
    return self
end

function export:validate()
    for _, case in pairs(export.order) do
        if self[case] == nil then
            error("ERROR 0: in Case '" .. case .. "': case not found")
        elseif type(self[case]) ~= "table" then
            error("ERROR 1: in Case '" .. case .. "': must be a table")
        else
            for _, number in pairs({"singular", "plural"}) do
                if self[case][number] == nil then
                    error("ERROR 3: in Case '" .. case .. "', number '" .. number .. "': value is null")
                elseif type(self[case][number]) ~= "string" then
                    error("ERROR 4: in Case '" .. case .. "', number '" .. number .. "': value is not a string")
                end
            end
        end
    end
end

return export
