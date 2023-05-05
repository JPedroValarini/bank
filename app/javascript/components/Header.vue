<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-end">
    <div class="d-flex">
      <div class="container">
        <a class="navbar-brand" href="#" @click="redirect('/teste')">Account</a>
      </div>
      <div class="container" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <button class="btn btn-outline-secondary" @click="logout()">Logout</button>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import axios from 'axios';

export default {
  methods: {
    logout() {
      axios.post('/login/destroy', {}, {
        headers: {
          'Content-Type': "application/json",
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      })
      .then(response => {
        window.location.href = '/login';
      })
      .catch(error => {
        console.error(error.response.data);
      });
    },
    redirect(url) {
      window.location.href = url;
    }
  }
}
</script>