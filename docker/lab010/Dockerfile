FROM python:3.12-slim

WORKDIR /app

COPY server.py /app/server.py
COPY client_check.py /app/client_check.py

EXPOSE 8500

CMD ["python3", "/app/server.py"]
