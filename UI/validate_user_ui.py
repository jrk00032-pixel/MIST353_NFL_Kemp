import streamlit as st
from fetch_data import fetch_data

def validate_user_ui():
    st.header("Validate User Login")

    email = st.text_input("Email")
    password_hash = st.text_input("Password Hash", type="password")

    if st.button("Login"):
        input_parameters = {
            "email": email,
            "password_hash": password_hash
        }

        df = fetch_data("validate_user/", input_parameters)

        if df is not None and not df.empty:
            st.session_state.app_user_id = df.iloc[0]["AppUserID"]
            st.session_state.app_user_fullname = df.iloc[0]["FullName"]
            st.session_state.app_user_role = df.iloc[0]["UserRole"]

            st.success(f"Welcome, {st.session_state.app_user_fullname}!")
        else:
            st.error("Invalid login.")