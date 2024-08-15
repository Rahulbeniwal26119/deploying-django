FROM python:3.10-slim-buster

ENV PYTHONUNBUFFERED=1

WORKDIR /docker_app

# RUN apt update

COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY . ./

RUN [ -d ./static ] && rm -r ./static || true && mkdir ./static

RUN python3 manage.py makemigrations

RUN python3 manage.py migrate

RUN python3 manage.py collectstatic --noinput

# build args are use to control default value for environment variables


ARG DEFAULT_PORT=8000

ENV PORT ${DEFAULT_PORT}

RUN echo ${PORT}

EXPOSE $PORT

ENV MONGODB_USERNAME="rahul"
ENV MONGODB_PASSWORD="rahul111"

# RUN apt update
# RUN apt install -y httpie

# ENTRYPOINT is used to run a command when the container starts after apending to the intial one

# ENTRYPOINT [ "python3", "manage.py" ]

# -----------------*--------------------------------------------------------
# | docker run --name backend -p 8000:8000 backend runserver 0.0.0.0:8000  |
# -----------------*--------------------------------------------------------

# VOLUME [ "/docker_app/logged_details" ] created anonymous volume

CMD ["gunicorn", "--workers", "2", "--bind", "0.0.0.0:8000", "docker_app.wsgi:application"]


# while CMD command will be overwrittern by the command passed in the docker run command
# -----------------*-------------------------------------------------------------------------
# | docker run --name backend -p 8000:8000 backend python3 manage.py runserver 0.0.0.0:8000 |
# -----------------*-------------------------------------------------------------------------
