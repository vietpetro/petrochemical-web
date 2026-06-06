<template>
  <header class="site-header">
    <nav class="nav">
      <router-link to="/" class="logo">{{ brand.name }}</router-link>
      <ul class="menu">
        <li><router-link to="/">Trang chủ</router-link></li>
        <li><router-link to="/about">Giới thiệu</router-link></li>
        <li><router-link to="/business">Business Unit</router-link></li>
        <li><router-link to="/news">Tin tức</router-link></li>
        <li><router-link to="/career">Gia nhập DCorp</router-link></li>
        <li><router-link to="/contact">Liên hệ</router-link></li>
      </ul>
    </nav>
  </header>
</template>

<script setup>
import { brand } from '@/config/brand.js';
</script>

<style scoped>
.site-header { background:#2c3e50; color:#fff; padding:1rem; }
.nav { display:flex; align-items:center; justify-content:space-between; }
.logo { font-weight:bold; font-size:1.5rem; color:#fff; text-decoration:none; }
.menu { display:flex; gap:1rem; list-style:none; margin:0; }
.menu li a { color:#fff; text-decoration:none; }
.menu li a.router-link-active { text-decoration:underline; }
</style>
