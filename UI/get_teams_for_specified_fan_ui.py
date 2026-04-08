import streamlit as st
import pandas as pd
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
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
                <div class="tool-title">Get Teams for Specified Fan</div>
            </div>
        """, unsafe_allow_html=True)

        with st.form("get_teams_for_specified_fan_form"):
            nfl_fan_id = st.number_input("NFL Fan ID", min_value=1, step=1)
            submitted = st.form_submit_button("Get Teams", use_container_width=True)

        if submitted:
            input_params = {
                "nfl_fan_id": int(nfl_fan_id)
            }

            df = fetch_data("get_teams_for_specified_fan", input_params)

            if df is not None and not df.empty:
                if "data" in df.columns:
                    nested_data = df.iloc[0]["data"]

                    if isinstance(nested_data, list) and len(nested_data) > 0:
                        df = pd.DataFrame(nested_data)
                    else:
                        df = pd.DataFrame()

                if df is not None and not df.empty:
                    df = df.rename(columns={
                        "TeamName": "Team",
                        "Conference": "Conference",
                        "Division": "Division",
                        "TeamColors": "Colors"
                    }).sort_values(by="Team")

                    st.success(f"Found {len(df)} teams")
                    st.subheader(f"Teams for Fan ID {int(nfl_fan_id)}")

                    st.dataframe(
                        df[["Team", "Conference", "Division", "Colors"]],
                        use_container_width=True,
                        hide_index=True
                    )
                else:
                    st.error("No teams found for that fan.")
            else:
                st.error("No teams found for that fan.")