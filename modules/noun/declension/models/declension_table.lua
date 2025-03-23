local export = {}
export.__index = export

local case_forms = require("modules/noun/declension/models/case_forms")

function export.new()
    local self = setmetatable({
        singular = case_forms.new(),
        plural = case_forms.new()
    }, export)
    return self
end

function export:validate()
    if type(self.singular) ~= "table" or type(self.plural) ~= "table" then
        error("singular and plural must be tables")
    end
    self.singular:validate()
    self.plural:validate()
end

return export
