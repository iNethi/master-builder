from flask.cli import FlaskGroup
import csv
from endpoints import Vouchers, app, db

cli = FlaskGroup(app)


@cli.command("test_query")
def test_query():
    match = Vouchers.query.filter_by(used="new", profile="Demo1").first()
    match.status="used"
    try:
        db.session.commit()
    except Exception as e:
        print(e)
    print(match.profile)


if __name__ == "__main__":
    cli()
