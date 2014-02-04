class YahtzeeRoll
	attr_reader :rolls
	def initialize(rolls)
		raise "Dice values btw 1 & 6 please!" unless rolls.each { |roll| roll.between?(1, 6) }
		@rolls = rolls
	end

	def roll_score(category)
		score = 0
		singles = ["ones", "twos", "threes", "fours", "fives", "sixes"].index(category)
		if singles
			@rolls.each do |roll|
				score += roll if roll == singles + 1
			end
			return score
		end
		case category
		when "pair"
				# Reverse sort so look for highest pair
			sorted = @rolls.sort.reverse
			sorted.each_with_index do |num, index|
				if num == sorted[index+1]
					return num * 2
				end
			end
		when "two pair"
			return score if @rolls.uniq.length > 3
			score += roll_count(2)
		when "three of a kind"
			score += roll_count(3)
		when "four of a kind"
			score += roll_count(4)
		when "small straight"
			score += 15 if @rolls.sort == (1..5).to_a
		when "large straight"
			score += 20 if @rolls.sort == (2..6).to_a
		when "full house"
			# Uniq length ensures exactly 2 different numbers
			# Permutations rules out 4 of a kind
			return score if @rolls.uniq.length != 2 || @rolls.permutation.to_a.uniq.length == 5
			@rolls.each { |val| score += val }
		when "yahtzee"
			score += 50 if @rolls.uniq.length == 1
		when "chance"
			@rolls.each { |num| score += num }
		end
		score
	end

	def roll_count(num)
		plus = 0
		@rolls.uniq.each do |value|
			if @rolls.count(value) >= num
				plus += (value * num)
			end
		end
		plus
	end

	def max_score
		# The chance option is ignored because it invalidates other options (besides yahtzee)
		options = ["ones", "twos", "threes", "fours", "fives", "sixes", "pair",
				"two pair", "three of a kind", "four of a kind", "small straight",
				"large straight", "full house", "yahtzee"]
		choice = ''
		best = 0
		options.each do |option|
			result = self.roll_score(option)
			if self.roll_score(option) > best
				best = self.roll_score(option)
				choice = option
			end
		end
		choice
	end
end
