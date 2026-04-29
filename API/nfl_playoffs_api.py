from fastapi import FastAPI
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division import get_teams_in_same_conference_division
from validate_user import validate_user
from get_teams_for_specified_fan import get_teams_for_specified_fan
from schedule_game import schedule_game
import datetime
import pymssql



app = FastAPI()

@app.get("/get_teams_by_conference_division")
def get_teams_by_conference_division_api(conference: str = None, division: str = None):
    return get_teams_by_conference_division(conference, division)

@app.get("/get_teams_in_same_conference_division_as_specified_team")
def get_teams_in_same_conference_division_api(team_name: str):
    try:
        return get_teams_in_same_conference_division(team_name)
    except Exception as e:
        return {"error": str(e)}
    
@app.get("/validate_user")
def validate_user_api(email: str, password_hash: str):
    return validate_user(email=email, password_hash=password_hash)


@app.get("/get_teams_for_specified_fan")
def get_teams_for_specified_fan_api(nfl_fan_id: int):
    return get_teams_for_specified_fan(nfl_fan_id)

@app.post("/schedule_game")
def schedule_game_api(
    home_team_id: int,
    away_team_id: int,
    game_round: str,
    game_date: datetime.date,
    game_time: datetime.time,
    stadium_id: str,
    nfl_admin_id: int
):
    return schedule_game(
        home_team_id=home_team_id,
        away_team_id=away_team_id,
        game_round=game_round,
        game_date=game_date,
        game_time=game_time,
        stadium_id=stadium_id,
        nfl_admin_id=nfl_admin_id
    )
