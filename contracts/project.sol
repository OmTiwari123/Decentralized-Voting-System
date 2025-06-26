// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DecentralizedVotingSystem {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public admin;
    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;
    bool public votingActive;

    event Voted(address voter, uint candidateId);
    event VotingStarted();
    event VotingEnded();

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier votingOpen() {
        require(votingActive, "Voting is not active");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // 1. Add a candidate (only admin)
    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // 2. Start voting (only admin)
    function startVoting() public onlyAdmin {
        votingActive = true;
        emit VotingStarted();
    }

    // 3. End voting (only admin)
    function endVoting() public onlyAdmin {
        votingActive = false;
        emit VotingEnded();
    }

    // 4. Vote for a candidate
    function vote(uint _candidateId) public votingOpen {
        require(!voters[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }
}
