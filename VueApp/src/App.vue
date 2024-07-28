<template>
    <div id="app">
        <h1>Vault Piece</h1>
        <p>Account: {{ account }}</p>
        <input type="file" @change="captureFile">
        <button @click="uploadFile">Upload</button>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { create } from 'ipfs-http-client';
import Web3 from 'web3';
import FileStorage from "../../Contracts/build/contracts/FileStorage.json"

const account = ref<string>('');
const contract = ref<any>(null);
const buffer = ref<Buffer | null>(null);
const fileName = ref<string>('');
const fileType = ref<string>('');

const ipfs = create({ url: 'https://ipfs.infura.io:5001/api/v0' });

onMounted(() => {
    loadBlockchainData();
}) 


async function loadBlockchainData() {
    const web3 = new Web3(Web3.givenProvider || 'https://localhost:7545');
    const accounts = await web3.eth.requestAccounts();
    account.value = accounts[0];
    const networkId = await web3.eth.net.getId();
    const networkData = FileStorage.networks[networkId];

    if(networkData) {
        contract.value = new web3.eth.Contract(FileStorage.abi, networkData.address);
    } else {
        alert('FileStorage contract not deployed to detected network.');
    }
}

function captureFile(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
        const file = inputElement.files[0];
        const reader = new FileReader();
        reader.readAsArrayBuffer(file);
        reader.onloadend = () => {
            buffer.value = Buffer.from(reader.result as string);
            fileName.value = file.name;
            fileType.value = file.type;
        }
    }
}

async function uploadFile() {
    if(!buffer.value) {
        console.error('No File Selected!')
        return;
    }
    const result = await ipfs.add(buffer.value)
    const ipfsHash = result.path;
    contract.value.methods.uploadFile(ipfsHash, fileName.value, buffer.value.byteLength, fileType.value).send({from: account.value})
}
</script>