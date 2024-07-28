<template>
    <div id="app">
        <h1>Vault Piece</h1>
        <p>Account: {{ account }}</p>
        <input type="file" @change="captureFile">
        <button @click="uploadFile">Upload</button>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const account = ref<string | null>('');

function captureFile() {
    console.log("I am working! ✨")
}

function uploadFile() {
    console.log("I am working as well 🌟")
}
</script>