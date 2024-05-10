from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'user'
    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(255), nullable=False, unique=True)
    name = db.Column(db.String(255), nullable=False)
    hash = db.Column(db.Text, nullable=False)

    devices = db.relationship('Device', backref='user', lazy='dynamic', cascade="all, delete-orphan")

class Device(db.Model):
    __tablename__ = 'device'
    device_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    device_name = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.user_id'), nullable=False)

    monitors = db.relationship('Monitor', backref='device', lazy='dynamic', cascade="all, delete-orphan")

class Monitor(db.Model):
    __tablename__ = 'monitor'
    monitor_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    avg_temp = db.Column(db.BigInteger, nullable=False)
    avg_pulse = db.Column(db.BigInteger, nullable=False)
    timestamp = db.Column(db.TIMESTAMP, nullable=False, server_default=db.text('CURRENT_TIMESTAMP'))
    pulse_alert = db.Column(db.Enum('yes', 'no'), nullable=False, default='no')
    temp_alert = db.Column(db.Enum('yes', 'no'), nullable=False, default='no')
    device_id = db.Column(db.Integer, db.ForeignKey('device.device_id'), nullable=False)
