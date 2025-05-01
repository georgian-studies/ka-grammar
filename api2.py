from flask import Flask, request, jsonify
import json
from modules.grammar.views import render_noun_html, render_verb_html
from modules.grammar.noun.noun import generate_declension
from modules.grammar.verb.verb import generate_conjugation

app = Flask(__name__)

@app.route("/generate", methods=["POST"])
def generate_word():
    data = request.get_json()
    if not data or "part_of_speech" not in data:
        return jsonify({"error": "Invalid input"}), 400
    part = data.get("part_of_speech")
    if part == "noun":
        forms = generate_declension(data)
        output = render_noun_html(forms)
    elif part == "verb":
        forms = generate_conjugation(data)
        output = render_verb_html(forms)
    else:
        return jsonify({"error": f"Unsupported part_of_speech: {part}"}), 400
    return jsonify({"result": output})

if __name__ == "__main__":
    app.run(debug=True)
