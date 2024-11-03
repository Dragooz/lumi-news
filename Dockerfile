# Base stage for both development and production
FROM ruby:3.3.5-slim AS base

# Common dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    postgresql-client \
    libpq-dev \
    tzdata \
    git \
    build-essential \
    nodejs \
    cron \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /app

# Add tini for proper signal handling
RUN apt-get update && apt-get install -y tini && rm -rf /var/lib/apt/lists/*

# Copy dependency files
COPY Gemfile Gemfile.lock ./

# Install Whenever gem to handle cron jobs
RUN bundle add whenever

# Development stage
FROM base AS development

# Add development-specific dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN bundle install

# Use tini as entrypoint
ENTRYPOINT ["/usr/bin/tini", "--"]

# Run the application and cron together
CMD ["bash", "-c", "whenever --update-crontab && cron && bundle exec rails server -b 0.0.0.0"]

# Production stage
FROM base AS production

# Install production dependencies
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 20 --retry 5

# Copy application code
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rake assets:precompile

# Update crontab with Whenever jobs
RUN whenever --update-crontab

# Remove unnecessary files
RUN rm -rf tmp/cache vendor/bundle test spec

# Start cron and the Rails server in production
CMD ["bash", "-c", "cron && ./bin/rails server -b 0.0.0.0"]
