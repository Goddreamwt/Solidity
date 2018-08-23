pragma solidity ^0.4.4;

/*
public >internal(这是合约属性默认的访问权限) >private
 */
contract Person {
  uint internal _age;
  uint _weight;
  uint private _height;
  uint public _money;

  function _money() constant public returns (uint) {
    return 120;
  }

}
