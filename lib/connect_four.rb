class ConnectFour
	attr_reader :column1, :column2, :column3, :column4,
							:column5, :column6, :column7
	@@white = "\u2b24"
	@@black = "\u25ef"
	def initialize
		@column1 = []
		@column2 = []
		@column3 = []
		@column4 = []
		@column5 = []
		@column6 = []
		@column7 = []
		@seperator = "----------------------"
	end

	def black
		@@black
	end

	def white
		@@white
	end

	def look
		(5.downto 0).each do |x|
			print "|"
			(1..7).each do |i|
				column = find_column(i)
				print("  |") unless column[x]
				print( column[x] + " |" ) if column[x]
			end
			puts ""
			puts @seperator
		end
	end

	def find_column n
		case n
		when 1 then column1
		when 2 then column2
		when 3 then column3
		when 4 then column4
		when 5 then column5
		when 6 then column6
		when 7 then column7
		else []
		end
	end

	def add column, token
		column = find_column(column)
		column.length < 6 ? column.push(token) : false
	end

	def winner
		winner = false
		winner ||= check_vertical @@black
		winner ||= check_vertical @@white
		winner ||= check_horizontal @@black
		winner ||= check_horizontal @@white
		winner ||= check_diagonal @@black
		winner ||= check_diagonal @@white
		winner ||= check_full
		winner
	end

	private

		def check_vertical token
			consecutive = 0
			winner = false
			for i in 1..7
				column = find_column i
				for j in 0..5
					column[j] == token ? consecutive += 1 : consecutive = 0
					winner = token if consecutive >= 4
				end
			end
			winner
		end

		def check_horizontal token
			consecutive = 0
			winner = false
			for i in 0..5
				for j in 1..7
					column = find_column j
					column[i] == token ? consecutive += 1 : consecutive = 0
					winner = token if consecutive >= 4
				end
			end
			winner
		end

		def check_diagonal token
			winner = false
			for x in 0..2
				for z in 0..3
					consecutive = 0
					for j in 0..3
						column = find_column( j + z + 1 )
						column[ j + x ] == token ? consecutive += 1 : consecutive = 0
						winner = token if consecutive >= 4
					end
					consecutive = 0
					for i in 0..3
						column = find_column( 7 - z - i )
						column[ i + x ] == token ? consecutive += 1 : consecutive = 0
						winner = token if consecutive >= 4
					end
				end
			end
			winner
		end

		def check_full
			full = "nobody"
			(1..7).each do |i|
				full = false if (find_column(i).length < 6)
			end
			full
		end
end