#!/bin/sh

docker-compose-prod.yml run -e FLASK_APP=endpoints/__init__.py -e FLASK_ENV=development -e DATABASE_URL=mysql://rd:rd@rdmariadb/rd voucherapiprod python3 -m pdb manage.py run -h 0.0.0.0 -p 80