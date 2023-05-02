import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Register from '../pages/Register'
import Home from '../pages/Home'
import Login from '../pages/Login'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#main',
    data() {
      return {
      };
    },
      components: { App, Register, Home, Login }
  })
})
