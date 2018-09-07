pragma solidity ^0.4.23;
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract BloggerCoin is StandardToken {
  string public name = "BloggerCoin";
  string public symbol = "BLC";
  uint8 public decimals = 4;
  uint256 public INITIAL_SUPPLY = 666666;

  constructor() public {
    /* totalSupply = INITIAL_SUPPLY; */
    balances[msg.sender] = INITIAL_SUPPLY;
  }

}
