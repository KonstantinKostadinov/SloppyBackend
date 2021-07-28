
# One rapid developed backend

## Requirements
- Xcode 11.4 or greater 
- Docker 19.03 or greater

## Build instructions
1. Clone this repo
2. Open the project folder (`src/backend`) in the Terminal.
3. Setup the environment variables: `mv .env.example .env` 
    - If is necessary edit the `.env`
4. Run the database:  `docker-compose up -d db`
5. Run the database migrations: `docker-compose up migrate`
6. Open the project in the Xcode: `xed .`
7. Wait for Xcode to load all the packages and then run the project

## Other commands
- Start the app in Docker/Linux: `docker-compose up app`
- Stop all: `docker-compose down` (add -v to wipe the database)
