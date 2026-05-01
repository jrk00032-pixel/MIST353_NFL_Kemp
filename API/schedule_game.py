from get_db_connection import get_db_connection
from datetime import date, time


def schedule_game(
    home_team_id: int,
    away_team_id: int,
    game_round: str,
    game_date: date,
    game_start_time: time,
    stadium_id: int,
    nfl_admin_id: int
):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    try:
        cursor.execute(
            """
            EXEC procScheduleGame
                @HomeTeamID=%s,
                @AwayTeamID=%s,
                @GameRound=%s,
                @GameDate=%s,
                @GameStartTime=%s,
                @StadiumID=%s,
                @NFLAdminID=%s
            """,
            (
                home_team_id,
                away_team_id,
                game_round,
                game_date,
                game_start_time,
                stadium_id,
                nfl_admin_id
            )
        )

        conn.commit()
        return {"status_message": "Game scheduled successfully."}

    except Exception as e:
        conn.rollback()

        if "Violation of UNIQUE KEY constraint" in str(e):
            return {"status_message": "Error: Game already scheduled for this date and time."}

        return {"status_message": f"Error executing stored procedure: {e}"}

    finally:
        cursor.close()
        conn.close()