// Right click on the script name and hit "Run" to execute
const { expect} = require("chai");
const { ethers } = require("hardhat");

describe("Staking", function () {

  let globiumDeployer, stakingDeployer, interestDeployer, globium, globiumAddress;
  

  // let globium;

  beforeEach(async function() {
    [globiumDeployer, stakingDeployer, interestDeployer] = await ethers.getSigners();


    const Globium = await ethers.getContractFactory("GlobiumToken");
    const globium = await Globium.connect(globiumDeployer).deploy(1000, "Globium", "GBM");
    await globium.deployed();

    globiumAddress = globium.address;
    console.log("Globium address",globium.address);

  })

  describe("Staking contract", function(){

    it("deploy the staking contract with GlobiumToken as base", async function () {

    const startDate = Math.floor(((new Date().getTime())/1000));
    const endDate = Math.floor(((new Date().getTime())/1000)+(60*5));

  

    const StakingPool = await ethers.getContractFactory("StakingPool");
    const stakingPool = await StakingPool.connect(stakingDeployer).deploy(globiumAddress, globiumAddress, startDate, endDate, 1);
    await stakingPool.deployed();
    console.log("staked", stakingPool.address);

    const stakeEth = ethers.utils.parseEther('0.5');
    const stake = await stakingPool.stake(stakeEth, {value : stakeEth });
    const stakedValue = await stake.wait();




    expect(stakingPool.address).to.not.equal("");
  });

    it("add ether to the staking pool", async function(){
      
    })




  })

  

  // it("should add the interest rate module to Staking Pool", async function() {

  // })

});