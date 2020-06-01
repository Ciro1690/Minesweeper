class Tile
    attr_accessor :value

    def initialize(value)
        @value = value
    end

    def value=(new_value)
        @value = new_value
    end
end