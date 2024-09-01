from flask import Flask
import os

app = Flask(__name__)

# Получаем переменную окружения с дефолтным значением
HELLO_WORLD = os.getenv("HELLO_WORLD", "Hello World not found!")

@app.route('/')
def hello_world():
    # Используем правильный синтаксис f-строк
    message = f"{HELLO_WORLD} Miki"
    return message

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
