import streamlit as st
from fetch_data import post_data


def schedule_game_ui():
    st.header("Schedule a Game")

    home_team_id = st.number_input(
        "Enter Home Team ID:",
        min_value=1,
        step=1
    )

    away_team_id = st.number_input(
        "Enter Away Team ID:",
        min_value=1,
        step=1
    )

    game_round = st.selectbox(
        "Select Game Round:",
        ["Wild Card", "Divisional", "Conference Championship", "Super Bowl"]
    )

    game_date = st.date_input("Select Game Date:")

    game_time = st.text_input(
        "Enter Game Time:",
        value="15:30:00",
        help="Format: HH:MM:SS (example: 15:30:00)"
    )

    stadium_id = st.number_input(
        "Enter Stadium ID:",
        min_value=1,
        step=1
    )

    nfl_admin_id = st.number_input(
        "Enter NFL Admin ID:",
        min_value=1,
        step=1
    )

    if st.button("Schedule Game"):
        result = post_data(
            "schedule_game/",
            {
                "home_team_id": home_team_id,
                "away_team_id": away_team_id,
                "game_round": game_round,
                "game_date": str(game_date),
                "game_time": game_time,
                "stadium_id": stadium_id,
                "nfl_admin_id": nfl_admin_id
            },
            method="POST"
        )

        if "status_message" in result:
            if "successfully" in result["status_message"]:
                st.success(result["status_message"])
            else:
                st.error(result["status_message"])
        else:
            st.write(result)