from get_db_connection import get_db_connection


def get_teams_in_same_conference_division(team_name):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute(
        "EXEC dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam %s",
        (team_name,)
    )

    rows = cursor.fetchall()

    data = []
    for row in rows:
        data.append({
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"]
        })

    cursor.close()
    conn.close()

    return {"data": data}