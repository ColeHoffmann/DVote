pragma solidity ^0.4.17;

contract BankingContract {
    //addess of the owner
    address public owner;

    //counts of the candidates and voters
    uint256 candidateCount = 0;
    uint256 voterCount = 0;

    //election starte or ended.
    bool start = false;
    bool end = false;

    //return the address of the owner.
    function getOwner() public view returns (address) {
        return owner;
    }

    modifier adminOnly() {
        require(msg.sender == owner);
        _;
    }

    //Struct for a candidate;
    struct Candidate {
        //All the things a Candidate would have. Name, party affiliation, bio, voteCount, constituency, candidateID
        string name;
        string party;
        string bio;
        uint256 voteCount;
        uint256 constituency;
        uint256 candidateID;
    }
}
