import flask, json
from pathlib import Path
from datetime import datetime
from flask import request, jsonify
app = flask.Flask(__name__)
app.config["DEBUG"] = True

usersFile = 'datastore/users.json'
usersPath = Path(usersFile)
if not usersPath.is_file():
    with open(usersFile, 'w') as file:
        try:
            users = json.load(file)
        except:
            users = {}
            json.dump(users, file)
else:
    file = open(usersFile)
    users = json.load(file)

def calculate_birthday(birthdate_str):
    now = datetime.now()
    birthdate = datetime.strptime(birthdate_str, '%Y-%m-%d').date()
    birthday = datetime(now.year, birthdate.month, birthdate.day)
    days = (birthday - now.today()).days
    if days == 0:
        return "Happy Birthday!"
    elif days > 0:
        return "Your birthday is in " + str(days) + " days"
    elif days < 0:
        return "Your birthday was " + str(-days) + " days ago"
    else:
        return 1

@app.route('/', methods=['GET'])
def home():
    return {"message": "Hello Revolut!"}

@app.route("/hello/<username>",  methods = ['PUT'])
def insert_user(username):
    user = request.get_json()
    birthdate_str = user['dateOfBirth']
    birthdate = datetime.strptime(birthdate_str, '%Y-%m-%d').date()
    if birthdate >= datetime.today().date() or any(i.isdigit() for i in username):
        return {"message": "Birthdate and/or username are invalid"}, 400
    else:
        users.update({username : {"dateOfBirth": birthdate_str}})
        with open(usersFile, 'w') as json_file:
            json.dump(users, json_file, 
                                indent=4,  
                                separators=(',',': '))
        return "", 204

@app.route("/hello/<username>", methods=['GET'])
def happy_birthday(username):
    try:
        message = "Hello " + username + ", " + calculate_birthday(users[username]["dateOfBirth"])
        return  {"message": message}
    except:
        return {"message": "User does not exist"}, 400

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)