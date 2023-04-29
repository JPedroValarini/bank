import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Application from '../pages/Application'



document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#main',
    data() {
      return {
      };
    },
      components: { App, Application }
  })
})
