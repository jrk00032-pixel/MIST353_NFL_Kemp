import streamlit as st
from fetch_data import post_data, get_data
from datetime import date, time


if "app_user_id" not in st.session_state:
    st.session_state.app_user_id = None

if "app_user_fullname" not in st.session_state:
    st.session_state.app_user_fullname = None

if "app_user_role" not in st.session_state:
    st.session_state.app_user_role = None


def schedule_game_ui():
    if st.session_state.app_user_role is None:
        st.warning("Please log in first using the Validate User Login option.")
        return

    if st.session_state.app_user_role != "NFLAdmin":
        st.error("Only NFLAdmin users can schedule games.")
        st.info(f"Your current role: {st.session_state.app_user_role}")
        return

    st.header("Schedule a Game")

    teams_df = get_data("get_all_teams")
    stadiums_df = get_data("get_all_stadiums")

    if teams_df.empty:
        st.error("No teams found.")
        return

    if stadiums_df.empty:
        st.error("No stadiums found.")
        return

    game_rounds = ["Wild Card", "Divisional", "Conference", "Super Bowl"]

    team_options = dict(zip(teams_df["TeamName"], teams_df["TeamID"]))
    stadium_options = dict(zip(stadiums_df["StadiumName"], stadiums_df["StadiumID"]))

    home_team_name = st.selectbox("Select Home Team", options=list(team_options.keys()))
    away_team_name = st.selectbox("Select Away Team", options=list(team_options.keys()))
    stadium_name = st.selectbox("Select Stadium", options=list(stadium_options.keys()))
    game_round = st.selectbox("Select Game Round", options=game_rounds)

    game_date = st.date_input("Select Game Date", min_value=date.today())
    game_start_time = st.time_input("Select Game Start Time", value=time(13, 0))

    if st.button("Schedule Game"):
        if home_team_name == away_team_name:
            st.warning("Home team and away team cannot be the same.")
            return

        parameters = {
            "home_team_id": int(team_options[home_team_name]),
            "away_team_id": int(team_options[away_team_name]),
            "game_round": game_round,
            "game_date": game_date.isoformat(),
            "game_start_time": game_start_time.isoformat(),
            "stadium_id": int(stadium_options[stadium_name]),
            "nfl_admin_id": int(st.session_state.app_user_id)
        }

        response = post_data("schedule_game", parameters)

        if response and "status_message" in response:
            if "Error" in response["status_message"]:
                st.error(response["status_message"])
            else:
                st.success(response["status_message"])
        else:
            st.error("An error occurred while scheduling the game.")