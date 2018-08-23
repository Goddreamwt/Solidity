pragma solidity ^0.4.4;

contract Person {

  function age() constant public returns (uint) {
    return 55;
  }

  function weight() constant public returns (uint) {
    return 180;
  }

  function height() constant public returns (uint) {
    return 172;
  }

  function money() constant public returns (uint) {
    return 32000;
  }
}
