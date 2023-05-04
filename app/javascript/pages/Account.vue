<template>
  <div>
    <h1>Accounts</h1>
    <form @submit.prevent="createAccount">
      <label>
        Name:
        <input type="text" v-model="name">
      </label>
      <label>
        User ID:
        <input type="text" v-model="userId">
      </label>
      <button type="submit">Create account</button>
    </form>
    <br>
    <form @submit.prevent="deposit">
      <label>
        Account ID:
        <input type="text" v-model="accountId">
      </label>
      <label>
        Amount:
        <input type="number" step="0.01" v-model="amount">
      </label>
      <button type="submit">Deposit</button>
    </form>
    <br>
    <form @submit.prevent="withdraw">
      <label>
        Account ID:
        <input type="text" v-model="accountId">
      </label>
      <label>
        Amount:
        <input type="number" step="0.01" v-model="amount">
      </label>
      <button type="submit">Withdraw</button>
    </form>
    <br>
    <form @submit.prevent="transfer">
      <label>
        Account ID:
        <input type="text" v-model="accountId">
      </label>
      <label>
        Recipient ID:
        <input type="text" v-model="recipientId">
      </label>
      <label>
        Amount:
        <input type="number" step="0.01" v-model="amount">
      </label>
      <button type="submit">Transfer</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      name: '',
      userId: '',
      accountId: '',
      recipientId: '',
      amount: 0
    }
  },
  methods: {
    createAccount() {
      axios.post('/accounts', {
        account: {
          name: this.name,
          user_id: this.userId
        }
      })
      .then(response => {
        console.log(response.data)
        this.name = ''
        this.userId = ''
      })
      .catch(error => {
        console.log(error.response.data)
      })
    },
    async deposit(accountId, amount) {
      try {
        const response = await axios.put(`/accounts/${accountId}/deposit`, { amount: amount });
        return response.data.deposited;
      } catch (error) {
        console.error(error);
        return false;
      }
    },

    async withdraw(accountId, amount) {
      try {
        const response = await axios.put(`/accounts/${accountId}/withdraw`, { amount: amount });
        return response.data.withdrawn;
      } catch (error) {
        console.error(error);
        return false;
      }
    },

    async transfer(accountId, recipientId, amount) {
      try {
        const response = await axios.put(`/accounts/${accountId}/transfer`, { recipient_id: recipientId, amount: amount });
        return response.data.transferred;
      } catch (error) {
        console.error(error);
        return false;
      }
    }
  }
}
