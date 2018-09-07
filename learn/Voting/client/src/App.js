import React, { Component } from "react";
import VotingContract from "./contracts/Voting.json";
import getWeb3 from "./utils/getWeb3";
// import truffleContract from "truffle-contract";

import "./App.css";

//合约地址0x81ae2ffc4119090f2d320f19ae9a3726c8a80cae
const contractAddress = "0x81ae2ffc4119090f2d320f19ae9a3726c8a80cae";
//合约实例
var votingContractInstance;
var account;

var _modifyVotingCount = (candidates, i, votingCount) => {

    let obj = candidates[i];
    obj.votingCount = votingCount;
    return candidates;
}

class App extends Component {
  state = { storageValue: 0, web3: null, accounts: null, contract: null };

  constructor(props) {
      super(props)

      this.state = {
        candidates: [
                      {
                        "name": "Rama",
                        "id": 1,
                        "votingCount": 0
                      },
                      {
                        "name": "Nick",
                        "id": 2,
                        "votingCount": 0
                      },
                      {
                        "name": "Jose",
                        "id": 3,
                        "votingCount": 0
                      },
                      {
                        "name": "haha",
                        "id": 4,
                        "votingCount": 0
                      },
                      {
                        "name": "hehe",
                        "id": 5,
                        "votingCount": 0
                      }
                    ],
        candidatesVoteCount: ["0","0","0","0","0"],
        web3: null
      }
    }

    componentWillMount() {
        // Get network provider and web3 instance.
        // See utils/getWeb3 for more info.

        getWeb3
        .then(results => {
          this.setState({
            web3: results.web3
          })

          // Instantiate contract once web3 provided.
          //初始化合约
          this.instantiateContract()
        })
        .catch(() => {
          console.log('Error finding web3.')
        })
      }

  instantiateContract() {

      const contract = require('truffle-contract')
      const votingContract = contract(VotingContract)
      votingContract.setProvider(this.state.web3.currentProvider)


      // Get accounts.
      this.state.web3.eth.getAccounts((error, accounts) => {
        console.log(accounts);
        votingContract.at(contractAddress).then((instance) => {
          account = accounts[0];
          votingContractInstance = instance; //部署完的合约实例
          console.log(votingContractInstance);//合约实例对象

          for (let i = 0; i < this.state.candidates.length; i++) {
              console.log(this.state.candidates[i]);//合约实例对象
            votingContractInstance.totalVotesFor(this.state.candidates[i].id,{from:accounts[0]})
            .then((result) =>{
              console.log(i);
              this.setState({
                candidates:_modifyVotingCount(this.state.candidates,i,result.words[0])
              })
            })
          }
          return;
        })
      })
    }

  render() {
    return (
      <div className="App">
         <ul>
         {
           this.state.candidates.map((person) =>{
              return (
                <li key={person.id}>候选人：{person.name} 候选人Id:{person.id} 获得{person.votingCount}票</li>
              )
           })
         }
         </ul>

         <input
           ref="votingInput" placeholder="请输入候选人Id..."
         style={{width:200,height:40,borderWidth:2,marginLeft:30}}></input>
         <button onClick={() =>{
           let candidateId = this.refs.votingInput.value;
           console.log(this.state.web3.eth.accounts[0]);
           votingContractInstance.voteForCandidate(candidateId,{from:account})
           .then((result => {
             console.log(result);
             for (let i = 0; i < this.state.candidates.length; i++) {
                 console.log(this.state.candidates[i]);//合约实例对象
               votingContractInstance.totalVotesFor(this.state.candidates[i].id,{from:account})
               .then((result) =>{
                 console.log(i);
                 this.setState({
                   candidates:_modifyVotingCount(this.state.candidates,i,result.words[0])
                 })
               })
             }
           }))
         }}>Voting</button>
      </div>
    );
  }


}

export default App;
