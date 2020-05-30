require_relative 'tile'

class Board

    MOVES = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]
    attr_reader :grid

    def initialize
        row,col,default_value = 9,9,'_'
        @grid = Array.new(row){Array.new(col,default_value)}
    end

    def [](pos)
        x,y = pos
        grid[x][y]
    end

    def []=(pos,value)
        x,y = pos
        grid[x][y] = value
    end

    def num_bombs
        count = 0
        new_grid = grid.flatten
        new_grid.each do |ele|
            count +=1 if ele == '*'
        end
        count
    end

    def flag(pos)
        self[pos] = 'F'
    end

    def reveal(pos)
        if self[pos] == '*'
            puts 'You revealed a bomb... Game over!'
            exit!
        end
    end

    def adjacent_bombs(pos)
        count = 0
        x,y = pos
        MOVES.each do |dx,dy|
            new_pos = [x + dx, y + dy]

            if new_pos.all? {|coord| coord.between?(0,8)}  
                if self[new_pos] == '*'  
                    count +=1
                end
            end
        end
        self[pos] = count
    end

    def drop_bombs
        while self.num_bombs < 10
            rand_row = rand(0...@grid.length)
            rand_col = rand(0...@grid.length)
            pos = [rand_row,rand_col]
            self[pos] = '*'
        end
    end

    def empty_board
        grid.map do |row| 
            row.map do |ele|
                if ele == "*"
                    '_'
                else
                    ele
                end
            end
        end
    end

    def solved?
        grid.each do |row|
            return false if row.any? {|tile| tile == '*'}
        end
    end

    def self.print_grid(grid)
        grid.each do |row|
            puts row.join(" ")
        end
    end

    def print
        Board.print_grid(empty_board)
    end

    def cheat
        Board.print_grid(grid)
    end

    def rows
        grid
    end

    def columns
        rows.transpose!
    end
end