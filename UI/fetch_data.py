import streamlit as st
import requests
import pandas as pd

FASTAPI_URL = "https://mist353-api-kemp.azurewebsites.net"  #"http://localhost:8000"  


def get_data(endpoint: str, input_params: dict = None) -> pd.DataFrame:
    if input_params is None:
        input_params = {}

    url = f"{FASTAPI_URL.rstrip('/')}/{endpoint.lstrip('/')}"

    try:
        response = requests.get(url, params=input_params)

        if response.status_code == 200:
            payload = response.json()

            if isinstance(payload, dict):
                rows = payload.get("data", payload)
                if isinstance(rows, list):
                    return pd.DataFrame(rows)
                return pd.DataFrame([rows])

            if isinstance(payload, list):
                return pd.DataFrame(payload)

            return pd.DataFrame()

        st.error(f"Error fetching data: {response.status_code}")
        return pd.DataFrame()

    except Exception as e:
        st.error(f"Error connecting to API: {e}")
        return pd.DataFrame()


def post_data(endpoint: str, input_params: dict = None) -> dict:
    if input_params is None:
        input_params = {}

    url = f"{FASTAPI_URL.rstrip('/')}/{endpoint.lstrip('/')}"

    try:
        response = requests.post(url, json=input_params)

        if response.status_code == 200:
            return response.json()

        try:
            error_details = response.json()
            return {"status_message": f"Error: {error_details}"}
        except:
            return {"status_message": f"Error: {response.text}"}

    except Exception as e:
        return {"status_message": f"Error connecting to API: {e}"}


def fetch_data(endpoint: str, input_params: dict = None):
    return get_data(endpoint, input_params)