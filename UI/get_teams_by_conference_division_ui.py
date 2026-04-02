import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    st.markdown("""
        <style>
            .tool-card {
                background-color: #0f172a;
                padding: 1.1rem 1.25rem 0.9rem 1.25rem;
                border-radius: 16px;
                border: 1px solid rgba(255,255,255,0.08);
                margin-bottom: 1rem;
                text-align: center;
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
        </style>
    """, unsafe_allow_html=True)

    left_space, center_col, right_space = st.columns([1.15, 2.2, 1.15])

    with center_col:
        st.markdown("""
            <div class="tool-card">
                <div class="tool-title">Get Teams by Conference and Division</div>
            </div>
        """, unsafe_allow_html=True)

        with st.form("teams_by_division_form"):
            conference_col, division_col = st.columns(2)

            with conference_col:
                conference = st.selectbox("Conference", ["AFC", "NFC"])

            with division_col:
                division = st.selectbox("Division", ["North", "South", "East", "West"])

            submitted = st.form_submit_button("Search", use_container_width=True)

        if submitted:
            input_params = {
                "conference": conference,
                "division": division
            }

            df = fetch_data("teams", input_params)

            if df is not None and not df.empty:
                df = df.rename(columns={
                    "TeamName": "Team",
                    "TeamColors": "Colors"
                }).sort_values(by="Team")

                st.success(f"Found {len(df)} teams")
                st.subheader(f"Teams in {conference} {division}")

                st.dataframe(
                    df[["Team", "Colors"]],
                    use_container_width=True,
                    hide_index=True
                )

            else:
                st.info(f"No teams found for {conference} {division}.")