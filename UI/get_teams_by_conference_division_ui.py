import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    st.title("Get Teams by Conference and Division")

    conference = st.selectbox("Select Conference", ["AFC", "NFC"])
    division = st.selectbox("Select Division", ["North", "South", "East", "West"])

    if st.button("Fetch Conference/Division Teams"):
        input_params = {
            "conference": conference,
            "division": division
        }

        df = fetch_data("teams", input_params)

        if df is not None and not df.empty:
            st.success(f"Found {len(df)} teams")
            st.subheader(f"Teams in {conference} {division}")
            st.dataframe(df, use_container_width=True, hide_index=True)

            for _, row in df.iterrows():
                colors = row["TeamColors"].split(",")

                color_boxes = ""
                for c in colors:
                    raw_color = c.strip().lower()

                    color_map = {
                        "purple": "#4B0082",
                        "black": "black",
                        "white": "white",
                        "orange": "orange",
                        "brown": "brown",
                        "red": "red",
                        "gold": "gold",
                        "metallic gold": "#D4AF37",
                        "royal blue": "#4169E1",
                        "navy blue": "#000080",
                        "deep steel blue": "#4682B4",
                        "battle red": "#7C0A02",
                        "liberty white": "#F5F5F5",
                        "panther blue": "#0085CA",
                        "titans navy": "#0C2340",
                        "titans light blue": "#4B92DB",
                        "powder blue": "#B0E0E6",
                        "midnight green": "#004953",
                        "action green": "#00FF00",
                        "wolf grey": "#8C92AC",
                        "scarlet red": "#FF2400"
                    }

                    color = color_map.get(raw_color, raw_color)
                    color_boxes += f"<span style='display:inline-block;width:20px;height:20px;background:{color};margin-right:5px;'></span>"

                st.markdown(
                    f"""
                    <div style="margin-bottom:10px;">
                        <strong>{row['TeamName']}</strong><br>
                        {color_boxes}
                    </div>
                    """,
                    unsafe_allow_html=True
)

        else:
            st.info(f"No teams found for {conference} {division}.")