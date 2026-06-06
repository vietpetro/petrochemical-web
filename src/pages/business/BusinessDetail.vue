<template>
  <div v-if="unit" class="business-detail">
    <section class="bu-hero">
      <div class="bu-hero-bg"></div>
      <div class="container bu-hero-content">
        <h1>{{ unit.name }}</h1>
        <p class="lead">{{ unit.intro }}</p>
      </div>
    </section>

    <section class="section section--soft">
      <div class="container">
        <span class="eyebrow">Sản phẩm &amp; Dịch vụ</span>
        <h2>Giải pháp từng bước tiến</h2>
        <div class="services-grid">
          <article v-for="s in unit.services" :key="s.title" class="service-card">
            <div class="service-icon"></div>
            <h3>{{ s.title }}</h3>
            <p>{{ s.desc }}</p>
          </article>
        </div>
      </div>
    </section>

    <section class="section">
      <div class="container">
        <span class="eyebrow">Năng lực</span>
        <h2>Tiềm năng cung ứng toàn cầu</h2>
        <div class="stats-grid">
          <div v-for="c in unit.capabilities" :key="c.title" class="stat-card">
            <strong>{{ c.title }}</strong>
            <span>{{ c.desc }}</span>
          </div>
        </div>
      </div>
    </section>

    <section class="section section--soft">
      <div class="container">
        <span class="eyebrow">Khách hàng chiến lược</span>
        <h2>Đối tác tin cậy trên toàn bộ chuỗi giá trị</h2>
        <p class="lead">DCorp luôn làm việc cùng các đối tác uy tín, đáp ứng tiêu chuẩn chất lượng và an toàn hàng đầu.</p>
        <div class="customers-grid">
          <div v-for="customer in unit.customers" :key="customer" class="customer-tag">
            {{ customer }}
          </div>
        </div>
        <router-link :to="unit.cta.link" class="btn btn--primary">{{ unit.cta.label }}</router-link>
      </div>
    </section>
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
.bu-hero {
  position: relative;
  min-height: 520px;
  display: flex;
  align-items: center;
  color: #fff;
  overflow: hidden;
}
.bu-hero-bg {
  position: absolute;
  inset: 0;
  background: linear-gradient(90deg, rgba(7,27,58,.65), rgba(0,58,153,.7)),
    url('https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=1800&q=80') center/cover;
  transform: scale(1.04);
}
.bu-hero-content {
  position: relative;
  z-index: 1;
  max-width: 720px;
  text-align: left;
}
.bu-hero-content h1 { color: #fff; margin: 0 0 12px; font-size: clamp(32px,5vw,48px); }
.bu-hero-content .lead { color: rgba(255,255,255,.85); line-height: 1.6; }

.services-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 24px; margin-top: 30px; }
.service-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: 20px;
  padding: 24px;
  text-align: center;
  box-shadow: var(--shadow-sm);
  transition: .22s ease;
}
.service-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-md); }
.service-icon {
  width: 56px; height: 56px;
  margin: 0 auto 18px;
  background: var(--color-section);
  border-radius: 50%;
}
.service-petro .service-icon { background: url('https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=80&q=80') center/cover no-repeat; }
.service-polymer .service-icon { background: url('https://images.unsplash.com/photo-1618331833071-ce81bd50d300?auto=format&fit=crop&w=80&q=80') center/cover no-repeat; }
.service-lubricants .service-icon { background: url('https://images.unsplash.com/photo-1581091215367-59ab6b252f64?auto=format&fit=crop&w=80&q=80') center/cover no-repeat; }
.service-energy .service-icon { background: url('https://images.unsplash.com/photo-1497435334941-8c899ee9e8e9?auto=format&fit=crop&w=80&q=80') center/cover no-repeat; }
.service-logistics .service-icon { background: url('https://images.unsplash.com/photo-1589556264800-08ae9e129a30?auto=format&fit=crop&w=80&q=80') center/cover no-repeat; }

.service-card h3 { margin: 10px 0; color: var(--color-primary); font-size: 20px; }
.service-card p { color: var(--color-muted); line-height: 1.6; }

.stats-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 24px; margin-top: 30px; }
.stat-card {
  background: #fff;
  border-left: 4px solid var(--color-accent);
  border-radius: 16px;
  padding: 24px;
  box-shadow: var(--shadow-sm);
}
.stat-card strong { display:block; color: var(--color-primary); font-size: 28px; font-weight: 900; letter-spacing: -.03em; }
.stat-card span { color: var(--color-muted); line-height: 1.6; }

.customers-grid { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 20px; }
.customer-tag {
  background: var(--color-section);
  color: var(--color-dark);
  padding: 8px 16px;
  border-radius: 999px;
  font-weight: 800;
  font-size: 14px;
  border: 1px solid var(--color-border);
}