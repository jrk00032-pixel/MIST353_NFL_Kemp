import streamlit as st
from fetch_data import get_data

def get_teams_by_conference_division_ui():
    st.header("Get Teams by Conference and Division")

    conference = st.selectbox("Conference", ["AFC", "NFC"])
    division = st.selectbox("Division", ["North", "South", "East", "West"])

    if st.button("Search"):
        input_parameters = {
            "conference": conference,
            "division": division
        }

        df = get_data("get_teams_by_conference_division/", input_parameters)

        if df is not None and not df.empty:
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.info(f"No teams found for {conference} {division}.")