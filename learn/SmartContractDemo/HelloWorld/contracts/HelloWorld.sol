pragma solidity ^0.4.22;

contract HelloWorld {
  constructor() public{

  }

  function echo(string name) public pure returns (string) {
    return name;
  }

  function sayHello() public pure returns (string) {
    return ("Hello World");
  }
}
