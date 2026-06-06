import { createRouter, createWebHistory } from 'vue-router';
import HomePage from '@/pages/HomePage.vue';
import AboutPage from '@/pages/AboutPage.vue';
import BusinessIndex from '@/pages/business/BusinessIndex.vue';
import BusinessDetail from '@/pages/business/BusinessDetail.vue';
import QuotePage from '@/pages/business/QuotePage.vue';
import NewsIndex from '@/pages/news/NewsIndex.vue';
import NewsDetail from '@/pages/news/NewsDetail.vue';
import CareerLayout from '@/pages/career/CareerLayout.vue';
import CareerSection from '@/pages/career/CareerSection.vue';
import ContactPage from '@/pages/ContactPage.vue';

const routes = [
  { path: '/', name: 'home', component: HomePage, meta: { title: 'Trang chủ' } },
  { path: '/about', name: 'about', component: AboutPage, meta: { title: 'Giới thiệu' } },
  { path: '/business', name: 'business', component: BusinessIndex, meta: { title: 'Business Unit' } },
  { path: '/business/:unitId', name: 'business-detail', component: BusinessDetail, meta: { title: 'Business Unit' } },
  { path: '/business/:unitId/quote', name: 'business-quote', component: QuotePage, meta: { title: 'Yêu cầu báo giá' } },
  { path: '/news', name: 'news', component: NewsIndex, meta: { title: 'Tin tức' } },
  { path: '/news/:slug', name: 'news-detail', component: NewsDetail, meta: { title: 'Tin tức' } },
  { path: '/blog', redirect: '/news' },
  { path: '/blog/:slug', redirect: to => `/news/${to.params.slug}` },
  {
    path: '/career',
    component: CareerLayout,
    children: [
      { path: '', name: 'career', component: CareerSection, props: { sectionId: 'overview' }, meta: { title: 'Gia nhập DCorp' } },
      { path: 'culture', name: 'career-culture', component: CareerSection, props: { sectionId: 'culture' }, meta: { title: 'Văn hóa' } },
      { path: 'benefits', name: 'career-benefits', component: CareerSection, props: { sectionId: 'benefits' }, meta: { title: 'Phúc lợi' } },
      { path: 'gallery', name: 'career-gallery', component: CareerSection, props: { sectionId: 'gallery' }, meta: { title: 'Hình ảnh' } },
      { path: 'jobs', name: 'career-jobs', component: CareerSection, props: { sectionId: 'jobs' }, meta: { title: 'Tuyển dụng' } },
      { path: 'apply', name: 'career-apply', component: CareerSection, props: { sectionId: 'apply' }, meta: { title: 'Ứng tuyển' } }
    ]
  },
  { path: '/contact', name: 'contact', component: ContactPage, meta: { title: 'Liên hệ' } }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 };
  }
});

router.afterEach((to) => {
  const siteName = import.meta.env.VITE_SITE_NAME || 'DCorp';
  document.title = `${to.meta.title || 'Trang'} | ${siteName}`;
});

export default router;
