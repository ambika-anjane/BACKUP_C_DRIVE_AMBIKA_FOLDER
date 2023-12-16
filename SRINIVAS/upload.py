
import os
from dotenv import load_dotenv
import requests

# Load environment variables from .env file
# Specify the path to the .env file
env_path = "C:/ambika/SRINIVAS/env.env"
res = load_dotenv(dotenv_path=env_path)

print(res)

# Get values from environment variables
url = os.getenv("UPLOAD_URL")
print(url)
file_path = os.getenv("FILE_PATH")
print(file_path)

# Check if URL and file path are present
if not url or not file_path:
    print("URL or file path not specified in .env file.")
    exit()

# Open the file in binary mode
with open(file_path, "rb") as file:
    # Use the requests library to perform a POST request with the file
    response = requests.post(url, files={"file": (os.path.basename(file_path), file)})

# Check the response
if response.status_code == 200:
    print("File uploaded successfully")
else:
    print(f"Error uploading file. Status code: {response.status_code}, Response: {response.text}")
