from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": ["http://jenkins-ninjas-static-website-bucket.s3-website-us-west-1.amazonaws.com"]}})

# Database configuration
db_config = {
    'user': 'admin',
    'password': 'Jenkins_Ninjas',
    'host': 'terraform-20240916054218433500000006.c38i02cui857.us-west-1.rds.amazonaws.com',
    'database': 'mydatabase'
}

# Database connection function
def get_db_connection():
    conn = mysql.connector.connect(**db_config)
    return conn

# Routes
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        if cursor.fetchone():
            return 'User already exists!', 400

        cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, password))
        conn.commit()
        return 'User registered successfully!', 201
    except Error as e:
        conn.rollback()
        return f'Error: {str(e)}', 500
    finally:
        cursor.close()
        conn.close()

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
        user = cursor.fetchone()
        if user:
            return 'Login successful!', 200
        return 'Invalid credentials!', 401
    finally:
        cursor.close()
        conn.close()

@app.route('/products', methods=['GET'])
def get_products():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("SELECT * FROM products")
        products = cursor.fetchall()
        return jsonify(products)
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)