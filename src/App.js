import React from 'react';
import './App.css';

import Web3 from 'web3';
import { CONTRACT_ADDRESS, CONTRACT_ABI } from './contract/constants.js';

class App extends React.Component {
  state = {
    contract: null,
    accounts: null,
    destination: null,
  }

  async componentDidMount() {
    const web3 = new Web3(window.ethereum);
    await window.ethereum.enable();

    web3.eth.getAccounts((err, accounts) => this.setState({ accounts }))
    window.ethereum.on('accountsChanged', (accounts) => {
      this.setState({ accounts })
    })

    const contract = new web3.eth.Contract(CONTRACT_ABI, CONTRACT_ADDRESS);
    this.setState({ contract })
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1>Multi Sig dApp</h1>
          <button onClick={() => this.state.contract.methods.getBalance().call((err, res) => console.log(res))}>Get Balance</button>
          <button onClick={() => this.state.contract.methods.allowSending().send({from: this.state.accounts[0]})}>Allow Sending</button>
          <div>
            <input type="text" placeholder="destination address" onChange={e => this.setState({ destination: e.target.value })}/>
            <button onClick={() => this.state.contract.methods.send(this.state.destination, 10).send({ from: this.state.accounts[0] })}>Send</button>
          </div>
        </header>
      </div>
    );
  }
}

export default App;
