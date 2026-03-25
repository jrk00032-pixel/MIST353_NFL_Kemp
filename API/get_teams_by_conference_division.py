from get_db_connection import get_db_connection

def get_teams_by_conference_division(conference=None, division=None):
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT TeamName, Conference, Division, TeamColors
        FROM dbo.Team t
        INNER JOIN dbo.ConferenceDivision cd
            ON t.ConferenceDivisionID = cd.ConferenceDivisionID
        WHERE (? IS NULL OR cd.Conference = ?)
          AND (? IS NULL OR cd.Division = ?)
        ORDER BY TeamName
    """

    cursor.execute(query, conference, conference, division, division)
    rows = cursor.fetchall()

    data = []
    for row in rows:
        data.append({
            "TeamName": row.TeamName,
            "Conference": row.Conference,
            "Division": row.Division,
            "TeamColors": row.TeamColors
        })

    conn.close()
    return {"data": data}