local export = {}

function export.generate_from_dict(entry)
    local forms = export.generate(entry.root, entry.kumSvadkvecadi_root)
    return forms;
end

function export.generate(root, kumSvadkvecadi_root)
    local singular = generate_singular(root, kumSvadkvecadi_root)

    if kumSvadkvecadi_root == nil then
        kumSvadkvecadi_root = root
    end
    local plural = generate_singular(kumSvadkvecadi_root .. "ებ")
    return {
        nominative = {
            singular = singular.nominative,
            plural = plural.nominative,
        },
        ergative = {
            singular = singular.ergative,
            plural = plural.ergative,
        },
        dative = {
            singular = singular.dative,
            plural = plural.dative,
        },
        genitive = {
            singular = singular.genitive,
            plural = plural.genitive,
        },
        instrumental = {
            singular = singular.instrumental,
            plural = plural.instrumental,
        },
        adverbial = {
            singular = singular.adverbial,
            plural = plural.adverbial,
        },
        vocative = {
            singular = singular.vocative,
            plural = plural.vocative,
        },

    }
end

local function ends_with(s, suffix)
    return s:sub(-#suffix) == suffix
end

local function chop_last_char(s)
    local o = utf8.offset(s, -1)
    return o and s:sub(1, o - 1) or ""
end

function generate_singular(root, kumSvadkvecadi_root)
    kumSvadkvecadi_root = kumSvadkvecadi_root or root

    ----------------------------------------------------------------------
    -- ა-stem  (e.g. ქვეყანა, მამა, დედა)  ––– FIXED –––
    --  nomin & voc   : untouched / -ავ
    --  erg, dat      : full root + მ / ს
    --  gen, ins, adv : kum/root′ + ის / ით / ად
    ----------------------------------------------------------------------
    if ends_with(root, "ა") then
        local stem_v    = chop_last_char(root)          -- drop final ა  (ქვეყან)
        local vocative  = stem_v .. "ავ"                -- ქვეყანავ
        local kstem     = kumSvadkvecadi_root           -- already “ქვეყნ”

        return {
            nominative   = root,                        -- ქვეყანა
            ergative     = root .. "მ",                -- ქვეყანამ
            dative       = root .. "ს",                -- ქვეყანას
            genitive     = kstem .. "ის",              -- ქვეყნის
            instrumental = kstem .. "ით",              -- ქვეყნით
            adverbial    = kstem .. "ად",              -- ქვეყნად
            vocative     = vocative                    -- ქვეყანავ
        }
    end

    ----------------------------------------------------------------------
    -- ე-stem  (e.g. დღე)  ----------------------------------------------
    if ends_with(root, "ე") then
        local kstem = kumSvadkvecadi_root
        return {
            nominative   = root,
            ergative     = root .. "მ",
            dative       = root .. "ს",
            genitive     = kstem .. "ის",
            instrumental = kstem .. "ით",
            adverbial    = kstem .. "დ",
            vocative     = root                        -- (voc often = nom)
        }
    end

    ----------------------------------------------------------------------
    -- ი-stem  (e.g. პური, ჩაი)  -----------------------------------------
    if ends_with(root, "ი") then
        local stem  = chop_last_char(root)
        local kstem = kumSvadkvecadi_root
        return {
            nominative   = root,
            ergative     = stem .. "მა",
            dative       = stem .. "ს",
            genitive     = kstem .. "ის",
            instrumental = kstem .. "ით",
            adverbial    = kstem .. "ად",
            vocative     = root
        }
    end

    ----------------------------------------------------------------------
    -- ო / უ -stem  (e.g. გოგო, ბუ)  ------------------------------------
    if ends_with(root, "ო") or ends_with(root, "უ") then
        local kstem = kumSvadkvecadi_root
        return {
            nominative   = root,
            ergative     = root .. "მ",
            dative       = root .. "ს",
            genitive     = kstem .. "ს",
            instrumental = kstem .. "თ",
            adverbial    = kstem .. "დ",
            vocative     = root
        }
    end

    ----------------------------------------------------------------------
    -- consonant-stem  (default, unchanged)  -----------------------------
    return {
        nominative   = root .. "ი",
        ergative     = root .. "მა",
        dative       = root .. "ს",
        genitive     = kumSvadkvecadi_root .. "ის",
        instrumental = kumSvadkvecadi_root .. "ით",
        adverbial    = kumSvadkvecadi_root .. "ად",
        vocative     = root .. "ო",
    }
end

return export