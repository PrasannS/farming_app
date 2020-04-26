# Cultivate

A climate change solution app built for the Silicon Valley Hacks Hackathon. 

## Running this app 

This app consists of a flask server and a flutter app. To run the flutter app, see the flutter installation here - https://flutter.dev/. 

For flask, make sure that you have python 3 installed - see latest version here - https://www.python.org/downloads/
Use pip install to get flask

1. Install flask using pip using this command - https://pypi.org/project/Flask/
2. Install beautifulsoup4 using this command - https://pypi.org/project/beautifulsoup4/
3. In the directory farming_app/lib/api_client/api_client change line 8, 25, 38 - so that the local ip - 192... matches your network local ip. This will be your ipv4 address, you can use the ```ifconfig``` or ```ipconfig``` command to figure this out.This may change periodically, so if the server isn't communicating with the app, make sure to look at that. 

Running the Flask app - 
1. Navigate to the farming_app/farmscraper directory. 
2. Run the following commands - 
Windows - ```set FLASK_APP=main.py```
Mac - ```export FLASK_APP=main.py```

Both - ```flask run --host=0.0.0.0```
