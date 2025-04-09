# ----------- Stage 1: Builder -----------
FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Only copy requirements for caching efficiency
COPY requirements.txt .

# Create isolated virtual environment and install dependencies
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip==23.3 && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt

# ----------- Stage 2: Runtime -----------
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_APP=app/app.py \
    FLASK_ENV=production \
    PATH="/venv/bin:$PATH"

WORKDIR /app

# Add non-root user
RUN useradd --create-home --shell /bin/bash appuser

# Copy virtual environment and app source
COPY --from=builder /venv /venv
COPY --chown=appuser:appuser . .

USER appuser

EXPOSE 5000

# Optional: Basic healthcheck (adjust endpoint as needed)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Default command (entrypoint + cmd pattern)
ENTRYPOINT ["gunicorn"]
CMD ["--bind", "0.0.0.0:5000", "app.app:app"]
