

import streamlit as st
from fetch_data import fetch_data

def validate_user_ui():
    st.markdown("""
        <style>
            .tool-card {
                background-color: #0f172a;
                padding: 1.1rem 1.25rem 0.9rem 1.25rem;
                border-radius: 16px;
                border: 1px solid rgba(255,255,255,0.08);
                margin-bottom: 1rem;
                text-align: center;
            }
            .tool-title {
                font-size: 1.6rem;
                font-weight: 700;
                margin-bottom: 0;
                line-height: 1.3;
            }
            .tool-subtitle {
                color: #94a3b8;
                font-size: 0.95rem;
                margin-bottom: 0;
            }
            div[data-testid="stForm"] {
                border: none;
                padding: 0;
                background: transparent;
            }
            div[data-testid="stSuccess"] {
                margin-top: 0.75rem;
                margin-bottom: 0.75rem;
            }
            div[data-testid="stError"] {
                margin-top: 0.75rem;
                margin-bottom: 0.75rem;
            }
        </style>
    """, unsafe_allow_html=True)

    left_space, center_col, right_space = st.columns([1.15, 2.2, 1.15])

    with center_col:
        st.markdown("""
            <div class="tool-card">
                <div class="tool-title">Validate User Login</div>
            </div>
        """, unsafe_allow_html=True)

        with st.form("validate_user_form"):
            email = st.text_input("Email")
            password_hash = st.text_input("Password Hash", type="password")

            submitted = st.form_submit_button("Validate User", use_container_width=True)

        if submitted:
            input_params = {
                "email": email.strip(),
                "password_hash": password_hash.strip()
            }

            df = fetch_data("validate_user", input_params)

            if df is not None and not df.empty:
                df = df.rename(columns={
                    "AppUserID": "User ID",
                    "FullName": "Full Name",
                    "UserRole": "User Role"
                })

                st.success("User validated successfully")
                st.subheader("Validated User")

                st.dataframe(
                    df,
                    use_container_width=True,
                    hide_index=True
                )

            else:
                st.error("Invalid login or no user found.")


