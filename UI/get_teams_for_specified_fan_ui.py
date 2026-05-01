import streamlit as st
from fetch_data import get_data

def get_teams_for_specified_fan_ui():

   
    if "app_user_fullname" not in st.session_state or st.session_state.app_user_fullname is None:
        st.markdown(
            "<h3 style='text-align:center;'> Login to view specified teams</h3>",
            unsafe_allow_html=True
        )
        return

  
    fan_name = st.session_state.app_user_fullname
    st.header(f"Teams associated with {fan_name}")

    input_parameters = {}

    fan_id = st.text_input(
        "Fan ID",
        value=st.session_state.app_user_id,
        disabled=True
    )

    input_parameters["nfl_fan_id"] = fan_id

    df = get_data("get_teams_for_specified_fan/", input_parameters)

    if df is not None and not df.empty:
        st.dataframe(df, use_container_width=True, hide_index=True)
    else:
        st.info("No teams found for the specified fan.")