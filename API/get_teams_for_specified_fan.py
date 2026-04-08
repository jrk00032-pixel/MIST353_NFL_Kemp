from get_db_connection import get_db_connection

def get_teams_for_specified_fan(nfl_fan_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("{call procGetTeamsForSpecifiedFan(?)}", (nfl_fan_id,))
        rows = cursor.fetchall()

        results = []
        for row in rows:
            results.append({
                "TeamName": row.TeamName,
                "Conference": row.Conference,
                "Division": row.Division,
                "TeamColors": row.TeamColors
            })

        return {"data": results}

    except Exception as e:
        return {"error": str(e)}

    finally:
        conn.close()