<template>
  <div id="app">
    <section class="vh-100 gradient-custom">
      <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col-12 col-md-8 col-lg-6 col-xl-5 d-flex justify-content-center">
            <div class="card bg-dark text-white" style="border-radius: 1rem">
              <div class="card-body p-5 text-center">
                <div class="mb-md-5 mt-md-4 pb-5">
                  <h2 class="fw-bold mb-2 text-uppercase">Registro</h2>
                  <p class="text-white-50 mb-5">
                    Por favor Registre com seu e-mail e senha!
                  </p>

                  <form>
                    <div class="form-outline form-white mb-4">
                      <input
                        type="email"
                        id="typeEmailX"
                        class="form-control form-control-lg"
                        v-model="email"
                      />
                      <label class="form-label" for="typeEmailX">Email</label>
                    </div>
                    <div class="form-outline form-white mb-4">
                      <input
                        type="password"
                        id="typePasswordX"
                        class="form-control form-control-lg"
                        v-model="password"
                      />
                      <label class="form-label" for="typePasswordX">Senha</label>
                    </div>
                    <button
                      type="submit"
                      v-on:click.prevent="register"
                      class="btn btn-primary px-4"
                    >
                      Registrar
                    </button>
                  </form>
                  <a class="mt-3" type="submit" v-on:click.prevent="backLogin">
                    Voltar
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
    };
  },
  methods: {
    register() {
      fetch("/users/create", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({
          email: this.email,
          password: this.password,
        }),
      })
        .then((response) => {
          if (response.ok) {
            window.location.href = "/login";
            return response.json();
          } else {
            window.toastr.error("Não foi possivel criar o usuário");
            this.email = "";
            this.password = "";
            throw new Error("Error");
          }
        })
        .then((data) => {
          window.location.href = "/";
        })
        .catch((error) => {
          console.error(error);
        });
    },
    backLogin() {
      window.location.href = "/login";
    },
  },
};
</script>

<style>
.card {
  width: 350px;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}
</style>
