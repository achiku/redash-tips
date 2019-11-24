# redash-tips

- https://github.com/getredash/redash
    * https://github.com/getredash/redash/releases/tag/v7.0.0
- using Python 2.7 for a moment
    * https://github.com/getredash/redash/issues/4181
- local dev environment setup
    *  https://redash.io/help/open-source/dev-guide/setup

### basics

- Python (2.7)
- PostgreSQL (9.3 or newer)
- Redis (2.8.3 or newer) 
- Node.js (v6 or newer)

### create db

```
create user redash;
create database redash;
grant all on database redash to redash;
```

```.env
# create .env file and put the following before running create_tables script
export REDASH_DATABASE_URL="postgresql://redash@localhost:5432/redash"
```

```
bin/run ./manage.py database create_tables
```

### start services

```
./bin/run ./manage.py runserver --debugger --reload
./bin/run celery worker --app=redash.worker --beat -Qscheduled_queries,queries,celery -c2
npm run start
```

### create dummy data
