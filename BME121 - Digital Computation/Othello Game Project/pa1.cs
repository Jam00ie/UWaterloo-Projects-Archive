#nullable enable
using System;
using static System.Console;

namespace Bme121
{
    class Player
    {
        public readonly string Colour;
        public readonly string Symbol;
        public readonly string Name;
        
        //Constructor
        public Player( string Colour, string Symbol, string Name )
        {
            this.Colour = Colour;
            this.Symbol = Symbol;
            this.Name = Name;
        }
        
        //Getters
        public string GetColour()
        {
			return Colour;
		}
		public string GetSymbol()
		{
			return Symbol;
		}
		public string GetName()
		{
			return Name;
		}
    }
    
    static partial class Program
    {
        //Array that holds the game data
        static string[ , ] mainGame;
        
        // Display common text for the top of the screen.
        static void Welcome( )
        {
			WriteLine();
			WriteLine("Welcome to Othello!");
			WriteLine();
        }
        
        // Collect a player name or default to form the player record.
        static Player NewPlayer( string colour, string symbol, string name )
        {
            string Colour = colour;
            string Symbol = symbol;
            string Name = name;
            
            return new Player(Colour, Symbol, Name);
        }
       
        // Determine which player goes first or default.
        static int GetFirstTurn( Player[ ] players, int defaultFirst )
        {
            int firstPlayer = defaultFirst;
            for (int i = 0; i < players.Length; i++)
            {
				if((players[i].GetColour()) == "white")
				{
					firstPlayer = i;
				}
			}
            return firstPlayer;
        }
       
        // Get a board size (between 4 and 26 and even) or default, for one direction.
        static int GetBoardSize( string direction, int defaultSize )
        {
            int boardSize = defaultSize;
			bool validSize = false;
			while (!validSize)
			{
				if (direction == "rows")
				{
					Write("Please enter row size for the board between 4 and 26 (must be an even number): ");
				}
				else if (direction == "columns")
				{
					Write("Please enter column size for the board between 4 and 26 (must be an even number): ");
				}
				bool validity = int.TryParse(ReadLine(), out boardSize);
				
				if (!validity)
				{
					WriteLine("Invalid input. Please try again.");
				}
				else
				{
					if (boardSize%2==0 && boardSize >= 4 && boardSize <= 26)
					{
						validSize = true;
					}
					else
					{
						WriteLine("Invalid size. Please try again.");
					}
				}
			}
			return boardSize;
        }
       
        // Get a move from a player.
        
        static string GetMove( Player player )
        {
            WriteLine("Player {0} ({1})'s turn!", player.GetName(), player.GetColour());
			WriteLine("Enter a coordinate, skip turn, or quit game.");
			string move = "";
            bool validInput = false;
            while (!validInput)
            {
				Write("Move: ");
				move = ReadLine();
				if (move.Length != 2 && move!="quit" && move!="skip")
				{
					WriteLine("Invalid input. Please try again.");
				}
				else
				{
					validInput = true;
				}
			}
			return move;
        }
        
        // Try to make a move. Return true if it worked.
		static bool TryMove(Player player, string move )
        {
            char[] cMove = move.ToCharArray();
            string colStr = Char.ToString(cMove[0]);
            string rowStr = Char.ToString(cMove[1]);
            
            int colInt = IndexAtLetter(colStr);
            int rowInt = IndexAtLetter(rowStr);
            
            if (mainGame[rowInt, colInt] != " ")
            {
				return false;
			}
			else
			{
				if (CheckNear(colInt, rowInt, player))
				{
					mainGame[rowInt,colInt] = player.GetSymbol();
					return true;
				}
				else
				{
					return false;
				}
			}
        }
        
        // Check near move to see if valid.
        static bool CheckNear(int col, int row, Player player)
        {
			int cBoard = mainGame.GetLength(1);
			int rBoard = mainGame.GetLength(0);
			string playerSymbol = player.GetSymbol();
			bool checkFar = false;
			bool farTrue = false;
			
			for (int i = 0; i < 3; i++)
			{
				for (int j = 0; j < 3; j++)
				{
					//If not self
					if (i==1 && j==1)
					{
						
					}
					else
					{
						int r = row-1+i;
						int c = col-1+j;
						//Checking if (r,c) exists on board
						if (c >= 0 && c < cBoard && r >= 0 && r < rBoard)
						{
							string near = mainGame[r,c];
							//Checking if (r,c) is not empty
							if ( near != " " )
							{
								//Checking if (r,c) is enemy
								if ( near != playerSymbol )
								{
									string direction = FlipDirection(i,j);
									//Checking if direction leads to another disc of the same colour
									checkFar = CheckFar(direction, row, col, rBoard, cBoard, playerSymbol);
								}
							}
						}
					}
					//Did flipping work on any directions from player move?
					if (checkFar)
					{
						farTrue = true;
					}
				}
			}
			
			if (farTrue)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		static string FlipDirection(int row, int col)
		{
			if (row == 0)
			{
				if (col == 0)      return "NW";
				else if (col == 1) return "NN";
				else               return "NE";
			}
			else if (row == 1)
			{
				if (col == 0)      return "WW";
				else               return "EE";
			}
			else
			{
				if (col == 0)      return "SW";
				else if (col == 1) return "SS";
				else               return "SE";
			}
		}
		
		//Checking if direction leads to another disc of the same colour
		static bool CheckFar(string direction, int row, int col, int rBoard, int cBoard, string playerSymbol)
		{
			//Storing space between player move and edge of board
			int spaceN = col + 1;
			int spaceE = row + 1;
			int spaceW = rBoard - row;
			int spaceS = cBoard - col;
			
			bool flipAllowed = false;
			string[,] flipList = CopyToFlip();
			
			//Check NW direction
			if (direction == "NW")
			{
				if (spaceN > 2 && spaceW > 2)
				{
					for (int i = 1; (i < spaceN && i < spaceW); i++)
					{
						int r = row - i;
						int c = col - i;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && i > 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check NN direction
			if (direction == "NN")
			{
				if (spaceN > 2)
				{
					for (int i = 1; i < spaceN; i++)
					{
						int r = row - i;
						int c = col;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && r != 1 && c != 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check NE direction
			if (direction == "NE")
			{
				if (spaceN > 2 && spaceE > 2)
				{
					for (int i = 1; (i < spaceN && i < spaceE); i++)
					{
						int r = row - i;
						int c = col + i;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && i > 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check WW direction
			if (direction == "WW")
			{
				if (spaceW > 2)
				{
					for (int j = 1; j < spaceW; j++)
					{
						int r = row;
						int c = col - j;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && r != 1 && c != 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check EE direction
			if (direction == "EE")
			{
				if (spaceE > 2)
				{
					for (int j = 1; j < spaceE; j++)
					{
						int r = row;
						int c = col + j;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && r != 1 && c != 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check SW direction
			if (direction == "SW")
			{
				if (spaceS > 2 && spaceW > 2)
				{
					for (int i = 1; (i < spaceS && i < spaceW); i++)
					{
						int r = row + i;
						int c = col - i;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && i > 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check SS direction
			if (direction == "SS")
			{
				if (spaceS > 2)
				{
					for (int i = 1; i < spaceS; i++)
					{
						int r = row + i;
						int c = col;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && r != 1 && c != 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			//Check SE direction
			if (direction == "SE")
			{
				if (spaceS > 2 && spaceE > 2)
				{
					for (int i = 1; (i < spaceS && i < spaceE); i++)
					{
						int r = row + i;
						int c = col + i;
						string checking = mainGame[r,c];
						if (checking != playerSymbol && checking != " ")
						{
							flipList[r,c] = playerSymbol;
						}
						else if (checking == playerSymbol && i > 1)
						{
							flipAllowed = true;
							break;
						}
						else
						{
							break;
						}
					}
				}
			}
			
			if (flipAllowed)
			{
				CopyToMain(flipList);
				return true;
			}
			else
			{
				return false;
			}
		}
		
		//Copies flipList onto mainGame
		static void CopyToMain(string[,]flipList)
		{
			int cBoard = mainGame.GetLength(1);
			int rBoard = mainGame.GetLength(0);
			
			for (int i = 0; i < rBoard; i++)
			{
				for (int j = 0; j < cBoard; j++)
				{
					mainGame[i,j] = flipList[i,j];
				}
			}
		}
		
		//Copies mainGame to flipList
		static string[,] CopyToFlip()
		{
			int cBoard = mainGame.GetLength(1);
			int rBoard = mainGame.GetLength(0);
			string[,]flipList = new string[cBoard,rBoard];
			
			for (int i = 0; i < rBoard; i++)
			{
				for (int j = 0; j < cBoard; j++)
				{
					flipList[i,j] = mainGame[i,j];
				}
			}
			return flipList;
		}
		
		//Checks if game is over
		static bool CheckOver()
		{
			int cBoard = mainGame.GetLength(1);
			int rBoard = mainGame.GetLength(0);
			
			bool full = false;
			
			for (int i = 0; i < rBoard; i++)
			{
				for (int j = 0; j < cBoard; j++)
				{
					if (mainGame[i,j] == " ")
					{
						return false;
					}
					else
					{
						full = true;
					}
				}
			}
			return full;
		}
        
        // Count the discs to find the score for a player.
        static int GetScore(Player player)
        {
            string playerSymbol = player.GetSymbol();
            
            int cBoard = mainGame.GetLength(1);
			int rBoard = mainGame.GetLength(0);
			
			int score = 0;
			for (int i = 0; i < rBoard; i++)
			{
				for (int j = 0; j < cBoard; j++)
				{
					if (mainGame[i,j] == playerSymbol)
					{
						score++;
					}
				}
			}
            
            return score;
        }
        
        // Display a line of scores for all players.
        static void DisplayScores(Player[ ] players)
        {
			WriteLine();
			WriteLine("-Scores-");
			Write("Player {0} ({1})'s score: ", players[0].GetName(), players[0].GetColour());
			WriteLine(GetScore(players[0]));
			Write("Player {0} ({1})'s score: ", players[1].GetName(), players[1].GetColour());
			WriteLine(GetScore(players[1]));
			WriteLine();
        }
        
        // Display winner(s) and categorize their win over the defeated player(s).
        static void DisplayWinners(Player[ ] players )
        {
			int whiteFinal = GetScore(players[0]);
			int blackFinal = GetScore(players[1]);
			
			WriteLine();
			WriteLine("Game Over!");
			WriteLine();
			if (whiteFinal > blackFinal)
			{
				WriteLine("White Wins!");
				WriteLine("Win: Player {0} ({1})", players[0].GetName(), players[0].GetColour());
				WriteLine("Score: {0}", whiteFinal);
				WriteLine("Lose: Player {0} ({1})", players[1].GetName(), players[1].GetColour());
				WriteLine("Score: {0}", blackFinal);
			}
			else if (whiteFinal < blackFinal)
			{
				WriteLine("Black Wins!");
				WriteLine("Win: Player {0} ({1})", players[1].GetName(), players[1].GetColour());
				WriteLine("Score: {0}", blackFinal);
				WriteLine("Lose: Player {0} ({1})", players[0].GetName(), players[0].GetColour());
				WriteLine("Score: {0}", whiteFinal);
			}
			else
			{
				WriteLine("It's a tie!");
				WriteLine("White Wins!");
				WriteLine("Tie: Player {0} ({1})", players[0].GetName(), players[0].GetColour());
				WriteLine("Score: {0}", whiteFinal);
				WriteLine("Tie: Player {0} ({1})", players[1].GetName(), players[1].GetColour());
				WriteLine("Score: {0}", blackFinal);
			}
        }
      
        static void Main( )
        {
            Welcome( );
            
            //Collect player name for each colour
			Write("Please enter player 1 (white)'s name: ");
			string whitePlayer = ReadLine();
			Write("Please enter player 2 (black)'s name: ");
			string blackPlayer = ReadLine();
			
            Player[ ] players = new Player[ ] 
            {
                NewPlayer( colour: "white", symbol: "O", name: whitePlayer ),
                NewPlayer( colour: "black", symbol: "X", name: blackPlayer ),
            };
            
            int turn = GetFirstTurn( players, defaultFirst: 0 );
           
            int rows = GetBoardSize( direction: "rows",    defaultSize: 8 );
            int cols = GetBoardSize( direction: "columns", defaultSize: 8 );
           
            mainGame = NewBoard( rows, cols );
           
            // Play the game.
            
            WriteLine();
            WriteLine("Game start!");
            WriteLine();
            DisplayBoard( mainGame );
            
            bool gameOver = false;
            while( ! gameOver )
            {
                bool tryAgain = true;
                while (tryAgain)
                {
					string move = GetMove( players[ turn ] );
					if( move == "quit" )
					{
						gameOver = true;
						tryAgain = false;
					}
					else
					{
						if ( move == "skip")
						{
							turn = ( turn + 1 ) % players.Length;
							tryAgain = false;
						}
						else
						{
							bool madeMove = TryMove( players[ turn ], move );
							if( madeMove )
							{
								turn = ( turn + 1 ) % players.Length;
								tryAgain = false;
							}
							else 
							{
								WriteLine( "Your choice didn't work!" );
								Write( "Press <Enter> to try again." );
								ReadLine( ); 
							}
						}
						if (CheckOver())
						{
							gameOver = true;
							tryAgain = false;
						}
					}
				}
                DisplayBoard(mainGame);
                DisplayScores(players);
            }
            
            // Show fhe final results.
            
            DisplayWinners(players);
            WriteLine( );
        }
    }
}
