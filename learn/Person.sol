pragma solidity ^0.4.4;
/*
 pragma:版本声明
 solidity:开发语言
 0.0.1:当前合约的版本，0.0代表主版本，.1代表修复BUG的升级版
 ^:向上兼容 0.0.1 ~0.0.9可以对我们当前的代码进行编译
*/

contract Person {
  uint _height; //身高
  uint _age; //年龄
  address _owner; //代表合约的拥有者


  //方法名和合约名相同时就属于构造函数，在创建对象时，构造函数会自动最先被调用
  function Person() public{
    _height = 180;
    _age = 29;
    _owner = msg.sender;
  }

  function owner() constant  public returns (address) {
    return (_owner);
  }
  // set方法，修改height属性
  function setHeight(uint height) public{
    _height = height;
  }

  //读取_height constant代表方法只读
  function height() constant public returns (uint) {
    return _height;
  }

  function setAge(uint age)public {
    _age = age;
  }

  function age() constant public returns (uint) {
    return _age;
  }

  function kill() constant public{
    if (_owner == msg.sender){
      //析构函数
        selfdestruct(_owner);
    }
  }

}
