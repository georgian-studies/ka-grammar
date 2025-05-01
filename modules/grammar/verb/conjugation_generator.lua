local export = {}

local screeves_table = require('modules/grammar/verb/screeves_table')

function export.generate_from_dict(entry)
    local forms = export.generate(entry.root, entry.preverb, entry.versioner, entry.thematic_suffix, entry.indirect_object)
    return forms;
end

function export.generate(root, preverb, versioner, thematic_suffix, indirect_object)

    if indirect_object ~= nil then

    end

    if thematic_suffix == nil then
        thematic_suffix = ""
    end

    if versioner == nil then
        versioner = ""
    end

    -- დაწერს, დაკარგავს
    return screeves_table.new(
        {
            present_indicative__awmyo = {
                I = {
                    singular = "ვ" .. versioner .. root .. thematic_suffix .. "",
                    plural = "ვ" .. versioner .. root .. thematic_suffix .. "თ",
                },
                II = {
                    singular = "" .. versioner .. root .. thematic_suffix .. "",
                    plural = "" .. versioner .. root .. thematic_suffix .. "თ",
                },
                III = {
                    singular = "" .. versioner .. root .. thematic_suffix .. "ს",
                    plural = "" .. versioner .. root .. thematic_suffix .. "ენ",
                },
            },
            present_imperfect__uwyveteli = {
                I = {
                    singular = "ვ" .. versioner .. root .. thematic_suffix .. "დი",
                    plural = "ვ" .. versioner .. root .. thematic_suffix .. "დით",
                },
                II = {
                    singular = "" .. versioner .. root .. thematic_suffix .. "დი",
                    plural = "" .. versioner .. root .. thematic_suffix .. "დით",
                },
                III = {
                    singular = "" .. versioner .. root .. thematic_suffix .. "და",
                    plural = "" .. versioner .. root .. thematic_suffix .. "დნენ",
                },
            },
            present_subjunctive__awmyos_kavSirebiTi = {
                I = {
                    singular = "ვ" .. versioner .. root .. thematic_suffix .. "დე",
                    plural = "ვ" .. versioner .. root .. thematic_suffix .. "დეთ",
                },
                II = {
                    singular = "" .. versioner .. root .. thematic_suffix .. "დე",
                    plural = "" .. versioner .. root .. thematic_suffix .. "დეთ",
                },
                III = {
                    singular = "" .. versioner .. root .. thematic_suffix .. "დეს",
                    plural = "" .. versioner .. root .. thematic_suffix .. "დნენ",
                },
            },

            future_indicative__myofadi = {
                I = {
                    singular = preverb .. "ვ" .. versioner .. root .. thematic_suffix .. "",
                    plural = preverb .. "ვ" .. versioner .. root .. thematic_suffix .. "თ",
                },
                II = {
                    singular = preverb .. "" .. versioner .. root .. thematic_suffix .. "",
                    plural = preverb .. "" .. versioner .. root .. thematic_suffix .. "თ",
                },
                III = {
                    singular = preverb .. "" .. versioner .. root .. thematic_suffix .. "ს",
                    plural = preverb .. "" .. versioner .. root .. thematic_suffix .. "ენ",
                },
            },
            future_conditional__xolmeobiT_pirobiTi = {
                I = {
                    singular = preverb .. "ვ" .. versioner .. root .. thematic_suffix .. "დი",
                    plural = preverb .. "ვ" .. versioner .. root .. thematic_suffix .. "დით",
                },
                II = {
                    singular = preverb .. "" .. versioner .. root .. thematic_suffix .. "დი",
                    plural = preverb .. "" .. versioner .. root .. thematic_suffix .. "დით",
                },
                III = {
                    singular = preverb .. "" .. versioner .. root .. thematic_suffix .. "და",
                    plural = preverb .. "" .. versioner .. root .. thematic_suffix .. "დნენ",
                },
            },
            future_subjunctive__myofadis_kavSirebiTi = {
                I = {
                    singular = preverb .. "ვ" .. versioner .. root .. thematic_suffix .. "დე",
                    plural = preverb .. "ვ" .. versioner .. root .. thematic_suffix .. "დეთ",
                },
                II = {
                    singular = preverb .. "" .. versioner .. root .. thematic_suffix .. "დე",
                    plural = preverb .. "" .. versioner .. root .. thematic_suffix .. "დეთ",
                },
                III = {
                    singular = preverb .. "" .. versioner .. root .. thematic_suffix .. "დეს",
                    plural = preverb .. "" .. versioner .. root .. thematic_suffix .. "დნენ",
                },
            },

            aorist_indicative__wyvetili = {
                I = {
                    singular = preverb .. "ვ" .. versioner .. root .. "ე",
                    plural = preverb .. "ვ" .. versioner .. root .. "ეთ",
                },
                II = {
                    singular = preverb .. "" .. versioner .. root .. "ე",
                    plural = preverb .. "" .. versioner .. root .. "ეთ",
                },
                III = {
                    singular = preverb .. "" .. versioner .. root .. "ა",
                    plural = preverb .. "" .. versioner .. root .. "ეს",
                },
            },
            aorist_optative__II_kavSirebiTi = {
                I = {
                    singular = preverb .. "ვ" .. versioner .. root .. "ო",
                    plural = preverb .. "ვ" .. versioner .. root .. "ოთ",
                },
                II = {
                    singular = preverb .. "" .. versioner .. root .. "ო",
                    plural = preverb .. "" .. versioner .. root .. "ოთ",
                },
                III = {
                    singular = preverb .. "" .. versioner .. root .. "ოს",
                    plural = preverb .. "" .. versioner .. root .. "ონ",
                },
            },

            perfect__I_rezultativi = versioner == "" and {
                I = {
                    singular = preverb .. "მ" .. "ი" .. root .. "ია",
                    plural = preverb .. "გვ" .. "ი" .. root .. "ია",
                },
                II = {
                    singular = preverb .. "გ" .. "ი" .. root .. "ია",
                    plural = preverb .. "გ" .. "ი" .. root .. "იათ",
                },
                III = {
                    singular = preverb .. "უ" .. root .. "ია",
                    plural = preverb .. "უ" .. root .. "იათ",
                },
            } or screeves_table.empty_screeve(),
            pluperfect__II_rezultativi = versioner == "" and {
                I = {
                    singular = preverb .. "მ" .. "ე" .. root .. "ა",
                    plural = preverb .. "გვ" .. "ე" .. root .. "ა",
                },
                II = {
                    singular = preverb .. "გ" .. "ე" .. root .. "ა",
                    plural = preverb .. "გ" .. "ე" .. root .. "ათ",
                },
                III = {
                    singular = preverb .. "" .. "ე" .. root .. "ა",
                    plural = preverb .. "" .. "ე" .. root .. "ათ",
                },
            } or screeves_table.empty_screeve(),
            perfect_subjunctive__III_kavSirebiTi = versioner == "" and {
                I = {
                    singular = preverb .. "მ" .. "ე" .. root .. "ოს",
                    plural = preverb .. "გვ" .. "ე" .. root .. "ოს",
                },
                II = {
                    singular = preverb .. "გ" .. "ე" .. root .. "ოს",
                    plural = preverb .. "გ" .. "ე" .. root .. "ოთ",
                },
                III = {
                    singular = preverb .. "" .. "ე" .. root .. "ოს",
                    plural = preverb .. "" .. "ე" .. root .. "ოთ",
                },
            } or screeves_table.empty_screeve(),

            imperative__brZandebiTi = {
                I = {
                    singular = "—",
                    plural = preverb .. "ვ" .. versioner .. root .. "ოთ",
                },
                II = {
                    singular = preverb .. ""  .. versioner .. root .. "ე",
                    plural = preverb .. "" .. versioner .. root .. "ეთ",
                },
                III = {
                    singular = "—",
                    plural = "—",
                },
            },
        }
    )
end

return export