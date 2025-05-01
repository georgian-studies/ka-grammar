import json
import re
import html
from modules.grammar.views import render_noun_html, render_verb_html
from modules.grammar.noun.noun import generate_declension
from modules.grammar.verb.verb import generate_conjugation

def load_jsonc(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    content = re.sub(r'//.*$', '', content, flags=re.MULTILINE)
    return json.loads(content)

def generate(path_to_dictionary_json, path_to_output_html):
    dictionary = load_jsonc(path_to_dictionary_json)
    html_output = []
    html_output.append("<!DOCTYPE html>")
    html_output.append("<html lang=\\en>")
    html_output.append("<head>")
    html_output.append("  <meta charset=\\utf-8/>")
    html_output.append("  <meta name=\\viewport content=\\width=device-width, initial-scale=1/>")
    html_output.append("  <script src=\\https://cdn.tailwindcss.com></script>")
    html_output.append("  <title>Georgian Grammar Dictionary</title>")
    html_output.append("</head>")
    html_output.append("<body class=\\bg-gray-100 font-sans antialiased>")
    html_output.append("  <main class=\\max-w-6xl mx-auto p-6>")
    html_output.append("    <h1 class=\\text-3xl md\\:text-4xl font-bold text-center text-indigo-700 mb-10>")
    html_output.append("      Georgian Verb Conjugations &amp; Noun Declensions")
    html_output.append("    </h1>")
    for word, entry in dictionary.items():
        if word == "__template__":
            continue
        part = entry.get("part_of_speech")
        if part == "noun":
            forms = generate_declension(entry)
            forms_html = render_noun_html(forms)
        elif part == "verb":
            forms = generate_conjugation(entry)
            forms_html = render_verb_html(forms)
        else:
            continue
        entry_json = html.escape(json.dumps(entry, indent=2))
        pre_id = "json-" + word
        html_output.append("    <details class=\\mb-4 rounded-lg shadow bg-white>")
        html_output.append("      <summary class=\\cursor-pointer select-none p-4 border-b font-medium text-lg text-indigo-600 hover\\:bg-indigo-50>")
        html_output.append(f"        {part}  —  {word}")
        html_output.append("      </summary>")
        html_output.append("      <div class=\\p-4 overflow-x-auto text-sm prose max-w-none>")
        html_output.append("        <details class=\\mb-6>")
        html_output.append("          <summary class=\\flex justify-end items-center gap-2 text-xs text-slate-500 hover\\:text-slate-700 cursor-pointer>")
        html_output.append("            <span class=\\underline>JSON config</span>")
        html_output.append(f"            <button type=\\button onclick=\\\"copyJson('{pre_id}')\\\" class=\\\"border border-slate-300 rounded px-2 py-px text-[10px] hover\\:bg-slate-50\\\">Copy</button>")
        html_output.append("          </summary>")
        html_output.append(f"          <pre id=\\'{pre_id}\\' class=\\\"bg-slate-100 rounded p-3 mt-3 overflow-x-auto text-xs leading-relaxed\\\"><code class=\\\"whitespace-pre\\\">{entry_json}</code></pre>")
        html_output.append("        </details>")
        html_output.append(forms_html)
        html_output.append("      </div>")
        html_output.append("    </details>")
    html_output.append("  </main>")
    html_output.append((\'\'\'
  <script>
  function copyJson(id) {
    const el = document.getElementById(id);
    if (!el) return;
    navigator.clipboard.writeText(el.innerText.trim())
      .then(() => console.log('JSON copied: ' + id))
      .catch(err => console.error('Copy failed', err));
  }
  </script>
(\'\'\')
    html_output.append("</body>")
    html_output.append("</html>")
    with open(path_to_output_html, "w", encoding="utf-8") as f:
        f.write("\n".join(html_output))
    print(f"HTML generated and written to {path_to_output_html}")

if __name__ == "__main__":
    generate("modules/dictionary/dictionary.jsonc", "modules/dictionary/dictionary.html")
