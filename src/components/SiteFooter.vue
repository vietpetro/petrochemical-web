<template>
  <footer class="site-footer">
    <p>© {{ new Date().getFullYear() }} {{ brand.name }}. All rights reserved.</p>
    <p>{{ brand.slogan }}</p>
    <p><a :href="`mailto:${brand.email}`">{{ brand.email }}</a></p>
  </footer>
</template>

<script setup>
import { brand } from '@/config/brand.js';
</script>

<style scoped>
.site-footer { background:#2c3e50; color:#fff; text-align:center; padding:2rem 0; }
.site-footer a { color:#ffdd57; }
</style>
