import json
import os
import subprocess


def update_json_line_no(filename, line_no):
    # Check if the file exists
    if not os.path.exists(filename):
        print(f"File {filename} does not exist. Creating a new one.")
        # Create a new file with default values
        with open(filename, 'w') as file:
            json.dump({"LINE_NO": line_no}, file, indent=4)
    else:
        # Load the JSON file
        with open(filename, 'r+') as file:
            data = json.load(file)
            
            # Update the LINE_NO value
            data['LINE_NO'] = line_no
            
            # Move the file pointer to the beginning and overwrite the file
            file.seek(0)
            json.dump(data, file, indent=4)
            file.truncate()

# Example usage

for i in range(1,11):
    update_json_line_no('config.json', i)
    for _ in range(100):
        subprocess.run(['cargo', 'run'])