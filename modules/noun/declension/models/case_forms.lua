local export = {}
export.__index = export

function export.new()
    local self = setmetatable({
        nominative = nil,
        ergative = nil,
        dative = nil,
        genitive = nil,
        instrumental = nil,
        adverbial = nil,
        vocative = nil,
    }, export)
    return self
end

function export:validate()
    for _, case in pairs({"nominative", "ergative", "dative", "genitive", "instrumental", "adverbial", "vocative"}) do
        if type(self[case]) ~= "string" and self[case] ~= nil then
            error(case .. " must be a string or nil")
        end
    end
end

return export
