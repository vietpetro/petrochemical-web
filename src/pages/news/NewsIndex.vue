<template>
  <div class="news-index">
    <h1>Tin tức</h1>
    <ul>
      <li v-for="item in news" :key="item.id">
        <router-link :to="`/news/${item.slug}`">{{ item.title }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import newsData from '../../data/news/index.json';
const news = ref(newsData);
</script>

<style scoped>
.news-index { padding: 2rem; }
</style>
