<template>
  <div class="quote-page container">
    <h1>Yêu cầu báo giá</h1>
    <form @submit.prevent="handleSubmit">
      <div class="form-group">
        <label>Họ và tên</label>
        <input type="text" v-model="form.name" required />
      </div>
      <div class="form-group">
        <label>Email</label>
        <input type="email" v-model="form.email" required />
      </div>
      <div class="form-group">
        <label>Số điện thoại</label>
        <input type="tel" v-model="form.phone" />
      </div>
      <div class="form-group">
        <label>Chọn Business Unit</label>
        <select v-model="form.unit" required>
          <option value="">-- Chọn một đơn vị --</option>
          <option v-for="unit in units" :key="unit.id" :value="unit.id">
            {{ unit.name }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label>Nội dung yêu cầu</label>
        <textarea v-model="form.message" rows="4"></textarea>
      </div>
      <button type="submit" class="btn-primary">Gửi yêu cầu</button>
    </form>
    <div v-if="success" class="alert success">Cảm ơn bạn! Chúng tôi sẽ phản hồi sớm nhất.</div>
    <div v-if="error" class="alert error">Có lỗi xảy ra. Vui lòng thử lại.</div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import rawData from '@/data/business-units.yaml?raw';
import { parse } from 'yaml';
const unitsData = parse(rawData);
const units = ref(unitsData.businessUnits);
const form = ref({
  name: '',
  email: '',
  phone: '',
  unit: '',
  message: ''
});
const success = ref(false);
const error = ref(false);

function handleSubmit() {
  // In a real app, send to backend
  console.log('Form submitted:', form.value);
  success.value = true;
  error.value = false;
  // reset form
  form.value.name = '';
  form.value.email = '';
  form.value.phone = '';
  form.value.unit = '';
  form.value.message = '';
}
</script>

<style scoped>
.quote-page { max-width: 600px; margin: 2rem auto; }
.form-group { margin-bottom: 1.5rem; }
.form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; }
.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 1rem;
}
.form-group textarea { resize: vertical; }
.btn-primary {
  display: inline-block;
  background: #2c3e50;
  color: #fff;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1rem;
}
.btn-primary:hover { background: #1a252f; }
.alert { padding: 1rem; margin-top: 1rem; border-radius: 4px; }
.alert.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
.alert.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
</style>