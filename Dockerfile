FROM python:3.8.7-alpine

RUN pip install --upgrade pip
RUN pip install pipenv

RUN adduser -D python

# Create the work dir and set permissions as WORKDIR set the permissions as root
RUN mkdir /home/python/app/ && chown -R python:python /home/python/app
WORKDIR /home/python/app

USER python

RUN pip install --user pipenv

ENV PATH="/home/worker/.local/bin:${PATH}"

COPY --chown=python:python Pipfile Pipfile
RUN pipenv lock -r > requirements.txt
RUN pip install --user -r requirements.txt

COPY --chown=python:python . .

CMD ["python", "-u", "main.py"]