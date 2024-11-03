# Lumi News - Rails News Aggregator

A Ruby on Rails application that aggregates and summarizes news articles using AI (Future Feature)

## Prerequisites

- Docker and Docker Compose
- Ruby 7.2.1
- PostgreSQL
- Redis (for Sidekiq)

## Development Setup

1. Clone the repository

# Docker instructions:

1. Install necessary Docker in the environment
2. Copy .env.example and rename it to .env
3. Run "docker compose up"
4. Run "docker exec lumi-news-web-1 bundle exec rails runner "FetchArticlesJob.perform_now" to perform the job
5. Access the page via http://127.0.0.1:3000/

## Restart Docker (If due to any Postgres connecting errors)

1. docker compose down -v << Stop all containers and remove volumes
2. docker compose up << Start again

# TODO Left:

1. Research on NGINX to deploy on prod (currently EC2 can run, but not able to expose to public url yet.)
2. Deploy cron job (now need manually trigger by `docker exec lumi-news-web-1 bundle exec rails runner "FetchArticlesJob.perform_now"`)
3. TLDR section for each articles.
4. Select articles > provide summarization in a whole.
