# Use an official Ruby image
FROM ruby:3.4.2 AS builder

# Install Node.js and dependencies (required by Jekyll)
RUN apt-get update && \
    apt-get install -y nodejs npm && \
    gem install bundler jekyll && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all source files
COPY . .

# Install dependencies
RUN bundle install

# Build the site (production mode disables live reload, etc.)
RUN JEKYLL_ENV=production bundle exec jekyll build

# Stage 2: Serve with nginx
FROM nginx:1.27.4-alpine AS runner

# Copy generated site from builder stage
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/_site /usr/share/nginx/html
