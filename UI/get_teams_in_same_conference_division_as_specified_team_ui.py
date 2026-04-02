import streamlit as st
from fetch_data import fetch_data

def get_teams_in_same_conference_division_as_specified_team_ui():
    st.markdown("""
        <style>
            .tool-card {
                background-color: #0f172a;
                padding: 1.1rem 1.25rem 0.9rem 1.25rem;
                border-radius: 16px;
                border: 1px solid rgba(255,255,255,0.08);
                margin-bottom: 0.75rem;
                text-align: center;
            }
            .tool-title {
                font-size: 1.6rem;
                font-weight: 700;
                margin-bottom: 0;
                line-height: 1.3;
            }
            div[data-testid="stForm"] {
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 10px;
                padding: 0.75rem 0.75rem 0.5rem 0.75rem;
                background: transparent;
            }
            div[data-testid="stSuccess"] {
                margin-top: 0.75rem;
                margin-bottom: 0.75rem;
            }
        </style>
    """, unsafe_allow_html=True)

    left_space, center_col, right_space = st.columns([1.15, 2.2, 1.15])

    teams = [
        "Baltimore Ravens",
        "Cincinnati Bengals",
        "Cleveland Browns",
        "Pittsburgh Steelers",
        "Buffalo Bills",
        "Miami Dolphins",
        "New England Patriots",
        "New York Jets",
        "Houston Texans",
        "Indianapolis Colts",
        "Jacksonville Jaguars",
        "Tennessee Titans",
        "Denver Broncos",
        "Kansas City Chiefs",
        "Las Vegas Raiders",
        "Los Angeles Chargers",
        "Chicago Bears",
        "Detroit Lions",
        "Green Bay Packers",
        "Minnesota Vikings",
        "Dallas Cowboys",
        "New York Giants",
        "Philadelphia Eagles",
        "Washington Commanders",
        "Atlanta Falcons",
        "Carolina Panthers",
        "New Orleans Saints",
        "Tampa Bay Buccaneers",
        "Arizona Cardinals",
        "Los Angeles Rams",
        "San Francisco 49ers",
        "Seattle Seahawks"
    ]

    with center_col:
        st.markdown("""
            <div class="tool-card">
                <div class="tool-title">Get Teams in Same Conference and Division</div>
            </div>
        """, unsafe_allow_html=True)

        with st.form("same_division_form"):
            team_name = st.selectbox("Select Team", teams)
            submitted = st.form_submit_button("Fetch Teams", use_container_width=True)

        if submitted:
            input_params = {
                "team_name": team_name.strip()
            }

            df = fetch_data("get_teams_in_same_conference_division_as_specified_team", input_params)

            if df is not None and not df.empty:
                df = df.rename(columns={
                    "TeamName": "Team",
                    "TeamColors": "Colors"
                })

                if "Team" in df.columns:
                    df = df.sort_values(by="Team")

                

                st.success(f"Found {len(df)} teams")
                st.subheader(f"Teams in the same conference and division as {team_name}")

                if "Colors" in df.columns:
                    st.dataframe(
                        df[["Team", "Colors"]],
                        use_container_width=True,
                        hide_index=True
                    )
                else:
                    st.dataframe(
                        df,
                        use_container_width=True,
                        hide_index=True
                )
            else:
                st.info(f"No teams found in the same conference and division as {team_name}.")