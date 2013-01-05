
module PricePointHelper

	def find_highest_not_greater_than_target numbers, target
		return target if numbers.include? target
		return nil if numbers.min > target
		numbers.reduce(1) do |memo,n|
			max = [memo,n].max
			max <= target ? max : memo
		end
	end
end