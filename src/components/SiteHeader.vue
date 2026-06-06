<template>
  <header class="site-header">
    <div class="container nav-wrap">
      <router-link to="/" class="brand-mark" aria-label="DCorp home">
        <span class="brand-symbol">D</span>
        <span class="brand-copy">
          <strong>{{ brand.name }}</strong>
          <small>Trade • Energy • Polymer • Logistics</small>
        </span>
      </router-link>

      <button class="mobile-toggle" @click="open = !open" :aria-expanded="open" aria-label="Open navigation">
        <span></span><span></span><span></span>
      </button>

      <nav class="primary-nav" :class="{ open }">
        <router-link to="/">Trang chủ</router-link>
        <router-link to="/about">Giới thiệu</router-link>
        <div class="mega-trigger">
          <router-link to="/business">Các ngành nghề</router-link>
          <div class="mega-menu">
            <router-link v-for="unit in units" :key="unit.id" :to="`/business/${unit.id}`" class="mega-item">
              <span>{{ unit.name }}</span>
              <small>{{ unit.intro }}</small>
            </router-link>
          </div>
        </div>
        <router-link to="/business/petro/quote">Báo giá</router-link>
        <router-link to="/career">Gia nhập DCorp</router-link>
        <router-link to="/news">Tin tức</router-link>
        <router-link to="/contact">Liên hệ</router-link>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref } from 'vue';
import { brand } from '@/config/brand.js';
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';

const open = ref(false);
const units = parse(rawData).businessUnits;
</script>

<style scoped>
.site-header {
  position: sticky;
  top: 0;
  z-index: 100;
  height: var(--header-h);
  background: rgba(255,255,255,.92);
  backdrop-filter: blur(18px);
  border-bottom: 1px solid rgba(217,226,239,.9);
  transition: box-shadow .2s ease;
}
.nav-wrap {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
}
.brand-mark {
  display:flex;
  align-items:center;
  gap:12px;
  text-decoration:none;
  color:var(--color-dark);
}
.brand-symbol {
  width: 46px;
  height: 46px;
  display:grid;
  place-items:center;
  border-radius: 14px;
  background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
  color:#fff;
  font-family: Manrope, Inter, sans-serif;
  font-weight:900;
  font-size:26px;
  box-shadow: 0 12px 30px rgba(0,58,153,.22);
}
.brand-copy { display:flex; flex-direction:column; line-height:1.05; }
.brand-copy strong { font-size: 22px; letter-spacing:-.04em; }
.brand-copy small { margin-top: 4px; color: var(--color-muted); font-size: 11px; font-weight:700; letter-spacing:.02em; }
.primary-nav {
  display:flex;
  align-items:center;
  gap: 20px;
  font-weight: 800;
  font-size: 14px;
}
.primary-nav a { text-decoration:none; color:#23324A; }
.primary-nav > a:last-child {
  background: var(--color-primary);
  color:#fff;
  padding: 11px 16px;
  border-radius: 999px;
}
.mega-trigger { position:relative; padding: 30px 0; }
.mega-menu {
  position:absolute;
  left:50%;
  transform: translateX(-50%) translateY(12px);
  top: 72px;
  width: min(760px, 86vw);
  display:grid;
  grid-template-columns: repeat(2, minmax(0,1fr));
  gap: 12px;
  padding: 18px;
  background:#fff;
  border:1px solid var(--color-border);
  border-radius: 22px;
  box-shadow: var(--shadow-md);
  opacity:0;
  pointer-events:none;
  transition:.2s ease;
}
.mega-trigger:hover .mega-menu { opacity:1; transform: translateX(-50%) translateY(0); pointer-events:auto; }
.mega-item { padding:16px; border-radius:16px; background:var(--color-section); display:flex; flex-direction:column; gap:6px; }
.mega-item span { color:var(--color-primary); }
.mega-item small { color:var(--color-muted); line-height:1.45; font-weight:500; }
.mobile-toggle { display:none; background:none; border:0; padding:8px; }
.mobile-toggle span { display:block; width:26px; height:2px; background:var(--color-dark); margin:6px 0; }
@media (max-width: 1040px) {
  .mobile-toggle { display:block; }
  .primary-nav {
    position: fixed;
    inset: var(--header-h) 0 auto 0;
    background:#fff;
    flex-direction:column;
    align-items:flex-start;
    padding: 24px;
    border-bottom:1px solid var(--color-border);
    transform: translateY(-130%);
    transition:.25s ease;
    box-shadow: var(--shadow-md);
  }
  .primary-nav.open { transform: translateY(0); }
  .mega-trigger { padding: 0; width:100%; }
  .mega-menu { position: static; transform:none; opacity:1; pointer-events:auto; width:100%; grid-template-columns:1fr; box-shadow:none; margin-top:12px; }
}
