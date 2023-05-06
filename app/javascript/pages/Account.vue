<template>
  <div id="app">
    <Header />

    <div class="container mt-1">
      <div class="row">
        <div class="col-md-4 sidebar">
          <div class="container mt-1 card-header">
            <h2 class="card-title">Conta</h2>
            <h3 class="card-subtitle">
              {{ this.accountData ? this.accountData.name : "" }}
            </h3>
          </div>
          <div class="card-header">
            <h2 class="card-title">Saldo disponível</h2>
            <h3 class="card-subtitle">
              R$ {{ this.accountData ? this.accountData.balance : 0 }}
            </h3>
          </div>
        </div>

        <div class="col-md-8 main-content">
          <form class="container mt-1 form-buttons-size" @submit.prevent="createAccount">
            <label>
              <input type="text" v-model="name" placeholder="Nome da Conta" />
            </label>
            <button class="btn btn-outline-secondary" type="submit">Criar conta</button>
          </form>
          <br />
          <form class="container mt-1 form-buttons-size" @submit.prevent="deposit">
            <label class="mt-1">
              <input type="number" step="0.01" v-model="amountDeposit" />
            </label>
            <button class="btn btn-outline-secondary mt-1" type="submit">Deposito</button>
          </form>
          <br />
          <form class="container mt-1 form-buttons-size" @submit.prevent="withdraw">
            <label class="mt-1">
              <input type="number" step="0.01" v-model="amountWithdraw" />
            </label>
            <button class="btn btn-outline-secondary mt-1" type="submit">Saque</button>
          </form>
          <br />
          <form class="container form-buttons-size" @submit.prevent="transfer">
            <label class="mt-1">
              Escolha uma conta para transferir:
              <select v-model="selectedAccountId">
                <option v-for="account in JSON.parse(accounts_id)" :value="account.id">
                  {{ account.name }}
                </option>
              </select>
            </label>
            <label class="mt-1">
              <input type="number" step="0.01" v-model="amountTransfer" />
            </label>
            <label>
              <input type="hidden" v-model="selectedAccountId" />
            </label>
            <button class="btn btn-outline-secondary mt-1" type="submit">
              Transferir
            </button>
          </form>
        </div>
      </div>

      <form @submit.prevent="filterTransactions">
        <div class="row mt-4 mx-auto">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="fromDate">Data inicial</label>
              <input type="date" id="fromDate" class="form-control" v-model="fromDate" />
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="toDate">Data final</label>
              <input type="date" id="toDate" class="form-control" v-model="toDate" />
            </div>
          </div>
          <button class="btn btn-outline-primary" type="submit">
            Filtrar transações
          </button>
        </div>
      </form>
    </div>

    <div
      class="modal"
      :class="{ fade: !showModal }"
      id="filteredTransactionsModal"
      v-bind:style="{ display: showModal ? 'contents' : '' }"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="filteredTransactionsModalLabel">
              Transações filtradas
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
              @click="closeModal()"
            ></button>
          </div>
          <div class="modal-body">
            <table class="table">
              <thead>
                <tr>
                  <th>Data</th>
                  <th>Valor</th>
                  <th>Tipo de transação</th>
                  <th>ID do destinatário</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="transaction in filteredTransactions" :key="transaction.id">
                  <td>{{ formatDate(transaction.created_at) }}</td>
                  <td>{{ transaction.amount }}</td>
                  <td>{{ transaction.transaction_type }}</td>
                  <td>{{ transaction.recipient_id || "-" }}</td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
              @click="closeModal()"
            >
              Fechar
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Header from "../components/Header";

export default {
  props: {
    current_user_id: {
      type: String,
      required: false,
    },
    current_account_id: {
      type: String,
      required: false,
    },
    accounts_id: {
      type: String,
      required: false,
    },
    account_info: {
      type: String,
      required: false,
    },
    transactions_info: {
      type: String,
      required: false,
    },
  },
  components: {
    Header,
  },
  data() {
    return {
      name: "",
      userId: "",
      accountId: "",
      recipientId: "",
      amount: 0,
      amountDeposit: 0,
      amountWithdraw: 0,
      amountTransfer: 0,
      balance: 0,
      selectedAccountId: "",
      accountInfo: null,
      accountData: "",
      transactionsData: "",
      fromDate: null,
      toDate: null,
      transactionsData: [],
      filteredTransactions: [],
      showModal: false,
    };
  },
  created() {
    if (this.account_info !== null) {
      this.accountData = JSON.parse(this.account_info);
    }
    if (this.transactions_info !== null) {
      this.transactionsData = JSON.parse(this.transactions_info);
    }
  },
  methods: {
    formatDate(dateString) {
      const date = new Date(dateString);
      const day = date.getDate().toString().padStart(2, "0");
      const month = (date.getMonth() + 1).toString().padStart(2, "0");
      const year = date.getFullYear().toString();
      return `${day}/${month}/${year}`;
    },
    createAccount() {
      axios
        .post(
          "/accounts/create",
          { name: this.name, user_id: this.current_user_id, balance: this.balance },
          {
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute("content"),
            },
          }
        )
        .then((response) => {
          window.toastr.success("Conta criada com sucesso!");
          this.name = "";
          this.userId = "";
          window.location.reload();
        })
        .catch((error) => {
          window.toastr.error("Não foi possivel criar sua conta!");
        });
    },
    deposit() {
      axios
        .put(
          `/accounts/${this.current_account_id}/deposit`,
          { account: this.current_account_id, amount: this.amountDeposit },
          {
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute("content"),
            },
          }
        )
        .then((response) => {
          console.log(response.data);
          window.toastr.success("Desposito realizado com sucesso!");
          this.reloadPage();
        })
        .catch((error) => {
          window.toastr.error("Não foi possivel realizar seu deposito.");
          console.log(error.response.data);
        });
    },
    withdraw() {
      axios
        .put(
          `/accounts/${this.current_account_id}/withdraw`,
          { account: this.current_account_id, amount: this.amountWithdraw },
          {
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute("content"),
            },
          }
        )
        .then((response) => {
          console.log(response.data);
          window.toastr.success("Saque realizado com sucesso!");
          this.reloadPage();
        })
        .catch((error) => {
          console.log(error.response.data);
          window.toastr.error("Não foi possivel realizar seu saque.");
        });
    },
    transfer() {
      axios
        .put(
          `/accounts/${this.current_account_id}/transfer`,
          {
            account: this.current_account_id,
            amount: this.amountTransfer,
            recipient_id: this.selectedAccountId,
          },
          {
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document
                .querySelector('meta[name="csrf-token"]')
                .getAttribute("content"),
            },
          }
        )
        .then((response) => {
          console.log(response.data);
          window.toastr.success("Transferência realizada com sucesso!");
          this.reloadPage();
        })
        .catch((error) => {
          console.log(error.response.data);
          window.toastr.error("Não foi possivel realizar sua transferência.");
        });
    },
    reloadPage() {
      setTimeout(function () {
        window.location.reload();
      }, 500);
    },
    filterTransactions() {
      const fromDateParts = this.fromDate.split("-");
      const toDateParts = this.toDate.split("-");

      this.fromDateObj = new Date(
        parseInt(fromDateParts[0]),
        parseInt(fromDateParts[1]) - 1,
        parseInt(fromDateParts[2]),
        0,
        0,
        0,
        0
      );

      this.toDateObj = new Date(
        parseInt(toDateParts[0]),
        parseInt(toDateParts[1]) - 1,
        parseInt(toDateParts[2]),
        23,
        59,
        59,
        999
      );

      this.filteredTransactions = this.transactionsData.filter((transaction) => {
        const transactionDate = new Date(transaction.created_at);
        return transactionDate >= this.fromDateObj && transactionDate <= this.toDateObj;
      });

      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
  },
};
</script>

<style>
.table-dark {
  background-color: #343a40;
}

.table-dark th,
.table-dark td {
  border-color: #454d55;
}

.table-dark th {
  color: #fff;
}

.table-dark tbody tr:nth-of-type(odd) {
  background-color: #454d55;
}

.table-dark tbody tr:hover {
  background-color: #4e5d6c;
}

.form-buttons-size {
  min-width: 388px !important;
}

@media (min-width: 576px) {
  .modal-dialog {
    max-width: 75% !important;
  }
}
</style>
