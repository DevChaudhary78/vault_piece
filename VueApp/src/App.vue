<template>
    <div id="app">
        <h1>Vault Piece</h1>
        <h2>Account: {{ account }}</h2>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { web3 } from "./web3";

const account = ref<string>("");

onMounted(async () => {
    const web3Instance = await web3;
    if (web3Instance !== null) {
        const accounts = await web3Instance.eth.getAccounts();
        account.value = accounts[0];
    }
})
</script>
