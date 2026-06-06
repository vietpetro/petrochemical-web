// src/config/site.js
// Central site configuration using Vite environment variables.
// VITE_ prefix is required for variables to be exposed to client code.

export const siteConfig = {
  name: import.meta.env.VITE_SITE_NAME || 'DCorp',
  url: import.meta.env.VITE_SITE_URL || '',
  description: import.meta.env.VITE_SITE_DESCRIPTION || '',
  // Helper to build canonical URLs
  getCanonical: (path) => {
    const base = import.meta.env.VITE_SITE_URL || '';
    // Ensure leading slash
    const cleanPath = path.startsWith('/') ? path : `/${path}`;
    return `${base}${cleanPath}`;
  }
};
