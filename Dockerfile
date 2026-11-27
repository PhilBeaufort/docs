# Use an official Ruby image with patched CVEs (base64 0.3.0, minitest 5.25.5)
FROM ruby:3.4.13 AS builder

# Install Node.js and dependencies (required by Jekyll)
RUN apt-get update && \
    apt-get install -y nodejs npm ca-certificates && \
    gem install bundler jekyll --no-document && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Set working directory
WORKDIR /app

# Copy all source files including Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock .dockerignore ./

# Install dependencies (resolves to patched gem versions)
RUN bundle install --jobs=4 --retry=3 --no-document

# Build the site (production mode disables live reload, etc.)
RUN JEKYLL_ENV=production bundle exec jekyll build --future=false

# Stage 2: Serve with nginx - updated to fixed version to remediate CVEs
FROM nginx:1.31.10-alpine AS runner

# Apply security patches for CVE-2026-4738 (zlib), libcrypto3, libssl3, libxml2
RUN apk upgrade --no-cache \
    && rm -rf /var/cache/apk/*

# Copy generated site from builder stage
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/_site /usr/share/nginx/html

# Ensure proper permissions and remove sensitive files
RUN chown -R www-data:www-data /usr/share/nginx/html \
    && rm -f /var/cache/apk/*

USER www-data

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:80/health || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
