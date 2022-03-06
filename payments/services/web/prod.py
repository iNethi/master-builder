from flask.cli import FlaskGroup
import csv
from endpoints import Vouchers, app, db

cli = FlaskGroup(app)


def create_db():
    db.create_all()
    try:
        db.session.commit()
    except Exception as e:
        print(e)





if __name__ == "__main__":
    cli()
    create_db()
    seed_db()
