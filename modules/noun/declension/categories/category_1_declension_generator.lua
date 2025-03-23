local export = {}

function export:generate(root)
    return {
        singular = {
            nominative = root .. "ი",
            ergative = root .. "მა",
            dative = root .. "ს",
            genitive = root .. "ის",
            instrumental = root .. "ით",
            adverbial = root .. "ად",
            vocative = root .. "ო",
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