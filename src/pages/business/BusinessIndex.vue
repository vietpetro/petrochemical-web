<template>
  <section class="section section--soft">
    <div class="container">
      <span class="eyebrow">Lĩnh vực hoạt động</span>
      <h2>Business Units của DCorp</h2>
      <p class="lead">Hệ sinh thái thương mại năng lượng, polymer và chuỗi cung ứng công nghiệp.</p>
      <div class="business-grid">
        <article v-for="unit in units" :key="unit.id" class="bu-card">
          <div class="bu-media" :class="`bu-${unit.id}`"></div>
          <div class="bu-body">
            <small>Business Unit</small>
            <h3>{{ unit.name }}</h3>
            <p>{{ unit.intro }}</p>
            <router-link :to="`/business/${unit.id}`">Khám phá →</router-link>
          </div>
        </article>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue';
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';
const unitsData = parse(rawData);
const units = ref(unitsData.businessUnits);
</script>

<style scoped>
/* reuse same styles as HomePage for BU cards */
.bu-card { overflow:hidden; border-radius:24px; background:#fff; box-shadow:var(--shadow-sm); border:1px solid var(--color-border); transition:.24s ease; }
.bu-card:hover { transform:translateY(-6px); box-shadow:var(--shadow-md); }
.bu-media { height:190px; background-size:cover; background-position:center; }
.bu-petro { background-image:linear-gradient(rgba(0,58,153,.1),rgba(0,58,153,.3)), url('https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=1000&q=80'); }
.bu-polymer { background-image:linear-gradient(rgba(0,58,153,.1),rgba(0,58,153,.3)), url('https://images.unsplash.com/photo-1618331833071-ce81bd50d300?auto=format&fit=crop&w=1000&q=80'); }
.bu-lubricants { background-image:linear-gradient(rgba(0,58,153,.1),rgba(0,58,153,.3)), url('https://images.unsplash.com/photo-1581091215367-59ab6b252f64?auto=format&fit=crop&w=1000&q=80'); }
.bu-energy { background-image:linear-gradient(rgba(0,58,153,.1),rgba(0,58,153,.3)), url('https://images.unsplash.com/photo-1497435334941-8c899ee9e8e9?auto=format&fit=crop&w=1000&q=80'); }
.bu-logistics { background-image:linear-gradient(rgba(0,58,153,.1),rgba(0,58,153,.3)), url('https://images.unsplash.com/photo-1589556264800-08ae9e129a30?auto=format&fit=crop&w=1000&q=80'); }
.bu-body { padding:24px; }
.bu-body small { color:var(--color-secondary); font-weight:900; text-transform:uppercase; letter-spacing:.08em; }
.bu-body h3 { font-size:24px; margin:10px 0; color:var(--color-dark); }
.bu-body p { color:var(--color-muted); line-height:1.6; }
.bu-body a { color:var(--color-primary); font-weight:900; text-decoration:none; }
</style>