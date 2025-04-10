# ----------- Stage 1: Builder -----------
FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip==23.3 && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt

# ----------- Stage 2: Runtime -----------
FROM python:3.11-slim

# Build-time argument
ARG PORT=8080

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_APP=app/app.py \
    FLASK_ENV=production \
    PATH="/venv/bin:$PATH" \
    APP_PORT=${PORT} \
    GUNICORN_TIMEOUT=120 \
    GUNICORN_WORKERS=2 \
    GUNICORN_THREADS=4

WORKDIR /app

RUN useradd --create-home --shell /bin/bash appuser

COPY --from=builder /venv /venv
COPY --chown=appuser:appuser . .

USER appuser

EXPOSE ${APP_PORT}

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:${APP_PORT}/health || exit 1

ENTRYPOINT ["sh", "-c"]
CMD ["gunicorn --bind 0.0.0.0:${APP_PORT} --timeout ${GUNICORN_TIMEOUT} --workers ${GUNICORN_WORKERS} --threads ${GUNICORN_THREADS} --log-level info app.app:app"]
