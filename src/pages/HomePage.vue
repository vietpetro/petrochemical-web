<template>
  <section class="home">
    <h1>Welcome to {{ brand.name }}</h1>
    <p>{{ brand.slogan }}</p>
    <router-link to="/business" class="cta">Explore Business Units</router-link>
  </section>
</template>

<script setup>
import { brand } from '@/config/brand.js';
</script>

<style scoped>
.home { text-align:center; padding:4rem 0; }
.cta { display:inline-block; margin-top:1rem; padding:0.75rem 1.5rem; background:#ffdd57; color:#000; text-decoration:none; border-radius:4px; }
</style>
