import re
import requests
import json


def update_nether_info(file_path, nether_info):
    patterns = {
        'distance': r'(Distance\s*=\s*)-?\d+(,?)',
        'x': r'(X\s*=\s*)-?\d+(,?)',
        'z': r'(Z\s*=\s*)-?\d+(,?)'
    }

    with open(file_path, 'r') as file:
        file_content = file.read()

    file_content = re.sub(patterns['distance'], lambda m: f"{m.group(1)}{nether_info['Distance']}{m.group(2)}", file_content)
    file_content = re.sub(patterns['x'],       lambda m: f"{m.group(1)}{nether_info['X']}{m.group(2)}", file_content)
    file_content = re.sub(patterns['z'],       lambda m: f"{m.group(1)}{nether_info['Z']}{m.group(2)}", file_content)

    with open(file_path, 'w') as file:
        file.write(file_content)

    print("File updated successfully!")


# Fetch and parse the API response
try:
    res = requests.get('http://localhost:52533/api/v1/stronghold').text
    data = json.loads(res)

    preds = data.get('predictions', [])

    nether_info = {
        'Distance': 0,
        'X': 0,
        'Z': 0
    }

    for pred in preds:
        if pred['certainty'] > 0.99:
            nether_info = {
                'Distance': int(pred['overworldDistance'] / 8),
                'X': pred['chunkX'] * 2,
                'Z': pred['chunkZ'] * 2
            }
            break

except Exception as e:
    print("Error fetching or processing data:", e)
    nether_info = {
        'Distance': 0,
        'X': 0,
        'Z': 0
    }

# Update the file
file_path = "/home/arjungore/.config/waywall/nether_info.lua"
update_nether_info(file_path, nether_info)
