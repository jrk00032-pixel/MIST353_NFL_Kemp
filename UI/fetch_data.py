import streamlit as st
import requests
import pandas as pd

FASTAPI_url = "https://mist353-api-kemp.azurewebsites.net" #"http://localhost:8000"

def fetch_data(endpoint: str, input_params: dict, method: str = "GET"):
    try:
        if method == "GET":
            response = requests.get(f"{FASTAPI_url}/{endpoint}", params=input_params)

            if response.status_code == 200:
                payload = response.json()

                if isinstance(payload, list):
                    return pd.DataFrame(payload)

                if isinstance(payload, dict):
                    if "data" in payload:
                        return pd.DataFrame(payload["data"])
                    if "error" in payload:
                        st.error(payload["error"])
                        return pd.DataFrame()
                    return pd.DataFrame([payload])

                return pd.DataFrame()

            else:
                st.error(f"Error fetching data: {response.status_code} - {response.text}")
                return pd.DataFrame()

        else:
            st.error("Only GET method is supported right now.")
            return pd.DataFrame()

    except Exception as e:
        st.error(f"Error: {e}")
        return pd.DataFrame()