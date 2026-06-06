<template>
  <div v-if="unit" class="business-detail">
    <header class="hero" :style="{ backgroundImage: `url(${unit.banner})` }">
      <h1>{{ unit.name }}</h1>
    </header>
    <div class="container">
      <section class="intro">
        <p>{{ unit.intro }}</p>
      </section>
      <section class="services">
        <h2>Sản phẩm & Dịch vụ</h2>
        <div class="grid">
          <div v-for="s in unit.services" :key="s.title" class="card">
            <h3>{{ s.title }}</h3>
            <p>{{ s.desc }}</p>
          </div>
        </div>
      </section>
      <section class="capabilities">
        <h2>Năng lực</h2>
        <div class="grid">
          <div v-for="c in unit.capabilities" :key="c.title" class="card">
            <h4>{{ c.title }}</h4>
            <p>{{ c.desc }}</p>
          </div>
        </div>
      </section>
      <section class="cta">
        <router-link :to="unit.cta.link" class="btn">{{ unit.cta.label }}</router-link>
      </section>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';
const unitsData = parse(rawData);
const route = useRoute();
const unit = computed(() => {
  return unitsData.businessUnits.find(u => u.id === route.params.unitId);
});
</script>

<style scoped>
.hero { height:300px; background-size:cover; display:flex; align-items:center; justify-content:center; color:#fff; }
.card { border:1px solid #ccc; padding:1rem; }
.btn { padding:1rem 2rem; background:#2c3e50; color:#fff; }
</style>
