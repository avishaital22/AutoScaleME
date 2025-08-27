# app/main.py

from flask import Flask, jsonify
import time
import math

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from AutoScaleMe!"

@app.route("/load")
def load():
    # סימולציה של חישוב כבד
    count = 0
    for number in range(1, 10000):
        if is_prime(number):
            count += 1
    return jsonify({"prime_count": count})

def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

