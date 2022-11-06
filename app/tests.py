import json
from app import app

client = app.test_client()

#Define tests
def home():
    response = client.get('/')
    responseJson = json.loads(response.get_data().decode("utf-8"))
    assert responseJson['message'] == 'Hello Revolut!'

def get_invalid_user():
    response = client.get('/hello/nikolay123')
    assert response.status_code == 400

def put_user():
    response = client.put('/hello/nikolay',  json={"dateOfBirth": "1984-07-21"})
    assert response.status_code == 204

def get_user():
    response = client.get('/hello/nikolay')
    assert response.status_code == 200

def put_invalid_username():
    response = client.put('/hello/nikolay1',  json={"dateOfBirth": "1984-07-21"})
    assert response.status_code == 400

def put_invalid_birthdate():
    response = client.put('/hello/nikolay',  json={"dateOfBirth": "2024-07-21"})
    assert response.status_code == 400

#Run tests
home()
put_user()
get_user()
get_invalid_user()
put_invalid_username()
put_invalid_birthdate()
