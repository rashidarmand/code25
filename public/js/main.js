// Initialize All Materialize Plugins
M.AutoInit();


// Grabbing elements before I add the scroll behavior
let backToTop = document.querySelector('#backToTop');
let mainHeader = document.querySelector('.main-header')
let ourStory = document.querySelector('.our-story')
let ourFeatures = document.querySelectorAll('.our-features')
let row1 = document.querySelectorAll('.row1')
let row2 = document.querySelectorAll('.row2')


// Back to top button scroll behavior
backToTop.addEventListener('click', (event) => {
  document.querySelector('#logo').scrollIntoView({ behavior: 'smooth' });
});


// Home Page Scroll Behavior
window.addEventListener('scroll', (event) => {
  if (window.scrollY > 535) {
    ourStory.classList.add('fadeIn')
  }
});

window.addEventListener('scroll', (event) => {
  if (window.scrollY > 1450) {
    ourFeatures.forEach((element)=>{element.classList.add('fadeInUp')})
  }
});


// Product Rows Scroll Behavior
window.addEventListener('scroll', (event) => {
  if (window.scrollY > 365) {
    row1.forEach((element)=>{element.classList.add('fadeInRight')})
  }
});

window.addEventListener('scroll', (event) => {
  if (window.scrollY > 765) {
    row2.forEach((element)=>{element.classList.add('fadeInLeft')})
  }
});
