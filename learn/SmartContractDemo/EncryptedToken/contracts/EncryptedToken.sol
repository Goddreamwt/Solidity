pragma solidity ^0.4.22;//代表solidity的版本

//contract相当于其他语言中的class，EncryptedToken相当于类的名字。
//contract EncryptedToken可以理解为class EncryptedToken extends Contract。
contract EncryptedToken {

  //声明了一个变量INITIAL_SUPPLY，初始化存储了一个666666的整数作为部署当前合约的钱包地址的代币数。
  uint256 INITIAL_SUPPLY = 666666;
  //balances是一个key类型为address，value类型为uint256的键值对(mapping)，相当于Java中的map、iOS中的NSDictionary。
  mapping(address => uint256) balances;

  //EncryptedToken合约的构造函数(contructor)，当EncryptedToken合约调用时，会先执行它的构造函数
  constructor() public{
    //以当前部署合约的钱包地址为key，以INITIAL_SUPPLY为value初始化一个键值对。
     balances[msg.sender] = INITIAL_SUPPLY;
  }

  // 转账到一个指定的地址
  /*
    param:address _to  转账的目的地地址
    param:uint256 _amount 转账金额
  */
  function transfer(address _to, uint256 _amount) public{
    //声明断言，当条件满足，即当前钱包余额小于要转账的额度时，就会抛出异常。
    assert(balances[msg.sender] > _amount);
    //从当前钱包额度中减去_amount
    balances[msg.sender] -= _amount;
    //将目标地址的额度增加_amount
    balances[_to] += _amount;
  }
  // 查看指定地址的余额
  /*
   param:address _owner 指定的钱包地址
   constant 关键字的作用 调用balanceOf函数时，它会自动调用call()方法
   表明只是读书数据，而不需要往区块链写入数据，调用这个方法，不需要花费手续费
  */
  function balanceOf(address _owner) public constant returns (uint256) {
    return balances[_owner];
  }
}
