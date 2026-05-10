import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    # Telegram Bot Token
    BOT_TOKEN = os.getenv("BOT_TOKEN", "")
    
    # Admin User IDs (comma-separated)
    ADMIN_IDS = [int(id.strip()) for id in os.getenv("ADMIN_IDS", "").split(",") if id.strip()]
    
    # Batbin URL for cookies (required for age-restricted videos)
    COOKIE_URL = os.getenv("COOKIE_URL", "https://batbin.me/workaholics")  # e.g., https://batbin.me/aggravating
    
    # Download settings
    MAX_VIDEO_SIZE = int(os.getenv("MAX_VIDEO_SIZE", "2000"))  # MB
    DEFAULT_RESOLUTION = os.getenv("DEFAULT_RESOLUTION", "720")
    DOWNLOAD_PATH = "downloads"
    
    # Cookies file path
    COOKIES_FILE = "cookies/youtube_cookies.txt"
    
    # Rate limiting
    MAX_CONCURRENT_DOWNLOADS = 2
    REQUEST_TIMEOUT = 30
