import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Register from '../pages/Register'
import Login from '../pages/Login'
import Account from '../pages/Account'
import Header from '../components/Header'
import toastr from 'toastr'
window.toastr = toastr

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#main',
    data() {
      return {
      };
    },
      components: { App, Register, Login, Header, Account }
  })
})
