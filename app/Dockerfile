# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /flask-api-revolut

COPY app/requirements.txt app/requirements.txt
RUN pip3 install -r app/requirements.txt

COPY app/. app/.

EXPOSE 5000
EXPOSE 22

CMD [ "python3 app/app.py"]