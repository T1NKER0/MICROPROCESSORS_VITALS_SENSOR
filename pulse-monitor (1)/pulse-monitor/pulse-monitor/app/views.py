from flask import render_template
from app import app
from app.models import db, Monitor

@app.route('/')
def index():
    latest_monitor = Monitor.query.order_by(Monitor.timestamp.desc()).first()
    all_monitors = Monitor.query.order_by(Monitor.timestamp.desc()).all()
    return render_template('index.html', latest_monitor=latest_monitor, monitors=all_monitors)
