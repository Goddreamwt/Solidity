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

  function testInternal() constant public returns (uint) {
    return this.test();
  }

  function testInternal1() constant public returns (uint) {
    return test2();
  }

/* 报错 如果使用函数指针进行访问，仅仅可以使用public修饰的 */
  /* function testInternal2() constant public returns (uint) {
    return this.test2();
  } */
}
