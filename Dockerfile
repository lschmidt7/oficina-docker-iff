FROM python:3.12

RUN apt update
RUN apt install nano
# compact: RUN apt update && apt install nano

RUN pip install Flask