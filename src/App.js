import React from 'react';
import logo from './logo.svg';
import './App.css';

import Web3 from 'web3';


class App extends React.Component {
  state = {
    contract: null
  }

  async componentDidMount() {
    const web3 = new Web3(window.ethereum);
    await window.ethereum.enable();

    const contract = new web3.eth.Contract([
      {
        "constant": false,
        "inputs": [],
        "name": "allowSending",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [
          {
            "internalType": "address payable",
            "name": "destination",
            "type": "address"
          },
          {
            "internalType": "uint256",
            "name": "value",
            "type": "uint256"
          }
        ],
        "name": "send",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "payable": true,
        "stateMutability": "payable",
        "type": "fallback"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "_one",
            "type": "address"
          },
          {
            "internalType": "address",
            "name": "_two",
            "type": "address"
          }
        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "constructor"
      },
      {
        "constant": true,
        "inputs": [],
        "name": "getBalance",
        "outputs": [
          {
            "internalType": "uint256",
            "name": "",
            "type": "uint256"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      }
    ], '0xf1d74C2C7f3f2767675Cd5dd66497073961DBF13');
    // NameContract.methods.getBalance().call((err, res) => console.log(res));
    // NameContract.methods.send('0x7Dc84745ff4E6A53805F2f46985Fa002D8d1beeD', 10).call((err, res) => {
    //   if(err) {
    //     console.log(err)
    //   } else {
    //     console.log(res)
    //   }
    // })
    this.setState({ contract })
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <button onClick={() => this.state.contract.methods.getBalance().call((err, res) => console.log(res))}>Get Balance</button>
          <button onClick={() => this.state.contract.methods.allowSending().call()}>Allow Sending</button>
          <button onClick={() => this.state.contract.methods.send().call('0x7Dc84745ff4E6A53805F2f46985Fa002D8d1beeD', 10)}>Send</button>
        </header>
      </div>
    );
  }
  
}

export default App;
