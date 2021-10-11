//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract EnetPulseConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;
  
    // Schedule
    bytes public schedule;
    string public scheduleAsString;
    // Game Details
    bytes public gameDetails;
    string public gameDetailsAsString;
    // Game Score
    bytes public gameScore;
    string public gameScoreAsString;

    mapping(bytes32 => bytes) public requestIdData;
    mapping(bytes32 => string) public requestIdDataAsString;

    constructor () {
        address _link;
        address _oracle;
        _link = 0xa36085F69e2889c224210F603D836748e7dC0088;
        _oracle = 0xfF07C97631Ff3bAb5e5e5660Cdf47AdEd8D4d4Fd;
        setChainlinkToken(_link);
        setChainlinkOracle(_oracle);
    }

    function requestSchedule(
        uint256 _leagueId
    )
        public
    {
        bytes32 specId= "96a126cb110e41e1ada54b596b3afcb9";
        uint256 payment =  0.1 * 10 ** 18; // 0.1 LINK
        Chainlink.Request memory req = buildChainlinkRequest(specId, address(this), this.fulfillSchedule.selector);
      
        req.add("endpoint", "schedule");
        req.addUint("leagueId", _leagueId);
        
        requestOracleData(req, payment);
    }
    
    function requestSchedule(
        uint256 _leagueId,
        string memory _date
    )
        public
    {
        bytes32 specId= "96a126cb110e41e1ada54b596b3afcb9";
        uint256 payment =  0.1 * 10 ** 18; // 0.1 LINK
        Chainlink.Request memory req = buildChainlinkRequest(specId, address(this), this.fulfillSchedule.selector);
      
        req.add("endpoint", "schedule");
        req.addUint("leagueId", _leagueId);
        req.add("date", _date);
        
        requestOracleData(req, payment);
    }

    function requestGameDetails(
        uint256 _gameId
    )
        public
    {
        bytes32 specId= "63626b3c8de7424881dfaf42512bf223";
        uint256 payment =  0.1 * 10 ** 18; // 0.1 LINK
        Chainlink.Request memory req = buildChainlinkRequest(specId, address(this), this.fulfillGameDetails.selector);
      
        req.add("endpoint", "game-details");
        req.addUint("gameId", _gameId);
        
        requestOracleData(req, payment);
    }

    function requestGameScore(
        uint256 _gameId
    )
        public
    {
        bytes32 specId= "c89ee5e0590a4f4c8017bae5f9724fcf";
        uint256 payment =  0.1 * 10 ** 18; // 0.1 LINK
        Chainlink.Request memory req = buildChainlinkRequest(specId, address(this), this.fulfillGameScore.selector);
      
        req.add("endpoint", "game-score");
        req.addUint("gameId", _gameId);
        
        requestOracleData(req, payment);
    }

    function fulfillSchedule(bytes32 _requestId, bytes memory _schedule) public recordChainlinkFulfillment(_requestId)
    {
        schedule = _schedule;
        scheduleAsString = string(_schedule);
        
        requestIdData[_requestId] = schedule;
        requestIdDataAsString[_requestId] = scheduleAsString;
    }

    function fulfillGameDetails(bytes32 _requestId, bytes memory _gameDetails) public recordChainlinkFulfillment(_requestId)
    {
        gameDetails = _gameDetails;
        gameDetailsAsString = string(_gameDetails);
        
        requestIdData[_requestId] = gameDetails;
        requestIdDataAsString[_requestId] = gameDetailsAsString;
    }

    function fulfillGameScore(bytes32 _requestId, bytes memory _gameScore) public recordChainlinkFulfillment(_requestId)
    {
        gameScore = _gameScore;
        gameScoreAsString = string(_gameScore);

        requestIdData[_requestId] = gameScore;
        requestIdDataAsString[_requestId] = gameScoreAsString;
    }

    function withdrawLink() public {
        LinkTokenInterface linkToken = LinkTokenInterface(chainlinkTokenAddress());
        require(linkToken.transfer(msg.sender, linkToken.balanceOf(address(this))), "Unable to transfer");
    }

}
