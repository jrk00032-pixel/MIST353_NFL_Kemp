from fastapi import FastAPI
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division import get_teams_in_same_conference_division

app = FastAPI()

@app.get("/teams")
def read_teams(conference: str = None, division: str = None):
    return get_teams_by_conference_division(conference, division)

@app.get("/get_teams_in_same_conference_division_as_specified_team")
def get_teams_in_same_conference_division_api(team_name: str):
    try:
        return get_teams_in_same_conference_division(team_name)
    except Exception as e:
        return {"error": str(e)}