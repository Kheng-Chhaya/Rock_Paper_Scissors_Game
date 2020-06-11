pragma solidity 0.6.7;

contract RPS
{
	mapping(string=>mapping(string=>int)) symbols;
	address payable public player1;
	address payable public player2;
	string public player1Choice;
	string public player2Choice;

	modifier notRegisteredYet() 
	{
		if(msg.sender == player1 || msg.sender == player2)
		{
			revert("Need the different player address");
		}
		else
		{
			_;
		}
	}

	event Won(address indexed _winner);

	event Equal(string _equal);

	constructor() public 
	{
		symbols["rock"]["rock"] = 0;
		symbols["rock"]["paper"] = 2;
		symbols["rock"]["scissors"] = 1;
		symbols["paper"]["rock"] = 1;
		symbols["paper"]["paper"] = 0;
		symbols["paper"]["scissors"] = 2;
		symbols["scissors"]["rock"] = 2;
		symbols["scissors"]["paper"] = 1;
		symbols["scissors"]["scissors"] = 0;
	}

	function getWinner() public view returns(int)
	{
		return symbols[player1Choice][player2Choice];
	}

	function playTheGame(string memory _choice) public returns(int _num)
	{
		if(msg.sender== player1)
		{
			player1Choice = _choice;
		}
		else if(msg.sender == player2)
		{
			player2Choice = _choice;
		}
		if(bytes(player1Choice).length != 0 && bytes(player2Choice).length != 0)
		{
			int winner = symbols[player1Choice][player2Choice];
			if(winner == 1)
			{
				
				emit Won(player1);
			}
			else if(winner == 2)
			{
			
				emit Won(player2);
			}
			else
			{
               emit Equal("Equal");
			}

			player2Choice = "";
		    player1Choice = "";
		  


		}
		else
		{
			_num = -1;
		}


	}

	function registerPlayTheGame() public notRegisteredYet()
	{
		
		if(player1 == address(0))
		{
			player1 = msg.sender;
		}
		else if(player2 == address(0))
		{
			player2 = msg.sender;
		}
	}

	function returnPlayer1() public view returns(bool _b)
	{
		return msg.sender == player1;
	}

	function returnPlayer2() public view returns(bool _b)
	{
		return msg.sender == player2;
	}

}