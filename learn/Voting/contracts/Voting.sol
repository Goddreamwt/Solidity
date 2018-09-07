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
