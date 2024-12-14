import requests
import os
from dotenv import load_dotenv

load_dotenv()

TELEGRAM_BOT_TOKEN = os.getenv('TELEGRAM_BOT_TOKEN')
TELEGRAM_CHAT_ID = os.getenv('TELEGRAM_CHAT_ID')

def send_telegram(text: str):
  r = requests.post(f'https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage', data={
    'chat_id': TELEGRAM_CHAT_ID,
    'text': text
  })

  if r.status_code != 200:
    raise Exception('sending error')
        
send_telegram(f'Скрипт от Суслика работает👌')
