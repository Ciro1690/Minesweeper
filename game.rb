require_relative 'board'

class Game

    def initialize
        @board = Board.new
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Please enter a position on the board (e.g. '3,4) "
            print "> "

            begin
                pos = parse_pos(gets)
            rescue
                puts "Invalid position entered. "
                puts ""

                pos = nil
            end
        end
        pos
    end

    def get_val
        val = nil
        until val && valid_val?(val)
            puts "Please enter 'F' to flag a bomb or 'R' to reveal a bomb "
            print "> "
            val = gets.chomp
        end
        val
    end

    def parse_pos(string)
        string.split(",").map {|char| Integer(char)}
    end

    def run
      @board.drop_bombs
      play_turn until solved?
      @board.print
      puts "Congratulations, you win!"
    end

    def play_turn
        @board.print
        pos = get_pos
        val = get_val

        if val == 'F'
            @board.flag(pos)
        elsif val == 'R'
            @board.reveal(pos)
            @board.adjacent_bombs(pos)
        end
    end

    def solved?
        @board.solved?
    end

    def valid_pos?(pos)
        print pos
        if pos.length == 2
            return true
        else
            get_pos
        end
    end

    def valid_val?(val)
        val == "F" || val == "R"
    end 

    def size
        grid.size
    end

end

game = Game.new
game.run