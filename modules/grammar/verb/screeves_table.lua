local export = {}
export.__index = export

function export.new(arg)
    local self = setmetatable(arg, export)
    return self
end

function export.empty_screeve()
    return {
        I = {
            singular = "—",
            plural = "—",
        },
        II = {
            singular = "—",
            plural = "—",
        },
        III = {
            singular = "—",
            plural = "—",
        },
    }
end

export.order = {
    "present_indicative__awmyo",
    "present_imperfect__uwyveteli",
    "present_subjunctive__awmyos_kavSirebiTi",

    "future_indicative__myofadi",
    "future_conditional__xolmeobiT_pirobiTi",
    "future_subjunctive__myofadis_kavSirebiTi",

    "aorist_indicative__wyvetili",
    "aorist_optative__II_kavSirebiTi",

    "perfect__I_rezultativi",
    "pluperfect__II_rezultativi",
    "perfect_subjunctive__III_kavSirebiTi",

    "imperative__brZandebiTi",
}

export.names = {
    ["present_indicative__awmyo"] = "Present indicative (აწმყო)",
    ["present_imperfect__uwyveteli"] = "Present imperfect (უწყვეტელი)",
    ["present_subjunctive__awmyos_kavSirebiTi"] = "Present subjunctive (აწმყოს კავშირებითი)",

    ["future_indicative__myofadi"] = "Future indicative (მყოფადი)",
    ["future_conditional__xolmeobiT_pirobiTi"] = "Future conditional (ხოლმეობითი პირობითი)",
    ["future_subjunctive__myofadis_kavSirebiTi"] = "Future subjunctive (მყოფადის კავშირებითი)",

    ["aorist_indicative__wyvetili"] = "Aorist indicative (წყვეტილი)",
    ["aorist_optative__II_kavSirebiTi"] = "Aorist optative (II კავშირებითი)",

    ["perfect__I_rezultativi"] = "Perfect (I რესულტატივი)",
    ["pluperfect__II_rezultativi"] = "Pluperfect (II რესულტატივი)",
    ["perfect_subjunctive__III_kavSirebiTi"] = "Perfect subjunctive (III კავშირებითი)",

    ["imperative__brZandebiTi"] = "Imperative (ბრძანებითი)",
}

function export:validate()
    for _, screeve in pairs(export.order) do
        if self[screeve] == nil then
            error("ERROR 0: in Screeeve '" .. screeve .. "': screeve not found")
        elseif type(self[screeve]) ~= "table" then
            error("ERROR 1: in Screeeve '" .. screeve .. "': must be a table")
        else
            for _, person in pairs({"I", "II", "III"}) do
                if self[screeve][person] == nil or type(self[screeve][person]) ~= "table" then
                    error("ERROR 2: in Screeeve '" .. screeve .. "', person '" .. person .. "': must be a table")
                else
                    for _, number in pairs({"singular", "plural"}) do
                        if self[screeve][person][number] == nil then
                            error("ERROR 3: in Screeeve '" .. screeve .. "', person '" .. person .. "', number '" .. number .. "': value is null")
                        elseif type(self[screeve][person][number]) ~= "string" then
                            error("ERROR 4: in Screeeve '" .. screeve .. "', person '" .. person .. "', number '" .. number .. "': value is not a string")
                        end
                    end
                end
            end
        end
    end
end

return export
