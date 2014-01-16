require 'spec_helper'
require_relative '../yahtzee'


describe 'YahtzeeRoll' do
	describe '#initialize' do
		it 'should take an array of 5 integers' do
			expect(YahtzeeRoll.new([1,2,3,4,5]).class).to eq YahtzeeRoll
		end
		it 'should raise an error if the data is not 5 valid rolls' do
			expect { YahtzeeRoll.new([8,3,2,5,"cat"]) }.to raise_error
		end
		it 'should store the values of the dice as an @rolls array' do
			rollz = YahtzeeRoll.new([1,2,3,4,5])
			expect(rollz.rolls).to match_array [1,2,3,4,5]
		end
	end

	describe '#roll_score' do
		before(:each) do
			@roll = YahtzeeRoll.new([1,2,3,4,5])
			@roll2 = YahtzeeRoll.new([2,3,4,5,6])
			@pair = YahtzeeRoll.new([2,2,4,5,5])
			@pair2 = YahtzeeRoll.new([2,3,3,5,6])
			@three = YahtzeeRoll.new([3,3,3,5,6])
			@four = YahtzeeRoll.new([2,2,2,2,1])
			@fh = YahtzeeRoll.new([5,5,5,6,6])
			@yahtzee = YahtzeeRoll.new([5,5,5,5,5])
		end
		it 'should should score by 1 if "ones" is provided' do
			expect(@roll.roll_score("ones")).to eq 1
			expect(@roll2.roll_score("ones")).to eq 0
		end
		it 'should correctly score options 2-6' do
			expect(@roll.roll_score("twos")).to eq 2
			expect(@roll2.roll_score("threes")).to eq 3
			expect(@roll.roll_score("fours")).to eq 4
			expect(@roll2.roll_score("fives")).to eq 5
			expect(@roll.roll_score("sixes")).to eq 0
		end
		it 'should sum the value of the highest pair when "pair" is provided' do
			expect(@pair.roll_score("pair")).to eq 10
			expect(@pair2.roll_score("pair")).to eq 6
			expect(@roll.roll_score("pair")).to eq 0
		end
		it 'should sum the value of two pairs when "two pair" is provided' do
			expect(@pair.roll_score("two pair")).to eq 14
			expect(@pair2.roll_score("two pair")).to eq 0
		end
		it 'should sum the value of three of a kind matches when "three of a kind" is provided' do
			expect(@three.roll_score("three of a kind")).to eq 9
			expect(@pair.roll_score("three of a kind")).to eq 0
		end
		it 'should sum four of a kind when provided "four of a kind"' do
			expect(@four.roll_score("four of a kind")).to eq 8
			expect(@roll2.roll_score("four of a kind")).to eq 0
		end
		it 'sum the dice value when small or large straights exist and "small straight" or "large straight" provided' do
			expect(@roll.roll_score("small straight")).to eq 15
			expect(@roll2.roll_score("large straight")).to eq 20
			expect(@roll.roll_score("large straight")).to eq 0
			expect(@roll2.roll_score("small straight")).to eq 0
		end
		it 'sums all the dice when a full house exists and is provided' do
			expect(@four.roll_score("full house")).to eq 0
			expect(@fh.roll_score("full house")).to eq 27
		end
		it 'returns 50 if all die values are the same and "yahtzee" is provided' do
			expect(@yahtzee.roll_score("yahtzee")).to eq 50
			expect(@fh.roll_score("yahtzee")).to eq 0
		end
		it 'returns the sum of all dice when "chance" is provided' do
			expect(@yahtzee.roll_score("chance")).to eq 25
			expect(@fh.roll_score("chance")).to eq 27
		end
	end
	describe '#max_score' do
		before(:each) do
			@roll = YahtzeeRoll.new([1,2,3,4,5])
			@roll2 = YahtzeeRoll.new([2,3,4,5,6])
			@pair = YahtzeeRoll.new([2,2,4,5,5])
			@pair2 = YahtzeeRoll.new([2,3,3,5,6])
			@three = YahtzeeRoll.new([3,3,3,5,6])
			@four = YahtzeeRoll.new([2,2,2,2,1])
			@fh = YahtzeeRoll.new([5,5,5,6,6])
			@yahtzee = YahtzeeRoll.new([5,5,5,5,5])
		end
		it 'selects the scoring option that provides the highest score' do
			expect(@roll.max_score).to eq "small straight"
			expect(@yahtzee.max_score).to eq "yahtzee"
			expect(@fh.max_score).to eq "full house"
		end
	end

end
