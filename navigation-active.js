// Navigation Active State Handler for DCorp Website
// Handles both multi-page navigation and single-page section scrolling

function initNavigation() {
  const currentPage = window.location.pathname.split('/').pop() || 'homepage-xang-dau-hat-nhua.html';
  const navLinks = document.querySelectorAll('.nav-links a');
  
  // Page-to-menu mapping
  const pageMap = {
    'homepage-xang-dau-hat-nhua.html': null, // Homepage uses section-based
    'index.html': null,
    'career.html': 'career',
    'gallery.html': 'gallery'
  };
  
  // Set active based on current page
  function setActiveByPage() {
    const targetPage = pageMap[currentPage];
    
    navLinks.forEach(link => {
      link.classList.remove('active');
      const href = link.getAttribute('href');
      
      // Match page-level links
      if (targetPage && href && (href.includes(targetPage) || href === currentPage)) {
        link.classList.add('active');
      }
    });
    
    // If on homepage, use scroll-based activation
    if (currentPage.includes('homepage') || currentPage === 'index.html' || currentPage === '') {
      setActiveByScroll();
    }
  }
  
  // Set active based on scroll position (for homepage sections)
  function setActiveByScroll() {
    const sections = document.querySelectorAll('section[id]');
    const scrollPos = window.scrollY + 150;
    let currentSection = '';
    
    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      
      if (scrollPos >= sectionTop && scrollPos < sectionTop + sectionHeight) {
        currentSection = section.id;
      }
    });
    
    navLinks.forEach(link => {
      link.classList.remove('active');
      const href = link.getAttribute('href');
      
      if (href && href.includes('#' + currentSection)) {
        link.classList.add('active');
      }
    });
    
    // Default to first link if no section matched (top of page)
    if (!currentSection && navLinks.length > 0) {
      const homeLink = Array.from(navLinks).find(link => {
        const href = link.getAttribute('href');
        return href === '#' || href.includes('homepage') || href === '#about';
      });
      if (homeLink) homeLink.classList.add('active');
    }
  }
  
  // Initialize
  setActiveByPage();
  
  // Listen to scroll events only on homepage
  if (currentPage.includes('homepage') || currentPage === 'index.html' || currentPage === '') {
    let scrollTimeout;
    window.addEventListener('scroll', () => {
      clearTimeout(scrollTimeout);
      scrollTimeout = setTimeout(setActiveByScroll, 100);
    });
  }
  
  // Handle clicks
  navLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      const href = link.getAttribute('href');
      
      // If it's an anchor link on the same page
      if (href && href.startsWith('#')) {
        e.preventDefault();
        const target = document.querySelector(href);
        if (target) {
          target.scrollIntoView({ behavior: 'smooth', block: 'start' });
          setTimeout(() => setActiveByScroll(), 500);
        }
      }
      
      // Close mobile menu
      document.getElementById('navLinks')?.classList.remove('open');
    });
  });
}

// Init on load
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initNavigation);
} else {
  initNavigation();
}
