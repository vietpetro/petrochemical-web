<template>
  <footer class="site-footer">
    <div class="container footer-grid">
      <div>
        <div class="footer-brand">{{ brand.name }}</div>
        <p>{{ brand.slogan }}</p>
        <p class="tagline">Trade • Energy • Polymer • Logistics</p>
      </div>
      <div>
        <h4>Business Units</h4>
        <router-link v-for="unit in units" :key="unit.id" :to="`/business/${unit.id}`">{{ unit.name }}</router-link>
      </div>
      <div>
        <h4>Điều hướng</h4>
        <router-link to="/about">Giới thiệu</router-link>
        <router-link to="/career">Gia nhập DCorp</router-link>
        <router-link to="/news">Tin tức</router-link>
        <router-link to="/contact">Liên hệ</router-link>
      </div>
      <div>
        <h4>Liên hệ</h4>
        <a :href="`mailto:${brand.email}`">{{ brand.email }}</a>
        <router-link class="quote" to="/business/petro/quote">Yêu cầu báo giá</router-link>
      </div>
    </div>
    <div class="container copyright">© {{ new Date().getFullYear() }} {{ brand.name }}. Global Energy & Industrial Supply Corporation.</div>
  </footer>
</template>

<script setup>
import { brand } from '@/config/brand.js';
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';
const units = parse(rawData).businessUnits;
</script>

<style scoped>
.site-footer { background: #071B3A; color:#DDE7F7; padding: 64px 0 26px; }
.footer-grid { display:grid; grid-template-columns: 1.4fr 1fr 1fr 1fr; gap: 34px; }
.footer-brand { font-family: Manrope, Inter, sans-serif; font-weight:900; font-size:34px; color:#fff; letter-spacing:-.04em; }
p { color:#AFC3E3; line-height:1.7; }
.tagline { color: var(--color-accent); font-weight:800; }
h4 { color:#fff; margin:0 0 16px; }
a { display:block; color:#DDE7F7; text-decoration:none; margin: 10px 0; }
a:hover { color: var(--color-accent); }
.quote { display:inline-flex; background: var(--color-accent); color:#111827; padding: 12px 18px; border-radius:999px; font-weight:900; margin-top: 18px; }
.copyright { margin-top: 42px; padding-top: 22px; border-top:1px solid rgba(255,255,255,.13); color:#8FA9CC; font-size:14px; }
@media (max-width: 900px) { .footer-grid { grid-template-columns:1fr; } }
</style>
