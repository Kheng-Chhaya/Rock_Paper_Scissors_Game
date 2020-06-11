const RPS = artifacts.require("RPS.sol");

contract("RPS",(accounts)=>{

it("test the register function",()=>{
	var instance;
	return RPS.deployed().then((ins)=>{
		instance = ins;
		return instance.registerPlayTheGame({from:accounts[0]});
	}).then((tx)=>{
		return instance.returnPlayer1({from:accounts[0]})
	}).then((returnPlayer1)=>{
		assert.equal(returnPlayer1,true,"the first player is revert");
		return instance.registerPlayTheGame({from:accounts[1]})
	}).then((tx)=>{
		return instance.returnPlayer2({from:accounts[1]})
	}).then(async(boo)=>{
		assert.equal(boo,true,"player2 is revert");
		return instance.playTheGame("paper",{from:accounts[0]})
	}).then((tx)=>{
	    return instance.playTheGame("rock",{from:accounts[1]})
	}).then((result,err)=>{
		if(!err)
		{
			console.log(result.logs[0].args._winner);
			// console.log(result);
		}
	  return instance.playTheGame("paper",{from:accounts[0]})
	}).then((play)=>{
		return instance.playTheGame("paper",{from:accounts[1]})
	}).then((res)=>{
		console.log(res.logs[0].args._equal);
	})
})







})