# TODO LIST

This is a Rails application for managing a todo list

## Getting Started

To run this application locally using Docker, follow the instructions below.

### Prerequisites

Make sure you have Docker and Docker Compose installed on your system.

### Installation

1. Clone this repository to your local machine.
2. Build the Docker image:

```bash
docker-compose build
```
3. Create the database:

```bash
docker-compose run web rails db:create
```

4. Run the database migrations:

```bash
docker-compose run web rails db:migrate
```

5. Start the application:

```bash
docker-compose up
```
Access the application in your web browser at http://localhost:3000.

### Testing

```bash
docker-compose run web rspec
```