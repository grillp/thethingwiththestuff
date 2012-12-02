require_relative 'price_point_helper'

class ItemPriceCalculator

	include PricePointHelper

	def initialize
		@price_points = {}
	end

	def add_price_point amount, quantity
		@price_points[quantity] = amount
	end

	def price_for_quantity quantity
		quantity_left = quantity
		price = 0.0
		quantities = @price_points.keys
		while quantity_left > 0 do
			price_point_quantity = find_highest_not_greater_than_target(quantities, quantity_left)
			unless price_point_quantity.nil?
				quantity_left -= price_point_quantity
				price += @price_points[price_point_quantity]
			else
				raise RuntimeError.new("Cannot fullfill pricing for quantity: #{quantity}" ) unless price_point_quantity
			end
		end
		price
	end

end