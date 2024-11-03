# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Configuration > https://www.ivanmorgillo.com/2024/06/20/get-started-with-ruby-on-rails-on-wsl2-ubuntu/

- Fetch Job:

1. `bin/rails db:seed`
2. `bundle exec rails runner "FetchArticlesJob.perform_now"`

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- Development: docker compose --env-file .env.development up
- Production: docker compose --env-file .env.production up

- Copy .env.production as .env to prod ec2
- To restart:

# Stop all containers and remove volumes

docker compose down -v

# Pull fresh images

docker compose pull

# Start up again

docker compose up -d

# Watch the logs

docker compose logs -f

- ...
