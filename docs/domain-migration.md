# Domain Migration Documentation

## Overview
This document outlines the procedure for migrating the DCorp website to a new domain (e.g., `dcorp.vn`, `dcorp.com.vn`) without modifying the source code.

## Key Strategy: Dynamic URL Injection
The website uses the `{{NEXT_PUBLIC_SITE_URL}}` placeholder for all absolute URLs, including:
- Canonical links
- Open Graph URLs

## Deployment Configuration
To change the domain, set the environment variable `NEXT_PUBLIC_SITE_URL` during the build or deployment process.

### Example for CI/CD Pipeline
If using a static build process (e.g., `sed` or template engine):
```bash
export NEXT_PUBLIC_SITE_URL="https://dcorp.vn"
# Apply to files (Example using sed)
find . -type f -name "*.html" -exec sed -i "s|{{NEXT_PUBLIC_SITE_URL}}|$NEXT_PUBLIC_SITE_URL|g" {} +
```

### Server-Side Injection (Alternative)
If the site is served via a dynamic web server (e.g., Nginx, Apache), you can inject the domain via server-side templates or proxy configurations.

## Site-Wide Dynamic Updates
- **Canonical URLs**: Automatically set via `{{NEXT_PUBLIC_SITE_URL}}` link tag.
- **Open Graph URLs**: Automatically set via `{{NEXT_PUBLIC_SITE_URL}}` meta tag.

## Sitemap
A sitemap should be generated dynamically during the build process based on the `NEXT_PUBLIC_SITE_URL` to ensure all URLs reflect the current domain.
