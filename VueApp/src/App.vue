<template>
    <div id="app">
        <h1>Vault Piece</h1>
        <p>Account: {{ account }}</p>
        <input type="file" @change="captureFile">
        <button @click="uploadFile">Upload</button>
    </div>
</template>

<script lang="ts">
</script>
