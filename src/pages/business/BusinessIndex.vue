<template>
  <div class="business-index container">
    <h1>Business Units</h1>
    <div class="grid">
      <div v-for="unit in units" :key="unit.id" class="unit-card">
        <h3>{{ unit.name }}</h3>
        <p>{{ unit.intro }}</p>
        <router-link :to="`/business/${unit.id}`" class="link">View Details</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';
const unitsData = parse(rawData);
const units = ref(unitsData.businessUnits);
</script>

<style scoped>
.container { padding: 2rem; }
.grid { display:grid; grid-template-columns:repeat(auto-fill, minmax(250px, 1fr)); gap:20px; }
.unit-card { border:1px solid #ddd; padding:1.5rem; border-radius:8px; }
</style>
