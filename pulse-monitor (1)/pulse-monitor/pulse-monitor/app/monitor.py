from flask import request, jsonify
from app.models import Device, Monitor
from app import app, db

@app.route('/monitor', methods=['POST'])
def monitor():
    data = request.get_json()

    # Ensure all required data fields are present
    if 'device_name' not in data or 'pulse' not in data or 'temp' not in data:
        return jsonify({'message': 'Missing necessary data fields'}), 400

    device = Device.query.filter_by(device_name=data['device_name']).first()
    if not device:
        return jsonify({'message': 'Device not found'}), 404

    # Initialize pulse_alert and temp_alert to 'no'
    pulse_alert = 'yes' if data['pulse'] > 100 else 'no'
    temp_alert = 'yes' if data['temp'] > 37.5 else 'no'

    # Create a single Monitor instance with all data
    monitor = Monitor(
        avg_temp=data['temp'],
        avg_pulse=data['pulse'],
        pulse_alert=pulse_alert,
        temp_alert=temp_alert,
        device_id=device.device_id
    )
    db.session.add(monitor)
    db.session.commit()
    return jsonify({'message': 'Monitor data recorded'}), 201

