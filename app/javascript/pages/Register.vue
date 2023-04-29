<template>
  <div id="app" class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card">
      <div class="card-body">
        <h2 class="text-center mb-4">Register</h2>
        <form>
          <div class="form-group">
            <label>Email</label>
            <input type="text" v-model="email" class="form-control" placeholder="Seu email">
          </div>
          <div class="form-group">
            <label>Senha</label>
            <input type="password" v-model="password" class="form-control" placeholder="Sua senha">
          </div>
          <div class="text-center">
            <button type="submit" v-on:click.prevent="register" class="btn btn-primary px-4">Entrar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: ""
    };
  },
  methods: {
    register() {
      fetch("/users/create", {
        method: "POST",
        headers: {
            'Content-Type': "application/json",
            'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
        body: JSON.stringify({
          email: this.email,
          password: this.password
        })
      })
        .then(response => {
          if (response.ok) {
            return response.json();
          } else {
            throw new Error("Erro ao tentar fazer register");
          }
        })
        .then(data => {
          console.log(data);
          // Aqui você pode redirecionar o usuário para a página principal do seu aplicativo
        })
        .catch(error => {
          console.error(error);
        });
    }
  }
};
</script>

<style>
.card {
  width: 350px;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}
</style>