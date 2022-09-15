// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

error NotAuthorized();
error NotAuthorizedToVote(address invalidPerson);
error ProposalNotFound();

contract Voting {
    event MemberAdded(address member);
    event ProposalAdded(uint256 proposalIndex);
    event VoteUsed(address indexed voter, uint256 indexed proposalIndex);
    event WinnerDeclared(uint256 indexed proposalIndex);

    address private immutable s_chairPerson;

    struct VoteRight {
        bool isAdded;
        uint256 voteWeight;
        bool isVoted;
    }
    mapping(address => VoteRight) private s_voters;

    struct Proposal {
        bool isAdded;
        uint256 proposalIndex;
        uint256 voteCount;
    }

    Proposal[] private proposals;

    constructor() {
        s_chairPerson = msg.sender;
        s_voters[msg.sender] = VoteRight(true, 2, false);
    }

    function addMember(address candidateMember) public {
        if (msg.sender != s_chairPerson) {
            revert NotAuthorized();
        }
        VoteRight memory temp = VoteRight(true, 1, false);
        s_voters[candidateMember] = temp;
        emit MemberAdded(candidateMember);
    }

    function addProposal() public {
        if (msg.sender != s_chairPerson) {
            revert NotAuthorized();
        }
        proposals.push(Proposal(true, proposals.length, 0));
        emit ProposalAdded(proposals.length - 1);
    }

    function vote(uint256 proposalIndex) public {
        if ((!s_voters[msg.sender].isAdded) || (s_voters[msg.sender].isVoted)) {
            revert NotAuthorizedToVote(msg.sender);
        }
        if (!proposals[proposalIndex].isAdded) {
            revert ProposalNotFound();
        }

        proposals[proposalIndex].voteCount++;
        s_voters[msg.sender].isVoted = true;
        emit VoteUsed(msg.sender, proposalIndex);
    }

    function declareWinner() public returns (uint256) {
        if (msg.sender != s_chairPerson) {
            revert NotAuthorized();
        }

        uint256 winnerIndex = 0;
        uint256 mostVote = 0;
        uint256 currentVoteCount;

        for (uint i = 0; i < proposals.length; i++) {
            currentVoteCount = proposals[i].voteCount;
            if (currentVoteCount > mostVote) {
                winnerIndex = i;
                mostVote = currentVoteCount;
            }
        }
        emit WinnerDeclared(winnerIndex);
        delete proposals;
        return proposals[winnerIndex].proposalIndex;
    }

    function getChairPerson() public view returns (address) {
        return s_chairPerson;
    }

    function getVoteRight(address member)
        public
        view
        returns (VoteRight memory)
    {
        return s_voters[member];
    }

    function getProposal(uint256 index) public view returns (Proposal memory) {
        return proposals[index];
    }
}
