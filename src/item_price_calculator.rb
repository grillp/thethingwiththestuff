require_relative 'price_point_helper'

class ItemPriceCalculator

	include PricePointHelper

	def initialize
		@price_points = {}
		@threshold = false
		@threshold_price = 0
		@threshold_quantity = 0

	end

	def add_price_point amount, quantity, threshold=false
		 @threshold = threshold
		if @threshold 
			@threshold_quantity = quantity 
			@threshold_price = amount 
		else
			@price_points[quantity] = amount
		end
	end

	def price_for_quantity quantity
		quantity_left = quantity
		price = 0.0
		quantities = @price_points.keys
		while quantity_left > 0 do
			price_point_quantity = find_highest_not_greater_than_target(quantities, quantity_left)
			unless price_point_quantity.nil?
				quantity_left -= price_point_quantity
				price_point_price = @price_points[price_point_quantity]
				price_point_price = @threshold_price if price_point_quantity == 1 && @threshold && quantity >= @threshold_quantity 
				price += price_point_price
			else
				raise RuntimeError.new("Cannot fullfill pricing for quantity: #{quantity}" ) unless price_point_quantity
			end
		end
		price
	end

end