# README
## Getting Started

1. Build and start the application:

```
docker compose up
```

2. Migrations and seeds

```
docker compose exec web rails db:migrate
docker compose exec web rails db:seed
```

3. Go to the API docs

```
http://localhost:3000/api-docs
```

