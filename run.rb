require_relative "lib/connect_four"

game = ConnectFour.new

def safe_input(game)
	input = gets.chomp
	if input.to_i.between?(1,7)
		input
	else
		print "bad input, try again: "
		input = safe_input game
	end
	input.to_i
end

def safe_add( input, token, game )
	added = game.add( input, token )
	unless added
		puts "That column is full!"
		print "#{token}  (1..7): "
		input = safe_input game
		safe_add( input, token, game )
	end
end

puts "enter 1-7 to play your turn."
puts "first to connect 4 wins."
puts ""
game.look
until game.winner
	print "#{game.white}  (1..7): "
	input = safe_input game
	safe_add( input, game.white, game )
	game.look
	break if game.winner
	puts ""
	print "#{game.black}  (1..7): "
	input = safe_input game
	safe_add( input, game.black, game )
	game.look
	puts ""
end
puts ""
puts "The winner was #{game.winner} !"