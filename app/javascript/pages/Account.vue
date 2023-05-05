<template>
  <div id="app">
    <Header />
    <h1>Conta</h1>
    <h4>{{this.accountData.name}}</h4>
    <h3>
      Saldo Atual: {{this.accountData.balance}}
    </h3>
    <form @submit.prevent="createAccount">
      <label>
        Name:
        <input type="text" v-model="name">
      </label>
      <button type="submit">Criar conta</button>
    </form>
    <br>
    <form @submit.prevent="deposit">
      <label>
        Amount:
        <input type="number" step="0.01" v-model="amountDeposit">
      </label>
      <button type="submit">Deposit</button>
    </form>
    <br>
    <form @submit.prevent="withdraw">
      <label>
        Amount:
        <input type="number" step="0.01" v-model="amountWithdraw">
      </label>
      <button type="submit">Withdraw</button>
    </form>
    <br>
    <form @submit.prevent="transfer">
      <label>
        Recipient ID:
        <select v-model="selectedAccountId">
          <option v-for="account in JSON.parse(accounts_id)" :value="account.id">{{ account.name }}</option>
        </select>
      </label>
      <label>
        Amount:
        <input type="number" step="0.01" v-model="amountTransfer">
      </label>
      <label>
        Recipient ID:
        <input type="hidden" v-model="selectedAccountId">
        <span>{{ selectedAccountId }}</span>
      </label>

      <button type="submit">Transfer</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import Header from '../components/Header'

export default {
  props: {
    current_user_id: {
      type: String,
      required: false
    },
    current_account_id: {
      type: String,
      required: false
    },
    accounts_id: {
      type: String,
      required: false
    },
    account_info: {
      type: String,
      required: false
    },
  },
  components: {
    Header
  },
  data() {
    return {
      name: '',
      userId: '',
      accountId: '',
      recipientId: '',
      amount: 0,
      amountDeposit: 0,
      amountWithdraw: 0,
      amountTransfer: 0,
      balance: 0,
      selectedAccountId: '',
      accountInfo: null,
      accountData: ''
    }
  },
  created() {
    if (this.accountData){
      this.accountData = JSON.parse(this.account_info)
    }
  },
  methods: {
    createAccount() {
      axios.post('/accounts/create', { name: this.name, user_id: this.current_user_id, balance: this.balance }, {
        headers: {
          'Content-Type': "application/json",
          'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      })
      .then(response => {
        window.toastr.success('Conta criada com sucesso!')
        this.name = ''
        this.userId = ''
        window.location.reload();
      })
      .catch(error => {
        window.toastr.error('Não foi possivel criar sua conta!')
      })
    },
    deposit() {
      axios.put(`/accounts/${this.current_account_id}/deposit`, { account: this.current_account_id, amount: this.amountDeposit }, {
        headers: {
          'Content-Type': "application/json",
          'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      })
      .then(response => {
        console.log(response.data)
        window.toastr.success('Desposito realizado com sucesso!')
        this.amountDeposit = ''
      })
      .catch(error => {
        window.toastr.error('Não foi possivel realizar seu deposito.')
        console.log(error.response.data)
      })
    },
    withdraw() {
      axios.put(`/accounts/${this.current_account_id}/withdraw`, { account: this.current_account_id, amount: this.amountWithdraw }, {
        headers: {
          'Content-Type': "application/json",
          'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      })
      .then(response => {
        console.log(response.data)
        window.toastr.success('Saque realizado com sucesso!')
        this.amountWithdraw = ''
      })
      .catch(error => {
        console.log(error.response.data)
        window.toastr.error('Não foi possivel realizar seu saque.')
      })
    },
    transfer() {
      axios.put(`/accounts/${this.current_account_id}/transfer`, { account: this.current_account_id, amount: this.amountTransfer, recipient_id: this.selectedAccountId }, {
        headers: {
          'Content-Type': "application/json",
          'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      })
      .then(response => {
        console.log(response.data)
        this.amountTransfer = ''
        window.toastr.success('Transferência realizada com sucesso!')
      })
      .catch(error => {
        console.log(error.response.data)
        window.toastr.error('Não foi possivel realizar sua transferência.')
      })
    },
  }
}
</script>