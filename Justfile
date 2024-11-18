_default:
  @just --list

# Start PostgreSQL database container
db:
  @docker run --rm \
    --name postgres-cpp-db \
    -e POSTGRES_DB=testdb \
    -e POSTGRES_USER=user \
    -e POSTGRES_PASSWORD=password \
    -p 5432:5432 \
    -d \
    postgres:latest
  echo "PostgreSQL is running on port 5432"
  echo "Connection details:"
  echo "  Database: testdb"
  echo "  User: user"
  echo "  Password: password"


run:
  @cmake . 
  @make
  @./cpp-libpqxx-app
