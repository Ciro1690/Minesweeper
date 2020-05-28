require_relative 'tile'

class Board

    attr_reader :grid

    def initialize
        row,col,default_value = 9,9,'_'
        @grid = Array.new(row){Array.new(col,default_value)}
    end

    def num_bombs
        count = 0
        new_grid = @grid.flatten
        new_grid.each do |ele|
            count +=1 if ele == '*'
        end
        count
    end

    def drop_bombs
        while self.num_bombs < 10
            rand_row = rand(0...@grid.length)
            rand_col = rand(0...@grid.length)
            pos = [rand_row,rand_col]
            self[pos] = '*'
        end
    end

    def adjacent_bombs(pos)
        count = 0
        x,y = pos
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

    def [](pos)
        x,y = pos
        @grid[x][y]
    end

    def []=(pos,value)
        x,y = pos
        @grid[x][y] = value
    end

    def solved?
        @grid.each do |row|
            return false if row.any? {|tile| tile == '*'}
        end
    end

    def render
        print "  "
        puts (0..8).to_a.join(" ")
        @grid.each_with_index do |row,ind|
            print ind
            print " "
            puts row.join(' ')
        end
    end 

    def rows
        @grid
    end

    def columns
        rows.transpose!
    end
end