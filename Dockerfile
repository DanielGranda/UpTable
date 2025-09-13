# UpTable Railway Deployment Dockerfile
# Based on Baserow with Premium/Enterprise features

FROM baserow/baserow:1.35.1

# Set UpTable metadata
LABEL name="UpTable"
LABEL description="Advanced no-code database platform"
LABEL version="1.35.1"

# Copy custom UpTable modifications
COPY ./backend/src/baserow/ /baserow/backend/src/baserow/
COPY ./web-frontend/ /baserow/web-frontend/
COPY ./premium/ /baserow/premium/
COPY ./enterprise/ /baserow/enterprise/

# Railway-specific configurations
ENV PORT=8080
ENV BASEROW_PUBLIC_URL=$RAILWAY_PUBLIC_DOMAIN
ENV BASEROW_ENABLE_PREMIUM=true
ENV BASEROW_ENABLE_ENTERPRISE=true

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/api/health/ || exit 1

EXPOSE 8080

# Start UpTable
CMD ["/baserow/supervisor/start.sh"]