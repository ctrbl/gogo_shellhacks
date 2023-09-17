from math import floor
import os
import random
import uuid

from flask import request, jsonify, abort
from flask_login import current_user, login_user, logout_user, login_required

from models import app, db, login_manager
from models import User


# The code below inserts new accounts.
with app.app_context():
    db.create_all()

@app.route('/')
def hello_world():
    return 'Welcome to EmConnect!'

if __name__ == '__main__':
    app.run(port=3000)