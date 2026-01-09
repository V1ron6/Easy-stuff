import json
import time
import subprocess
from datetime import datetime, timezone

TOKEN_PATH = "E:\\DeadHand\\auth.json"  # Adjust drive letter if needed
DEADHAND_KEY = "DEADHAND_AUTH_CODE_2006"
EXPIRATION_MINUTES = 5

def is_valid_token(data):
    try:
        if data["key"] != DEADHAND_KEY:
            print("Invalid key.")
            return False
        token_time = datetime.fromisoformat(data["timestamp"]).replace(tzinfo=timezone.utc)
        current_time = datetime.utcnow().replace(tzinfo=timezone.utc)
        delta = (current_time - token_time).total_seconds()
        if delta > EXPIRATION_MINUTES * 60:
            print(f"Token expired. ({int(delta)} seconds old)")
            return False
        return True
    except Exception as e:
        print(f"Token validation error: {e}")
        return False

def main():
    print("Waiting for USB key...");
    while True:
        try:
            with open(TOKEN_PATH, "r") as f:
                data = json.load(f)
            if is_valid_token(data):
                print("Token valid. Running trial version...")
                subprocess.call(["deadhand_trial.bat"])
                break
            else:
                print("Token invalid or expired.")
        except FileNotFoundError:
            pass
        time.sleep(5)

if __name__ == "__main__":
    main()
