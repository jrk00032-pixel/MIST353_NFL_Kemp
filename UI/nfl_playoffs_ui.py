import streamlit as st
from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui
from validate_user_ui import validate_user_ui
from get_teams_for_specified_fan_ui import get_teams_for_specified_fan_ui



st.set_page_config(layout="centered")

st.markdown("""
    <div style="text-align: center; margin-bottom: 1.5rem;">
        <h1 style="margin-bottom: 0.25rem; font-weight: 700;">NFL Playoffs App</h1>
        <p style="color: #94a3b8; margin-top: 0; font-size: 0.95rem;">
            NFL teams made simple.
        </p>
    </div>
""", unsafe_allow_html=True)

st.sidebar.title("NFL Playoff Functionalities")

api_endpoint = st.sidebar.selectbox(
    "Select a functionality:",
    [
        "Get Teams by Conference and Division",
        "Get Teams in Same Conference and Division",
        "Validate User Login",
        "Get Teams for Specified Fan"
    ]
)

if api_endpoint == "Get Teams by Conference and Division":
    get_teams_by_conference_division_ui()

elif api_endpoint == "Get Teams in Same Conference and Division":
    get_teams_in_same_conference_division_as_specified_team_ui()

elif api_endpoint == "Validate User Login":
    validate_user_ui()

elif api_endpoint == "Get Teams for Specified Fan":
    get_teams_for_specified_fan_ui() 