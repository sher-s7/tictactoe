class Player
    attr_accessor :name, :token
    def initialize(name, token)
        @name = name
        @token = token
    end

    def placeToken(board) #board should be an array with 9 items (represents 3x3 grid)
        begin
            puts "Where do you want to place your token?"
            index = gets.chomp.upcase
            if !Game.MOVES.keys.include?(index.to_sym)
                raise 'Error: Invalid move. Moves are denoted by a letter from A-C and number from 1-3. Example: "B3"'
            elsif board[Game.MOVES[index.to_sym]] != '| |'
                raise "Error: Spot already taken on board, choose another"
            else
                board_index = Game.MOVES[index.to_sym]
            end
        rescue Exception=>e
            puts e
            retry
        end
        board[board_index] = "|#{self.token}|"
        
    end

end

class Game
    attr_reader :board, :MOVES, :turn
    @@MOVES = {'A1': 0, 'B1': 1, 'C1': 2, 'A2': 3, 'B2': 4, 'C2': 5, 'A3': 6, 'B3': 7, 'C3': 8}
    def initialize()
        @board = ['| |','| |','| |','| |','| |','| |','| |','| |','| |']
        @turn = 1 
        puts 'Welcome. Player 1 enter your name:'
        @player1 = Player.new(gets.chomp, 'X')
        puts 'Player 2 enter your name: '
        @player2 = Player.new(gets.chomp, 'O')

        play(@player1, @player2)

    end
    
    def self.MOVES
        @@MOVES
    end

    def isWin?(token)
        spot = "|#{token}|"
        #checks rows
        [0,3,6].each do |i| 
            return true if @board[i]==spot && @board[i+1]==spot && @board[i+2]==spot
        end

        #checks columns
        (0..2).each do |i| 
            return true if @board[i]==spot && @board[i+3]==spot && @board[i+6]==spot
        end

        #checks diagonals
        return true if @board[0] == spot && @board[4] == spot && @board[8] == spot
        return true if @board[2] == spot && @board[4] == spot && @board[6] == spot

        #if no winning areas
        return false

    end

    def printBoard()
        lineWidth = 50
        line = 1
        puts 'A  B  C'.center(lineWidth)
        [0,3,6].each do |i|
            puts "#{line}#{@board[i]}#{@board[i+1]}#{@board[i+2]}".center(48)
            line+=1
        end
    end

    def swap(p1, p2, turn)
        if turn == p2
            turn = p1 
        else 
            turn = p2 
        end
        return turn
    end

    def play(p1, p2)
        puts 'TIC TAC TOE'.center(50)
        printBoard()
        turn = p1
        while true
            if isWin?(p1.token)
                puts "#{p1.name} wins!"
                return
            elsif isWin?(p2.token)
                puts "#{p2.name} wins!"
                return
            elsif !@board.include? '| |'
                puts 'A tie!'
                return
            end
            puts "#{turn.name}'s turn: "
            turn.placeToken(@board)
            printBoard()
            turn = swap(p1,p2,turn)
        end
        
    end
    
end

Game.new()