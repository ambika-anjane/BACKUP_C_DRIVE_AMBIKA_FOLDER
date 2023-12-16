import requests

# Specify the URL where you want to upload the file
url = "https://sellercentral.amazon.com/listing/upload"

# Specify the file you want to upload
file_path = "please provide ur path here"

# Open the file in binary mode
with open(file_path, "rb") as file:
    # Create a dictionary with any additional data you want to send along with the file
    payload = {"key1": "value1", "key2": "value2"}

    # Use the requests library to perform a POST request with the file and additional data
    response = requests.post(url, files={"file": (file_path, file)}, data=payload)

# Check the response
if response.status_code == 200:
    print("File uploaded successfully")
else:
    print(f"Error uploading file. Status code: {response.status_code}, Response: {response.text}")
