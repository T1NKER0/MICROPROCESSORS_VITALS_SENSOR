from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from app.models import db
app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://root:BZ5cSgzCH!@localhost:3306/micro"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db.init_app(app)

# Importing parts of the application that require initialized 'app' and 'db'
from app import views
from app import monitor


if __name__ == "__main__":
    app.run()
