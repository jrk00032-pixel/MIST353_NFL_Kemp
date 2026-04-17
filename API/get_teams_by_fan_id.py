from get_db_connection import get_db_connection

def get_teams_by_fan_id(nfl_fan_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute(
        "EXEC dbo.procGetTeamsByFanID %s",
        (nfl_fan_id,)
    )

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    results = [
        {
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"],
            "TeamColors": row["TeamColors"],
            "PrimaryTeam": row["PrimaryTeam"]
        }
        for row in rows
    ]

    return {"data": results}