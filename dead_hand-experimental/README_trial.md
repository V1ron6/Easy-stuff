Dead Hand USB Key Protocol - Trial Version
============================================

Files included:
- auth_listener_trial.py    : Python script that listens for the USB auth token
- deadhand_trial.bat        : Trial batch script that displays a message instead of destructive actions
- generate_auth.sh          : Android (Termux) script to create auth.json token
- README_trial.txt          : This file

Usage:
------
1. On your Android phone:
   - Run generate_auth.sh in Termux to create auth.json token.

2. On your PC (Windows 11 VM):
   - Place auth_listener_trial.py and deadhand_trial.bat in the same folder.
   - Adjust TOKEN_PATH in auth_listener_trial.py if needed.
   - Run `python auth_listener_trial.py`

3. When the token is detected and valid, deadhand_trial.bat runs and displays "system erased".

This trial version is safe and non-destructive.
