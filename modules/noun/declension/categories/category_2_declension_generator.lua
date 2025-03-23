local export = {}

function export:generate(root)
    return {
        singular = {
            nominative = root .. "",
            ergative = root .. "მ",
            dative = root .. "ს",
            genitive = root .. "ს",
            instrumental = root .. "თ",
            adverbial = root .. "დ",
            vocative = root .. "ვ",
        },
        plural = {
            nominative = root .. "ები",
            ergative = root .. "ებმა",
            dative = root .. "ებს",
            genitive = root .. "ების",
            instrumental = root .. "ებით",
            adverbial = root .. "ებად",
            vocative = root .. "ებო",
        }
    }
end

return export