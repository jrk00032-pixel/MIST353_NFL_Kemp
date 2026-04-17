import streamlit as st
from fetch_data import fetch_data

def get_teams_by_fan_id_ui():
    st.header("Fan's Favorite Teams")

    app_user_id = st.session_state.get("app_user_id")

    if app_user_id is None or app_user_id == "":
        st.warning("No fan ID found in session. Please log in first.")
        return

    input_parameters = {
        "nfl_fan_id": int(app_user_id)
    }

    st.text_input("Fan ID", value=str(app_user_id), disabled=True)

    df = fetch_data("get_teams_by_fan_id/", input_parameters)

    if df is not None and not df.empty:
        st.dataframe(df, use_container_width=True, hide_index=True)
    else:
        st.info("No teams found for the specified fan.")