from flask import Flask
import os
import psycopg2
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

def connect_db():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        database=os.getenv("DB_NAME", "mydatabase"),
        user=os.getenv("DB_USER", "user"),
        password=os.getenv("DB_PASSWORD", "password")
    )
    return conn

@app.route('/')
def hello_world():
    conn = connect_db()
    cur = conn.cursor()
    cur.execute('SELECT version();')
    db_version = cur.fetchone()
    cur.close()
    conn.close()
    return f"Hello, World! Connected to the database version: {db_version}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv("WEB_PORT", 5000)))
