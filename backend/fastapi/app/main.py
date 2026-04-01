from fastapi import FastAPI
from app.core.config import settings
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title=settings.PROJECT_NAME)

@app.get("/")
def root():
    env_status = "from .env" if settings.PROJECT_NAME != "Finance Tracker - Backend - FastAPI" else "default value"

    message = f"{settings.PROJECT_NAME} is active ({env_status})"
    return {"message": message}