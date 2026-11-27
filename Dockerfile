# Use an official Ruby image
FROM ruby:3.4.13 AS builder

# Install Node.js and dependencies (required by Jekyll)
RUN apt-get update && \
    apt-get install -y nodejs npm ca-certificates && \
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
FROM nginx:1.31.10-alpine AS runner

# Apply security patches for CVE-2026-4738 (zlib), libcrypto3, libssl3, libxml2
RUN apk upgrade --no-cache \
    && rm -rf /var/cache/apk/*

# Copy generated site from builder stage
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/_site /usr/share/nginx/html
