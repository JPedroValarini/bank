<template>
  <div id="app">
    <form>
      <div>
        <label>Email</label>
        <input type="text" v-model="email">
      </div>
      <div>
        <label>Senha</label>
        <input type="password" v-model="password">
      </div>
      <div>
        <button type="submit" v-on:click.prevent="login">Entrar</button>
      </div>
    </form>
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
    login() {
      fetch("/users", {
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
            throw new Error("Erro ao tentar fazer login");
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