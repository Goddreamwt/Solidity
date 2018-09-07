**You may as well be bold to love someone, to climb a mountain,to chase your dream.**
你不妨大胆一些，爱一个人，攀一座山，追一个梦。


----------


## 安装所需工具

首先开发机上必须装好Node.js，再使用以下命令安装所需的工具

```
$ npm install -g ethereumjs-testrpc truffle
```

```
macdeiMac:~ mac$ npm install -g ethereumjs-testrpc truffle
npm WARN deprecated ethereumjs-testrpc@6.0.3: ethereumjs-testrpc has been renamed to ganache-cli, please use this package from now on.
/usr/local/bin/testrpc -> /usr/local/lib/node_modules/ethereumjs-testrpc/build/cli.node.js
/usr/local/bin/truffle -> /usr/local/lib/node_modules/truffle/build/cli.bundled.js
+ ethereumjs-testrpc@6.0.3
+ truffle@4.1.14
updated 3 packages in 134.279s
macdeiMac:~ mac$ npm ganache-cli install

Usage: npm <command>

where <command> is one of:
access, adduser, bin, bugs, c, cache, completion, config,
ddp, dedupe, deprecate, dist-tag, docs, doctor, edit,
explore, get, help, help-search, i, init, install,
install-test, it, link, list, ln, login, logout, ls,
outdated, owner, pack, ping, prefix, profile, prune,
publish, rb, rebuild, repo, restart, root, run, run-script,
s, se, search, set, shrinkwrap, star, stars, start, stop, t,
team, test, token, tst, un, uninstall, unpublish, unstar,
up, update, v, version, view, whoami

npm <command> -h     quick help on <command>
npm -l           display full usage info
npm help <term>  search for help on <term>
npm help npm     involved overview

Specify configs in the ini-formatted file:
/Users/mac/.npmrc
or on the command line via: npm <command> --key value
Config info can be viewed via: npm help config

npm@5.6.0 /usr/local/lib/node_modules/npm


╭─────────────────────────────────────╮
│                                     │
│   Update available 5.6.0 → 6.4.1    │
│     Run npm i -g npm to update      │
│                                     │
╰─────────────────────────────────────╯
```

##创建项目

```
macdeiMac:~ mac$ cd /Users/mac/Desktop/GitHub/Solidity/learn/Voting 
macdeiMac:Voting mac$ ls
macdeiMac:Voting mac$ pwd
/Users/mac/Desktop/GitHub/Solidity/learn/Voting
macdeiMac:Voting mac$ truffle unbox react-box
Downloading...
Unpacking...
Setting up...
Unbox successful. Sweet!

Commands:

Compile:              truffle compile
Migrate:              truffle migrate
Test contracts:       truffle test
Test dapp:            cd client && npm test
Run dev server:       cd client && npm run start
Build for production: cd client && npm run build
macdeiMac:Voting mac$ 

```

##编写投票Dapp智能合约

在`contracts`文件夹下创建`Voting.sol`文件，将下面的代码拷贝到文件中。

```
pragma solidity ^0.4.24;

contract Voting {


//   ["wt","mayun","liuyifei","zhaoliying","mahuateng"]
//   [1,2,3,4,5]


// 存储候选人ID的数组
//   bytes32[] candidateNames =new bytes32[](5);
//   bytes32[] candidateNames = ["wt","mayun","liuyifei","zhaoliying","mahuateng"];
uint[] candidateIds;
mapping (uint => uint) public votesReceived;
// 构造函数 初始化候选人名单
constructor(uint[] _candidateIds) public {

candidateIds = _candidateIds;
}

// 查询某个候选人的总票数
function totalVotesFor(uint candidate) public constant returns (uint) {
require(validCandidate(candidate) == true);
// 或者
// assert(validCandidate(candidate) == true);
return votesReceived[candidate];
}

// 为某个候选人投票
function voteForCandidate(uint candidate)public {
assert(validCandidate(candidate) == true);
votesReceived[candidate] += 1;
}

// 检索投票的ID是不是候选人的ID
function validCandidate(uint candidate) public constant returns (bool) {
for(uint i = 0; i < candidateIds.length; i++) {
if (candidateIds[i] == candidate) {
return true;
}
}
return false;
}
}


```
修改`migrations/2_deploy_contracts.js`

```
var Voting = artifacts.require("./Voting.sol");

module.exports = function(deployer) {
deployer.deploy(Voting);
};

```

##通过remix + metamask部署合约到Kovan Test Net

- Google浏览器`MetaMask`插件安装前面的文章中有



- 打开https://remix.ethereum.org将合约代码拷贝到里面



- 确保`MetaMask`账号处于等于状态，并且有一定的以太币支付给矿工。
- 确保`Environment`是`Injected Web3`，如果切换不过来，关掉浏览器重新启动
- 在`Deploy`函数中输入一个数组，数组里面的内容为候选人Id名单
- 点击`Deploy`按钮，会弹出`MetaMask`界面让你确认，确认提交，过一会儿，合约就部署成功
- 可以测试给某个候选人投票，查询某个候选人的票数

##拷贝合约地址


```
0xc36c23c1e6eb12f8df63c787ef06aecd1f38b778
```

##编译合约

使用`truffle develop`
```
macdeiMac:Voting mac$ truffle develop
Truffle Develop started at http://127.0.0.1:9545/

Accounts:
(0) 0x627306090abab3a6e1400e9345bc60c78a8bef57
(1) 0xf17f52151ebef6c7334fad080c5704d77216b732
(2) 0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef
(3) 0x821aea9a577a9b44299b9c15c88cf3087f3b5544
(4) 0x0d1d4e623d10f9fba5db95830f7d3839406c6af2
(5) 0x2932b7a2355d6fecc4b5c0b6bd44cc31df247a2e
(6) 0x2191ef87e392377ec08e7c08eb105ef5448eced5
(7) 0x0f4f2ac550a1b4e2280d04c21cea7ebd822934b5
(8) 0x6330a553fc93768f612722bb8c2ec78ac90b3bbc
(9) 0x5aeda56215b167893e80b4fe645ba6d5bab767de

Private Keys:
(0) c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3
(1) ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f
(2) 0dbbe8e4ae425a6d2687f1a7e3ba17bc98c673636790f1b8ad91193c05875ef1
(3) c88b703fb08cbea894b6aeff5a544fb92e78a18e19814cd85da83b71f772aa6c
(4) 388c684f0ba1ef5017716adb5d21a053ea8e90277d0868337519f97bede61418
(5) 659cbb0e2411a44db63778987b1e22153c086a95eb6b18bdf89de078917abc63
(6) 82d052c865f5763aad42add438569276c00d3d88a2d062d36b2bae914d58b8c8
(7) aa3680d5d48a8283413f7a108367c7299ca73f553735860a87b08f39395618b7
(8) 0f62d96d6675f32685bbdb8ac13cda7c23436f63efbb9d07700d8669ff12b7c4
(9) 8d5366123cb560bb606379f90a0bfd4769eecc0557f1b362dcae9012b548b1e5

Mnemonic: candy maple cake sugar pudding cream honey rich smooth crumble sweet treat

⚠️  Important ⚠️  : This mnemonic was created for you by Truffle. It is not secure.
Ensure you do not use it on production blockchains, or else you risk losing funds.

```
使用`truffle compile`
```
macdeiMac:Voting mac$ truffle compile
Compiling ./contracts/Migrations.sol...
Compiling ./contracts/SimpleStorage.sol...
Compiling ./contracts/Voting.sol...
Writing artifacts to ./build/contracts
```

编译完合约以后在`build/contracts`文件夹下面会有一个`Voting.json`的`abi`文件。

这个文件是编译后的`abi`文件，待会儿需要将这个文件的`json`导入到`App.json`中。

##查看client/src/utils/getWeb3.js

```
import Web3 from 'web3'

let getWeb3 = new Promise(function(resolve, reject) {
// Wait for loading completion to avoid race conditions with web3 injection timing.
window.addEventListener('load', function() {
var results
var web3 = window.web3

// Checking if Web3 has been injected by the browser (Mist/MetaMask)
if (typeof web3 !== 'undefined') {
// Use Mist/MetaMask's provider.
web3 = new Web3(web3.currentProvider)

results = {
web3: web3
}

console.log('Injected web3 detected.');

resolve(results)
} else {
// Fallback to localhost if no web3 injection.
var provider = new Web3.providers.HttpProvider('http://localhost:8545')

web3 = new Web3(provider)

results = {
web3: web3
}

console.log('No web3 instance injected, using Local web3.');

resolve(results)
}
})
})

export default getWeb3
```
这个文件主要是封装了一个`getWeb3`的`promiss`供我们直接使用，可以从`getWeb3`直接获取到`web3`对象供`App.js`文件中使用。
（后期版本不同，可能导致使用方式不同）

##修改app.js前端代码和合约进

```
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

var _modifyVotingCount = (candidates,i,votingCount) => {

console.log("---------");
console.log(candidates);
console.log(i);
console.log(votingCount);

let obj = candidates[i];
obj.votingCount = votingCount;
return candidates;
}

class App extends Component {
state = { storageValue: 0, web3: null, accounts: null, contract: null };

constructor(props) {
super(props)
// ["1","2","3","4","5"]
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

for (var i = 0; i < this.state.candidates.length; i++) {
console.log(this.state.candidates[i]);//合约实例对象
votingContractInstance.totalVotesFor(this.state.candidates[i].id,{from:accounts[0]})
.then((result) =>{
console.log(result);
})
}
return;
})
})
}





//   componentDidMount = async () => {
//     try {
//       // Get network provider and web3 instance.
//       //获取网络提供商和web3实例。
//       const web3 = await getWeb3();
//       this.setState({
//           web3: web3
//       })
//       // Use web3 to get the user's accounts.
//       //使用web3获取用户的帐户。
//       const accounts = await web3.eth.getAccounts();
//
//       // Get the contract instance.
//       //获取合同实例。
//       const Contract = truffleContract(VotingContract);
//       Contract.setProvider(web3.currentProvider);
//       const instance = await Contract.deployed();
//
//       // Set web3, accounts, and contract to the state, and then proceed with an
//       // example of interacting with the contract's methods.
//       // 将web3，帐户和合同设置为州，然后继续
//       //与合同方法交互的例子。
//       this.setState({
//         web3,
//         accounts,
//         contract: instance
//       }, this.runExample);
//       this.runExample();
//       console.log(this.state);
//     } catch (error) {
//       // Catch any errors for any of the above operations.
//       alert(
//         `Failed to load web3, accounts, or contract. Check console for details.`
//       );
//       console.log(error);
//     }
//   };
// runExample = async () => {
//   const { accounts, contract } = this.state;
//
//   //存储给定值，默认为5。
//   await contract.set(5, { from: accounts[0] });
//
//   // Get the value from the contract to prove it worked.
//   //从合同中获取价值以证明其有效。
//   const response = await contract.get();
//
//   // Update state with the result.
//   //使用结果更新状态。
//   this.setState({ storageValue: response.toNumber() });
// };

render() {
return (
<div className="App">
<ul>
{
this.state.candidates.map((person) =>{
return (
<li key={person.id}>候选人：{person.name} 获得{person.votingCount}票</li>
)
})
}
</ul>
</div>
);
}


}

export default App;

```

使用命令`cd client && npm run start`

```
macdeiMac:client mac$ npm run start

> client@0.1.0 start /Users/mac/Desktop/GitHub/Solidity/learn/Voting/client
> react-scripts start
> 
```


全部代码

```
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

```


[gitHub参考链接](https://github.com/Goddreamwt/Solidity/tree/master/learn/Voting)
