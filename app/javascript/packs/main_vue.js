import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Register from '../pages/Register'
import Home from '../pages/Home'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#main',
    data() {
      return {
      };
    },
      components: { App, Register, Home }
  })
})
