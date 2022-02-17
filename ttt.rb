class TicTacToe
  # Naming for cells and Seeds
  EMPTY  = 0
  CROSS  = 1
  NOUGHT = 2
  
  # Board
  ROWS 	  = 3 
  COLUMNS = 3
  
  @@board = Array.new(ROWS) { Array.new(COLUMNS) }
  
  # Statuses
  PLAYING    = 0
  DRAW 	     = 1
  CROSS_WON  = 2
  NOUGHT_WON = 3
  
  @@current_player = 0
  @@current_state  = 0
  @@current_row    = 0
  @@current_col	   = 0
  
  def run_tictactoe
    TicTacToe.init_game
    begin
      TicTacToe.play_game(@@current_player)
      TicTacToe.print_board
      TicTacToe.update_game(@@current_player, @@current_row, @@current_col)

      if @@current_state == TicTacToe::CROSS_WON
        puts "Congratulations! 'X' has won the game."
      elsif @@current_state == TicTacToe::NOUGHT_WON
        puts "Congratulations! 'O' has won the game."
      elsif @@current_state == TicTacToe::DRAW
        puts "It's a DRAW!"  
      end
    
      @@current_player = (@@current_player == TicTacToe::CROSS) ? TicTacToe::NOUGHT : TicTacToe::CROSS
    end while (@@current_state == TicTacToe::PLAYING)
  end
  
  def self.init_game
    for row in 0...TicTacToe::ROWS
      for col in 0...TicTacToe::COLUMNS
        @@board[row][col] = TicTacToe::EMPTY;
      end
    end
    
    @@current_state  = TicTacToe::PLAYING;
    @@current_player = TicTacToe::CROSS;
  end
  
  def self.play_game(the_seed)
    valid_input = false
    
    begin
      if the_seed == TicTacToe::CROSS
        puts "Current Player: 'X' Please enter row [1-3] columns [1-3]: "
      else
        puts "Current Player: 'O' Please enter row [1-3] columns [1-3]: "
      end
      
      row = gets.to_i - 1;
      col = gets.to_i - 1;
      
      if (row >= 0 && row < TicTacToe::ROWS && col >= 0 && col < TicTacToe::COLUMNS && @@board[row][col] == TicTacToe::EMPTY)
        @@current_row = row;
        @@current_col = col;
        @@board[@@current_row][@@current_col] = the_seed;
        valid_input = true;  
      else
        puts "Invalid Input! Please try again!"
      end
      
    end while (!valid_input)
  end
  
  def self.is_draw
    for row in 0...TicTacToe::ROWS
      for col in 0...TicTacToe::COLUMNS
        return false if @@board[row][col] == TicTacToe::EMPTY
      end
    end
    
    return true
  end
  
  def self.print_board
    for row in 0...TicTacToe::ROWS
      for col in 0...TicTacToe::COLUMNS
        TicTacToe.print_seed(@@board[row][col])
        print "|" if (col != TicTacToe::COLUMNS - 1)
      end
        
      puts ""
      puts "----------" if (row != TicTacToe::ROWS - 1)
    end
  end
  
  def self.update_game(the_seed, current_row, current_col)
    if(TicTacToe::who_won(the_seed, current_row, current_col)) 
      @@current_state = (the_seed == TicTacToe::CROSS) ? TicTacToe::CROSS_WON : TicTacToe::NOUGHT_WON
    elsif TicTacToe::is_draw
      @@current_state = TicTacToe::DRAW
    end
  end
  
  def self.print_seed(the_seed)
    case(the_seed)
      when TicTacToe::EMPTY
        print "  "
      when TicTacToe::CROSS
        print " X " 
      when TicTacToe::NOUGHT
        print " 0 "    
    end
  end
  
  def self.who_won(the_seed, current_row, current_col)
    winner = false
    
    if (@@board[current_row][0] == the_seed && @@board[current_row][1] == the_seed && @@board[current_row][2] == the_seed) 
      winner = true
    elsif (@@board[0][current_col] == the_seed && @@board[1][current_col] == the_seed && @@board[2][current_col] == the_seed) 
      winner = true
    elsif (current_row == current_col && @@board[0][0] == the_seed && @@board[1][1] == the_seed && @@board[2][2] == the_seed)
      winner = true
	elsif (current_row + current_col == 2 && @@board[0][2] == the_seed && @@board[1][1] == the_seed && @@board[2][0] == the_seed)
      winner = true
    end  
    
    winner
  end  
end

# Run TicTacToe
TicTacToe.new.run_tictactoe
