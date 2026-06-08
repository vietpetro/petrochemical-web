<template>
  <div class="news-detail" v-if="article">
    <h1>{{ article.title }}</h1>
    <p class="meta">Ngày đăng: {{ formatDate(article.publishedAt) }}</p>
    <div v-if="article.source" class="source">
      Nguồn: <a :href="article.source.url" target="_blank" rel="noopener noreferrer">{{ article.source.name }}</a>
    </div>
    <div class="tags">
      <span v-for="tag in article.tags" :key="tag" class="tag">{{ tag }}</span>
    </div>
    <article class="content">{{ article.content }}</article>
  </div>
  <div v-else>
    <p>Không tìm thấy bài viết.</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import newsIndex from '../../data/news/index.json';
const route = useRoute();
const article = ref(null);
const slug = route.params.slug;

onMounted(async () => {
  if (!slug) return;
  const maybe = newsIndex.find(i => i.slug === slug);
  if (!maybe) return;
  try {
    const m = await import(`../../data/news/posts/${slug}.json`);
    article.value = m.default ?? m;
  } catch {
    article.value = null;
  }
});

function formatDate(iso) {
  if (!iso) return '';
  try {
    return new Date(iso).toLocaleString('vi-VN', { timeZone: 'Asia/Saigon' });
  } catch {
    return iso;
  }
}
</script>

<style scoped>
.news-detail { padding: 2rem; max-width: 800px; margin: 0 auto; }
.meta, .source { font-size: 0.875rem; color: #666; margin-top: 0.5rem; }
.tags { margin-top: 0.5rem; display: flex; gap: 0.25rem; }
.tag { background: #f0f0f0; padding: 0.125rem 0.375rem; border-radius: 999px; font-size: 0.75rem; }
.content { margin-top: 1.5rem; line-height: 1.6; white-space: pre-wrap; }
</style>