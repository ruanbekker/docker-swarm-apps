FROM python:2.7-alpine

ADD app/requirements.txt /app/requirements.txt
ADD app/templates /app/templates
ADD app/app.py /app/app.py
RUN pip install -r /app/requirements.txt

CMD ["python", "/app/app.py"]
