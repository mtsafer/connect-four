require_relative "../lib/connect_four"
describe ConnectFour do
	let(:game) {ConnectFour.new}
	describe "#look" do
		context "new game" do
			it "shows an empty board" do
				out = "|  |  |  |  |  |  |  |\n" + "----------------------\n"
				expect{game.look}.to output(out*6).to_stdout
			end
		end
		context "full board" do
			it "shows a full board" do
				(1..7).each do |i|
					(0..5).each { |x| game.find_column(i).push "#{game.black}" }
				end
				out = "|#{game.black} |#{game.black} |#{game.black} |#{game.black} |#{game.black} |#{game.black} |#{game.black} |\n" + \
							"----------------------\n"
				expect{game.look}.to output(out*6).to_stdout
			end
		end
	end
	describe "#find_column(n)" do
		it "returns the nth column" do
			expect(game.find_column(6)).to eql game.column6
		end
		context "bad number" do
			it "returns an empty array" do
				expect(game.find_column(8)).to eql []
			end
		end
	end
	describe "#add" do
		it "adds a token to the given column" do
			dummy = game.find_column(3)
			dummy.push game.white
			game.add( 3, game.white )
			expect(game.column3).to eql dummy
		end
		it "returns false if the column is full" do
			6.times { game.add( 1, game.black ) }
			expect(game.add( 1, game.white )).to eql false
		end
	end
	describe "#winner" do
		context "no winner" do
			it "returns false" do
				expect(game.winner).to eql false
			end
		end
		context "won through horizontal" do
			it "returns \u2b24" do
				(2..5).each { |i| game.add( i, game.white ) }
				expect(game.winner).to eql game.white
			end
		end
		context "winner through vertical" do
			it "returns \u25ef" do
				4.times { game.add( 3, game.black ) }
				expect(game.winner).to eql game.black
			end
		end
		context "diagonal" do
			it "returns \u2b24" do
				for i in 0..3
					i.times { game.add( i+1, game.black ) }
					game.add(i+1, game.white)
				end
				expect(game.winner).to eql game.white
			end
			it "returns \u25ef" do
				for i in 0..3
					i.times { game.add( 7 - i, game.white ) }
					game.add( 7 - i, game.black )
				end
				expect(game.winner).to eql game.black
			end
			it "returns \u25ef" do
				3.times{ game.add(3,game.black) }
				3.times{ game.add(4,game.white) }
				3.times{ game.add(4,game.black) }
				3.times{ game.add(5,game.white) }
				3.times{ game.add(5,game.black) }
				3.times{ game.add(6,game.white) }
				3.times{ game.add(6,game.black) }
				expect(game.winner).to eql game.black
			end
			it "returns false" do
				2.times do
					game.add(1,game.black)
					game.add(1,game.white)
				end
				2.times do
					game.add(2,game.white)
					game.add(2,game.black)
				end
				expect(game.winner).to eql false
			end
		end
		context "board is full, no winner" do
			it "returns 'nobody'" do
				(1..3).each do |i|
					3.times do
						game.add( i, game.black )
						game.add( i, game.white )
					end
				end
				(5..7).each do |i|
					3.times do
						game.add( i, game.black )
						game.add( i, game.white )
					end
				end
				3.times do
					game.add( 4, game.white )
					game.add( 4, game.black )
				end
				game.look
				expect(game.winner).to eql "nobody"
			end
		end 
	end
end