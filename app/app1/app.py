from flask import Flask
import os
import psycopg2

app = Flask(__name__)

HELLO_WORLD = os.getenv("HELLO_WORLD", "Hello World not found!")

def connect_db():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        database=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
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
    return f"{HELLO_WORLD} Connected to the database version: {db_version}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
