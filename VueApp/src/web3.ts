import Web3 from 'web3'

async function connectWallet() {
  if ((window as any).ethereum) {
    try {
      await (window as any).ethereum.request({ method: 'eth_requestAccounts' })
      const web3 = new Web3((window as any).ethereum)
      console.log('Connected to MetaMask 🦊')
      return web3
    } catch (err) {
      console.error('User denied account access', err)
      return null
    }
  } else if (Web3.givenProvider) {
    const web3 = new Web3(Web3.givenProvider)
    console.log('Connected to Given Provider 🎁')
    return web3
  } else {
    console.log('No wallet detected. Falling back to http://localhost:8545')
    const web3 = new Web3('http://localhost:8545')
    return web3
  }
}

export const web3 = connectWallet()
