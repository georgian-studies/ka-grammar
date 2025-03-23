local export = {}

local screeves_table = require('modules/verb/screeves_table')

function export.generate(root, preverb, thematic_suffix)

    return screeves_table.new(
        {
            present_indicative__awmyo = {
                I = {
                    singular = "ვ" .. root .. thematic_suffix .. "",
                    plural = "ვ" .. root .. thematic_suffix .. "თ",
                },
                II = {
                    singular = "" .. root .. thematic_suffix .. "",
                    plural = "" .. root .. thematic_suffix .. "თ",
                },
                III = {
                    singular = "" .. root .. thematic_suffix .. "ს",
                    plural = "" .. root .. thematic_suffix .. "ენ",
                },
            },
            present_imperfect__uwyveteli = {
                I = {
                    singular = "ვ" .. root .. thematic_suffix .. "დი",
                    plural = "ვ" .. root .. thematic_suffix .. "დით",
                },
                II = {
                    singular = "" .. root .. thematic_suffix .. "დი",
                    plural = "" .. root .. thematic_suffix .. "დით",
                },
                III = {
                    singular = "" .. root .. thematic_suffix .. "და",
                    plural = "" .. root .. thematic_suffix .. "დნენ",
                },
            },
            present_subjunctive__awmyos_kavSirebiTi = {
                I = {
                    singular = "ვ" .. root .. thematic_suffix .. "დე",
                    plural = "ვ" .. root .. thematic_suffix .. "დეთ",
                },
                II = {
                    singular = "" .. root .. thematic_suffix .. "დე",
                    plural = "" .. root .. thematic_suffix .. "დეთ",
                },
                III = {
                    singular = "" .. root .. thematic_suffix .. "დეს",
                    plural = "" .. root .. thematic_suffix .. "დნენ",
                },
            },

            future_indicative__myofadi = {
                I = {
                    singular = preverb .. "ვ" .. root .. thematic_suffix .. "",
                    plural = preverb .. "ვ" .. root .. thematic_suffix .. "თ",
                },
                II = {
                    singular = preverb .. "" .. root .. thematic_suffix .. "",
                    plural = preverb .. "" .. root .. thematic_suffix .. "თ",
                },
                III = {
                    singular = preverb .. "" .. root .. thematic_suffix .. "ს",
                    plural = preverb .. "" .. root .. thematic_suffix .. "ენ",
                },
            },
            future_conditional__xolmeobiT_pirobiTi = {
                I = {
                    singular = preverb .. "ვ" .. root .. thematic_suffix .. "დი",
                    plural = preverb .. "ვ" .. root .. thematic_suffix .. "დით",
                },
                II = {
                    singular = preverb .. "" .. root .. thematic_suffix .. "დი",
                    plural = preverb .. "" .. root .. thematic_suffix .. "დით",
                },
                III = {
                    singular = preverb .. "" .. root .. thematic_suffix .. "და",
                    plural = preverb .. "" .. root .. thematic_suffix .. "დნენ",
                },
            },
            future_subjunctive__myofadis_kavSirebiTi = {
                I = {
                    singular = preverb .. "ვ" .. root .. thematic_suffix .. "დე",
                    plural = preverb .. "ვ" .. root .. thematic_suffix .. "დეთ",
                },
                II = {
                    singular = preverb .. "" .. root .. thematic_suffix .. "დე",
                    plural = preverb .. "" .. root .. thematic_suffix .. "დეთ",
                },
                III = {
                    singular = preverb .. "" .. root .. thematic_suffix .. "დეს",
                    plural = preverb .. "" .. root .. thematic_suffix .. "დნენ",
                },
            },

            aorist_indicative__wyvetili = {
                I = {
                    singular = preverb .. "ვ" .. root .. "ე",
                    plural = preverb .. "ვ" .. root .. "ეთ",
                },
                II = {
                    singular = preverb .. "" .. root .. "ე",
                    plural = preverb .. "" .. root .. "ეთ",
                },
                III = {
                    singular = preverb .. "" .. root .. "ა",
                    plural = preverb .. "" .. root .. "ეს",
                },
            },
            aorist_optative__II_kavSirebiTi = {
                I = {
                    singular = preverb .. "ვ" .. root .. "ო",
                    plural = preverb .. "ვ" .. root .. "ოთ",
                },
                II = {
                    singular = preverb .. "" .. root .. "ო",
                    plural = preverb .. "" .. root .. "ოთ",
                },
                III = {
                    singular = preverb .. "" .. root .. "ოს",
                    plural = preverb .. "" .. root .. "ონ",
                },
            },

            perfect__I_rezultativi = {
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
            },
            pluperfect__II_rezultativi = {
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
            },
            perfect_subjunctive__III_kavSirebiTi = {
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
            },

            imperative__brZandebiTi = {
                I = {
                    singular = "—",
                    plural = preverb .. "ვ" .. root .. "ოთ",
                },
                II = {
                    singular = preverb .. "" .. root .. "ე",
                    plural = preverb .. "" .. root .. "ეთ",
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