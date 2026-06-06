// src/config/brand.js
// Brand configuration using Vite environment variables.

export const brand = {
  name: import.meta.env.VITE_SITE_NAME || 'DCorp',
  slogan: import.meta.env.VITE_SITE_SLOGAN || 'Năng lượng & Công nghiệp bền vững',
  email: import.meta.env.VITE_SITE_EMAIL || 'contact@dcorp.vn',
  parentCompany: import.meta.env.VITE_SITE_PARENT_COMPANY || 'DCorp Group',
  buLabel: import.meta.env.VITE_SITE_BU_LABEL || 'Business Unit of DCorp'
};
