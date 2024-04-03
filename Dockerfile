FROM python:3.9-alpine

ENV PYTHONFAULTHANDLER=1 \
     PYTHONUNBUFFERED=1 \
     PYTHONDONTWRITEBYTECODE=1 \
     PIP_DISABLE_PIP_VERSION_CHECK=on

RUN apk --no-cache add ffmpeg

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt --no-cache-dir
# Expose the port the app runs on
EXPOSE 5000

CMD ["python", "bot/main.py", "gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "api:app"]
