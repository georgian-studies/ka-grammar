local export = {}

local json = require("vendors/dkjson")
local conjugation_generator = require("modules/grammar/verb/conjugation_generator")
local declension_generator = require("modules/grammar/noun/declension_generator")
local views = require("modules/grammar/views")

local function html_escape(str)
    return str
        :gsub("&",  "&amp;")
        :gsub("<",  "&lt;")
        :gsub(">",  "&gt;")
end

local function strip_internal_keys(tbl)
    if type(tbl) ~= "table" then return tbl end
    local out = {}
    for k, v in pairs(tbl) do
        if k ~= "__ordered_keys" then
            out[k] = strip_internal_keys(v)
        end
    end
    return out
end

local function decode_dict_with_keys_order(jsonStr)

    local objectmeta = {
      __newindex = function(t, key, value)
        rawset(t, key, value)
        local keys = rawget(t, "__ordered_keys") or {}
        rawset(t, "__ordered_keys", keys)
        table.insert(keys, key)
      end
    }

    local result, _, err = json.decode(jsonStr, 1, nil, objectmeta)
    if err then
      error("Error parsing JSON: " .. err)
    end

    return result
end

function export.generate(path_to_dictionary_json, path_to_output_html)
    local f = io.open(path_to_dictionary_json, "r")
    local content = f:read("*a")
    f:close()

    local html_output = {}
    local add  = function(s) table.insert(html_output, s) end

    add("<!DOCTYPE html>")
    add("<html lang='en'>")
    add("<head>")
    add("  <meta charset='utf-8'/>")
    add("  <meta name='viewport' content='width=device-width, initial-scale=1'/>")
    add("  <script src='https://cdn.tailwindcss.com'></script>")
    add("  <title>Georgian Verb &amp; Noun Dictionary</title>")
    add("</head>")
    add("<body class='bg-gray-100 font-sans antialiased'>")
    add("  <main class='max-w-6xl mx-auto p-6'>")
    add("    <h1 class='text-3xl md:text-4xl font-bold text-center text-indigo-700 mb-10'>")
    add("      Georgian Verb Conjugations &amp; Noun Declension Dictionary")
    add("    </h1>")

    local dictionary = decode_dict_with_keys_order(content)

    for _, word in ipairs(dictionary.__ordered_keys) do
        if word ~= "__template__" then
            local entry = dictionary[word]
            local forms_html

            if entry.part_of_speech == "verb" then
                local forms = conjugation_generator.generate_from_dict(entry)
                forms_html = views.render_verb_html(forms)
            elseif entry.part_of_speech == "noun" then
                local forms = declension_generator.generate_from_dict(entry)
                forms_html = views.render_noun_html(forms)
            else
                goto continue
            end

            local clean_entry = strip_internal_keys(entry)
            local entry_json = html_escape(json.encode(clean_entry, { indent = true }))
            local pre_id = "json-" .. word

            add("    <details class='mb-4 rounded-lg shadow bg-white'>")
            add("      <summary class='cursor-pointer select-none p-4 border-b font-medium text-lg text-indigo-600 hover:bg-indigo-50'>")
            add("        " .. entry.part_of_speech .. " — " .. word)
            add("      </summary>")
            add("      <div class='p-4 overflow-x-auto text-sm prose max-w-none'>")
            add("        <details class='mb-6'>")
            add("          <summary class='flex justify-end items-center gap-2 text-xs text-slate-500 hover:text-slate-700 cursor-pointer'>")
            add("            <span class='underline'>JSON config</span>")
            add("            <button type='button' onclick=\"copyJson('"..pre_id.."')\"")
            add("                    class='border border-slate-300 rounded px-2 py-px text-[10px] hover:bg-slate-50'>Copy</button>")
            add("          </summary>")
            add("          <pre id='"..pre_id.."' class='bg-slate-100 rounded p-3 mt-3 overflow-x-auto text-xs leading-relaxed'><code class='whitespace-pre'>" .. entry_json .. "</code></pre>")
            add("        </details>")
            add(forms_html)
            add("      </div>")
            add("    </details>")


            ::continue::
        end
    end

    add("  </main>")
    add([[
  <script>
  function copyJson(id) {
    const el = document.getElementById(id);
    if (!el) return;
    navigator.clipboard.writeText(el.innerText.trim())
      .then(() => console.log('JSON copied: ' + id))
      .catch(err => console.error('Copy failed', err));
  }
  </script>]])
    add("</body>")
    add("</html>")

    local out = table.concat(html_output, "\n")
    local of = assert(io.open(path_to_output_html, "w"))
    of:write(out)
    of:close()

    print("HTML generated and written to " .. path_to_output_html)
end

return export