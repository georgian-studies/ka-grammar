import json
import os
import re
from pathlib import Path
from typing import Final

from jinja2 import Environment, DictLoader, select_autoescape

from contracts import WordConfigurationDto
from grammar.noun import generate_noun_forms
from src.grammar.views import render_noun_html, render_verb_html
from src.grammar.verb import generate_verb_forms


_TEMPLATES: Final[dict[str, str]] = {
    # --- outer page ------------------------------------------------------ #
    "page.html": r"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <script src="https://cdn.tailwindcss.com"></script>
  <title>Georgian Grammar Dictionary</title>
</head>
<body class="bg-gray-100 font-sans antialiased">
  <main class="max-w-6xl mx-auto p-6">
    <h1 class="text-3xl md:text-4xl font-bold text-center mb-10">
      Georgian Verb Conjugations &amp; Noun Declensions
    </h1>

    {% for card in cards %}
      {{ card|safe }}
    {% endfor %}

  </main>
  <script>
    function copyJson(id) {
      const el = document.getElementById(id);
      if (!el) return;
      navigator.clipboard.writeText(el.innerText.trim())
        .then(() => console.log('JSON copied: ' + id))
        .catch(err => console.error('Copy failed', err));
    }
  </script>
</body>
</html>
""",
    # --- one dictionary entry ------------------------------------------- #
    "entry.html": r"""
<details class="mb-4 rounded-lg shadow bg-white">
  <summary class="cursor-pointer select-none p-4 border-b font-medium text-lg text-indigo-600 hover:bg-indigo-50">
    {{ part }}  —  {{ word }}
  </summary>

  <div class="p-4 overflow-x-auto text-sm prose max-w-none">
    <details class="mb-6">
      <summary class="flex justify-end items-center gap-2 text-xs text-slate-500 hover:text-slate-700 cursor-pointer">
        <span class="underline">JSON config</span>
        <button type="button"
                onclick="copyJson('{{ content_id }}')"
                class="border border-slate-300 rounded px-2 py-px text-[10px] hover:bg-slate-50">
          Copy
        </button>
      </summary>
      <div id="{{ content_id }}>
        <pre"
           class="bg-slate-100 rounded p-3 mt-3 overflow-x-auto text-xs leading-relaxed"><code class="whitespace-pre">{{ entry_json }}</code></pre>
      </div>
    </details>

    {{ forms_html|safe }}
  </div>
</details>
""",
}

_env = Environment(
    loader=DictLoader(_TEMPLATES),
    autoescape=select_autoescape(("html", "xml")),
    trim_blocks=True,
    lstrip_blocks=True,
)


def _load_jsonc(path: str | Path) -> dict[str, WordConfigurationDto]:
    text = Path(path).read_text(encoding="utf-8")
    text = re.sub(r"//.*$", "", text, flags=re.MULTILINE)
    json_dict = json.loads(text)
    return {word: WordConfigurationDto(**entry_data) for word, entry_data in json_dict.items()}


def _render_entry(word: str, entry: WordConfigurationDto) -> str:
    part = entry.part_of_speech
    if part == "noun":
        forms_html = render_noun_html(generate_noun_forms(entry))
    elif part == "verb":
        forms_html = render_verb_html(generate_verb_forms(entry))
    else:
        raise ValueError(f"Unsupported part_of_speech: {part}")

    tmpl = _env.get_template("entry.html")
    return tmpl.render(
        word=word,
        part=part,
        content_id=f"json-{word}",
        entry_json=json.dumps(entry.model_dump(exclude_none=True), indent=2, ensure_ascii=False),
        forms_html=forms_html,
    )


def generate(path_to_dictionary_json: str | Path, path_to_output_html: str | Path) -> None:

    dictionary = _load_jsonc(path_to_dictionary_json)

    cards: list[str] = [
        _render_entry(word, entry)
        for word, entry in dictionary.items()
        if word != "__template__"
    ]

    page_html = _env.get_template("page.html").render(cards=cards)

    Path(path_to_output_html).write_text(page_html, encoding="utf-8")
    print(f"HTML written → {os.path.abspath(path_to_output_html)}")


if __name__ == "__main__":
    generate(
        "../../dictionary.jsonc",
        "../../public/dictionary.html",
    )

