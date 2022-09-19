// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

abstract contract StakingStorage {
    /*
    *@dev Amount staked per account
    */
    mapping(address => uint256) private _stakers;

    uint256 public totalVolume;

    /*
    * @dev : rewards handed out to stakers
    */
    mapping(address => uint256) private _rewards;

    struct Staker {
        address account;
        uint256 startDate;
        uint256 snapshot; // blockstamp at point of stake
    }

    /*
    * rewards interval, period when money released
    */

}

abstract contract Interest {

    /*
    * Interest cumulative , principle input. 
    */

    uint256 private rate;

    enum RateType {
        _fixed,
        _variable
    }

    // function setInterestRate 


    

}



interface GlobiumStakingPool {

    /*
    * @dev : pays yield into msg sender account if acceptable
    */
    function getYield() external view returns (bool);

    /*
    * @dev : view staked balance includiing yield of sender
    */

    function viewStakeBalance() external returns (uint256 );


    /*
    * @dev : if outside the vesting period. withdraw from the staking pool.
    */
    function withdrawStake() external returns (bool);

    /*
    * @dev : total staked balance in the staking pool.
    */
    function totalStaked() external view returns (uint256 );


    /*
    * @dev : total staked in the staking pool.
    */
    function stakedAccounts() external view returns (address[] memory);


    /*
    * @dev : staking pool vesting period. x % per unit of time. i.e 
    */
    function getVestingPeriod() external view returns (uint256);

    /*
    * @dev : contribue to the staking pool, checks dates,
    */
    function stakePool() external ;


    /*
    * @dev : get staking end date. 
    */


    function getYieldPeriods() external view returns (uint256);


}


contract StakingPool is StakingStorage {

    IERC20 public immutable stakeToken;
    IERC20 public immutable rewardToken;

    uint256 public immutable startDate;
    uint256 public immutable endDate; //Potential change to staking pool length 

    uint8 public immutable rewardIntervals;

    address private _treasurer;
    address private _executive;


    constructor(IERC20 _stakeToken, IERC20 _rewardToken, uint256 _startDate, uint256 _endDate, uint8 _rewardIntervals) payable {
        stakeToken = _stakeToken;
        rewardToken = _rewardToken;
        startDate = _startDate;
        endDate = _endDate;
        rewardIntervals = _rewardIntervals;
    }

    receive() external payable {
        console.log("receive message value", msg.value);
    }

    fallback() external payable {
        console.log("fallback message value", msg.value);
    }

    // stake amount greater than pool max
    // is there a max an individual can stake 
    function stake(uint256 amount) public payable returns(uint256) {
        require(msg.value > 0, "no ether passed");
        console.log("stake", amount);
        
        // require(msg.value > 0, "staking greater than 0");
        (bool success, ) = address(this).call{value : msg.value}("");
        console.log("call data stake success", success);
        return amount;
    }

    function stakeTokens(uint256 amount) public {
        require(stakeToken.balanceOf(msg.sender) >= amount, "Insufficient tokens to transfer");
        //require( ,"test for staked account not maxed out.")

    
        _stakers[msg.sender] += amount;
        stakeToken.transferFrom(msg.sender, address(this), amount);

        stakeToken
    }

    function totalStaked() public view returns(uint256) {
        return address(this).balance;
    }


}