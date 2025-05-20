from dataclasses import asdict

from fastapi import FastAPI, HTTPException

from contracts import WordConfigurationDto
from src.grammar.noun import generate_noun_forms
from src.grammar.verb import generate_verb_forms

app = FastAPI(
    title="Georgian Grammar API",
    description="API for generating Georgian noun declensions and verb conjugations.",
    version="0.0.1",
)

@app.get("/forms")
def get_forms(request: WordConfigurationDto) -> dict:
    if request.part_of_speech == "noun":
        forms = generate_noun_forms(request)
        response = asdict(forms)
    elif request.part_of_speech == "verb":
        forms = generate_verb_forms(request)
        response = asdict(forms)
    else:
        raise HTTPException(status_code=400, detail=f"Unsupported part_of_speech: {request.part_of_speech}")
    return response


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)