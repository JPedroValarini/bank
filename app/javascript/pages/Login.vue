<template>
  <div id="app">
    <section class="vh-100 gradient-custom">
      <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col-12 col-md-8 col-lg-6 col-xl-5">
            <div class="card bg-dark text-white" style="border-radius: 1rem;">
              <div class="card-body p-5 text-center">

                <div class="mb-md-5 mt-md-4 pb-5">

                  <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
                  <p class="text-white-50 mb-5">Por favor entre com seu e-mail e senha!</p>

                  <form @submit.prevent="login">
                    <div class="form-outline form-white mb-4">
                      <input type="email" id="typeEmailX" class="form-control form-control-lg" v-model="email" />
                      <label class="form-label" for="typeEmailX">Email</label>
                    </div>

                    <div class="form-outline form-white mb-4">
                      <input type="password" id="typePasswordX" class="form-control form-control-lg" v-model="password" />
                      <label class="form-label" for="typePasswordX">Senha</label>
                    </div>
                    <p class="small mb-5 pb-lg-2"><a class="text-white-50" href="#!">Esqueceu a senha?</a></p>

                    <button class="btn btn-outline-light btn-lg px-5" type="submit">Login</button>
                  </form>

                  <div class="d-flex justify-content-center text-center mt-4 pt-1">
                    <a href="#!" class="text-white"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="#!" class="text-white"><i class="fab fa-twitter fa-lg mx-4 px-2"></i></a>
                    <a href="#!" class="text-white"><i class="fab fa-google fa-lg"></i></a>
                  </div>
                </div>

                <div>
                  <p class="mb-3"> Ainda não tem uma conta? 
                  </p>
                  <button class="btn btn-outline-light btn-lg px-3"  v-on:click="createAccount">Criar conta</button>
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
import axios from 'axios';

export default {
  data() {
    return {
      email: '',
      password: '',
    };
  },
  methods: {
    login() {
      axios.post('/login/create', { email: this.email, password: this.password }, {
        headers: {
          'Content-Type': "application/json",
          'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      })
      .then(response => {
        if (response.status === 200) {
          window.location.href = '/';
        }
      })
      .catch(error => {
        window.toastr.error('Não foi possivel fazer o login, verifique seu usuário e senha.')
      });
    },
    createAccount() {
      window.location.href = '/register';
    }
  },
};
</script>