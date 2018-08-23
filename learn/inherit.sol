pragma solidity ^0.4.4;

/*
public >internal(这是合约属性默认的访问权限) >private
 */
contract Animal {
  uint _weight;
  uint private _height;
  uint internal _age;
  uint public _money;

 //public
  function test() constant public returns (uint) {
    return _weight;
  }

  function test1() constant public returns (uint) {
    return _height;
  }

  function test2() constant internal returns (uint) {
    return _age;
  }

  function test3() constant private returns (uint) {
    return _money;
  }

}

contract Animal1 {

  uint _sex;//1 男  0 女

  function Animal1() public {
    _sex = 1;
  }

  function sex() constant public returns (uint) {
    return _sex;
  }
}

contract Dog is Animal,Animal1{

  function testWeigh() constant public returns (uint) {
    return _weight;
  }

  /* function testHeight() constant public returns (uint) {
    return _height;
  } */

  function testAge() constant public returns (uint) {
    return _age;
  }

  function testMoney() constant public returns (uint) {
    return _money;
  }

  function sex() constant returns (uint) {
    return 0;
  }
}
