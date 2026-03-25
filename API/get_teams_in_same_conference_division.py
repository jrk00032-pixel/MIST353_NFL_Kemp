from get_db_connection import get_db_connection

def get_teams_in_same_conference_division(team_name):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        "EXEC dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName = ?",
        team_name
    )

    rows = cursor.fetchall()

    data = []
    for row in rows:
        data.append({
            "TeamName": row[0],
            "Conference": row[1],
            "Division": row[2]
        })

    conn.close()
    return {"data": data}