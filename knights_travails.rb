class GameNode

	attr_accessor :position, :moves

	def initialize(position)
		@position = position
		@moves = []
		can_move_to
	end

	#finds all the possible moves from a node.
	def can_move_to
		moves = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]
		moves.each do |x,y|
			move_x = @position[0] + x
			move_y = @position[1] + y
			if valid_move(move_x) and valid_move(move_y)
				@moves << [move_x, move_y]
			end
		end
	end		

	#checks to see if the found moves are valid.
	def valid_move(move_to)
		max = 7
		min = 0
		if move_to >= min and move_to <= max
			return true
		end
		false
	end
end


class KnightsTravails

	attr_accessor :to_visit, :visited_list, :to_stop

	def initialize
		@board = make_board
		@visited_list = []
		@to_visit = []
		@to_stop = []
	end

	#creates all the nodes for the gameboard. 
	def make_board
		positions = []
		(0..7).each { |x| (0..7).each { |y| positions << [x,y] }}
		nodes = []
		count = 0
		positions.each do |x|
			nodes << GameNode.new(x)
			count += 1
		end
		nodes
	end

	#calls finding_the_path to find the path and then displays the result
	def knight_moves(start, stop)
		finding_the_path(start, stop)
		puts " You made it in #{@to_stop.length - 1} moves! Here's your path:"
		@to_stop.reverse!
		@to_stop.each do |step|
			puts step.to_s
		end
	end

	#finds the shortest path from starting point to ending point
	#uses a queue and searches recersively 
	def finding_the_path(start, stop)
		@visited_list << start
		current_position = nil
		@board.each do |node|
			current_position = node if node.position == start
		end

		@to_visit.shift

		if current_position.moves.include? (stop)
			@to_stop << stop unless @to_stop.include?(stop)
			@to_stop << current_position.position				
			return true
		end

		current_position.moves.each do |move|
			@to_visit << move unless @visited_list.include?(move)
		end

		finding_the_path(@to_visit.first, stop)
		current_position.moves.each do |move|
			if move == @to_stop.last
				@to_stop << current_position.position
				return true
			end
		end
	end

end

game = KnightsTravails.new

game.knight_moves([5,7],[0,4])

#puts "Spots to visit: #{game.to_visit}"
#puts "Spots visited: #{game.visited_list}"
#puts "Way to the end: #{game.to_stop.reverse}"


