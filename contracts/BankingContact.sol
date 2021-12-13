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

    mapping(uint256 => Candidate) public candidateDetails;

    //We want it so only addmins can add candidates to the system.
    function addCandidate(
        string _name,
        string _party,
        string _bio,
        uint256 _constitency,
        uint256 _constituency
    ) public OnlyAdmin {
        
        //This creates the new Candidate with the params passed in. 
        Candidate memory newCandidate = Candidate({  
            voteCount: 0,
            constituency: _constituency,
            candidateId: candidateCount
            name: _name,
            party: _party,
            bio: _bio,
        });
        //Maps the candidate number to the new candidate. 
        candidateDetails[candidateCount] = newCandidate;
        candidateCount += 1;
    }


    //Voter struct
    struct Voter{ 
        address voterAddress; 
        string name; 
        string licenseID; 
        uint constituency; 
        bool hasVoted; 
        bool isVerified; 
    }

    address[] public voters; 
    mapping (address => Voter) public voterDetails; 

    //request to be addeds as a voterAddress
    function requestVoter(string _name, string _aadhar, uint _constituency) public {
        Voter memory newVoter = Voter({
        voterAddress : msg.sender,
        name : _name,
        aadhar : _aadhar,
        constituency : _constituency,
        hasVoted : false,
        isVerified : false
    });
    
    voterDetails[msg.sender] = newVoter;
    voters.push(msg.sender);
    voterCount += 1;
    }

// get total number of voters
function getVoterCount() public view returns (uint) {
   return voterCount;
}



}
