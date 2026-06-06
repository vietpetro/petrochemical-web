<template>
  <div>
    <section class="hero">
      <div class="hero-bg"></div>
      <div class="container hero-content">
        <span class="eyebrow">DCorp Global Energy Corporation</span>
        <h1>Driving Energy, Polymer and Industrial Supply Solutions</h1>
        <p class="lead">Đối tác chiến lược trong lĩnh vực năng lượng, hóa dầu và logistics công nghiệp.</p>
        <div class="hero-actions">
          <router-link class="btn btn--primary" to="/business/petro/quote">Yêu cầu báo giá</router-link>
          <router-link class="btn btn--ghost" to="/contact">Liên hệ tư vấn</router-link>
        </div>
      </div>
    </section>

    <section class="section stats-section">
      <div class="container">
        <span class="eyebrow">Năng lực DCorp</span>
        <h2>Quy mô cung ứng cho khách hàng công nghiệp</h2>
        <div class="stats-grid">
          <div v-for="item in stats" :key="item.label" class="stat-card">
            <strong>{{ item.value }}</strong>
            <span>{{ item.label }}</span>
          </div>
        </div>
      </div>
    </section>

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

    <section class="section supply-section">
      <div class="container">
        <span class="eyebrow">Supply Chain Excellence</span>
        <h2>Chuỗi cung ứng tích hợp từ nguồn hàng đến khách hàng</h2>
        <div class="flow">
          <div v-for="step in supply" :key="step" class="flow-step">{{ step }}</div>
        </div>
      </div>
    </section>

    <section class="section esg-section section--soft">
      <div class="container esg-grid">
        <div>
          <span class="eyebrow">Phát triển bền vững</span>
          <h2>Vận hành an toàn, chất lượng và có trách nhiệm</h2>
          <p class="lead">DCorp định hướng xây dựng năng lực cung ứng dài hạn với tiêu chuẩn môi trường, an toàn và chất lượng trong từng giao dịch.</p>
        </div>
        <div class="esg-cards">
          <div v-for="item in esg" :key="item" class="esg-card">{{ item }}</div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';
const units = parse(rawData).businessUnits;
const stats = [
  { value: '10+', label: 'Năm kinh nghiệm thương mại công nghiệp' },
  { value: '300+', label: 'Khách hàng doanh nghiệp' },
  { value: '5', label: 'Business Units chiến lược' },
  { value: '24/7', label: 'Điều phối cung ứng & logistics' }
];
const supply = ['Nhà cung cấp', 'Kho vận', 'Vận chuyển', 'Khách hàng'];
const esg = ['Môi trường', 'An toàn', 'Chất lượng', 'Trách nhiệm xã hội'];
</script>

<style scoped>
.hero { position:relative; min-height: calc(100vh - var(--header-h)); display:flex; align-items:center; color:#fff; overflow:hidden; }
.hero-bg { position:absolute; inset:0; background:
  linear-gradient(90deg, rgba(0,24,65,.92), rgba(0,58,153,.66) 48%, rgba(7,27,58,.35)),
  url('https://images.unsplash.com/photo-1518709268805-4e9042af2176?auto=format&fit=crop&w=1800&q=80') center/cover;
  transform: scale(1.02);
}
.hero-content { position:relative; z-index:1; padding: 80px 0; }
.hero .lead { color: rgba(255,255,255,.84); }
.hero-actions { display:flex; flex-wrap:wrap; gap:14px; margin-top:34px; }
.stats-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:18px; margin-top:34px; }
.stat-card { padding:28px; border-left:4px solid var(--color-accent); background:#fff; border-radius:18px; box-shadow:var(--shadow-sm); }
.stat-card strong { display:block; font-size:42px; font-family:Manrope, Inter, sans-serif; color:var(--color-primary); letter-spacing:-.05em; }
.stat-card span { color:var(--color-muted); line-height:1.5; }
.business-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:24px; margin-top:36px; }
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
.flow { display:grid; grid-template-columns:repeat(4,1fr); gap:18px; margin-top:34px; }
.flow-step { position:relative; padding:28px 18px; text-align:center; background:#fff; border:1px solid var(--color-border); border-radius:18px; font-weight:900; color:var(--color-primary); box-shadow:var(--shadow-sm); }
.flow-step:not(:last-child)::after { content:'→'; position:absolute; right:-17px; top:50%; transform:translateY(-50%); color:var(--color-accent); font-size:28px; z-index:2; }
.esg-grid { display:grid; grid-template-columns:1.1fr 1fr; gap:42px; align-items:center; }
.esg-cards { display:grid; grid-template-columns:1fr 1fr; gap:18px; }
.esg-card { padding:28px; border-radius:20px; background:linear-gradient(135deg, var(--color-primary), var(--color-secondary)); color:#fff; font-weight:900; box-shadow:var(--shadow-sm); }
@media (max-width: 900px) {
  .hero { min-height: 720px; }
  .stats-grid, .business-grid, .flow, .esg-grid, .esg-cards { grid-template-columns:1fr; }
  .flow-step:not(:last-child)::after { content:'↓'; right:50%; top:auto; bottom:-24px; transform:translateX(50%); }
}
