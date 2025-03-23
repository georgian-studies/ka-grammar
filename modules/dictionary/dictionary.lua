local export = {}

local json = require("dkjson")
local conjugation_generator = require("modules/verb/conjugation_generator")
local verb_views = require("modules/verb/views")

function export.generate(path_to_dictionary_json, path_to_output_html)
    local f = io.open(path_to_dictionary_json, "r")
    local content = f:read("*a")
    f:close()

    local dictionary, _, err = json.decode(content, 1, nil)
    if err then
      error("Error parsing JSON: " .. err)
    end

    local html_output = {}
    table.insert(html_output, "<!DOCTYPE html>")
    table.insert(html_output, "<html lang='en'>")
    table.insert(html_output, "<head>")
    table.insert(html_output, "<meta charset='utf-8'/>")
    table.insert(html_output, "<title>Georgian Verb Conjugations</title>")
    table.insert(html_output, "</head>")
    table.insert(html_output, "<body>")
    table.insert(html_output, "<h1>Georgian Verb Conjugations</h1>")
    for word, entry in pairs(dictionary) do
        if word ~= "__template__" then
            local forms = conjugation_generator.generate(entry.root, entry.preverb, entry.thematic_suffix)

            table.insert(html_output, "<details>")
            table.insert(html_output, "<summary>" .. word .. "</summary>")    -- the clickable summary

            local forms_html = verb_views.render_html(forms)
            table.insert(html_output, forms_html)

            table.insert(html_output, "</details>")
        end
    end

    table.insert(html_output, "</body>")
    table.insert(html_output, "</html>")

    local out = table.concat(html_output, "\n")
    local of = io.open(path_to_output_html, "w")
    of:write(out)
    of:close()

    print("HTML generated and written to output.html")
end

return export