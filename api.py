import json
import logging
import subprocess
from typing import Optional

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn

app = FastAPI(
    title="Georgian Grammar",
    description="An API that offers Georgian verbs conjugation.",
    version="0.0.1",
)

class WordModel(BaseModel):
    part_of_speech: str
    root: str
    preverb: Optional[str]
    thematic_suffix: Optional[str]

@app.post("/forms")
def get_forms(request: WordModel):

    payload_json = request.model_dump_json()

    try:
        process = subprocess.Popen(
            f"wsl lua run_grammar_service.lua json '{payload_json}'",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            encoding='utf-8',
            text=True
        )
        stdout, stderr = process.communicate()
    except Exception as e:
        logging.error("Unexpected error calling Lua script", exc_info=e)
        raise HTTPException(
            status_code=500,
            detail="Unexpected error calling Lua script"
        )

    if process.returncode != 0:
        logging.error("Lua error (code %d): %s", process.returncode, stderr)
        raise HTTPException(
            status_code=400,
            detail=f"Lua error (code {process.returncode}): {stderr}"
        )

    try:
        parsed = json.loads(stdout)
    except json.JSONDecodeError as e:
        raise HTTPException(status_code=500, detail=f"Invalid JSON from Lua: {e}")

    return parsed

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
