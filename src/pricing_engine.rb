require_relative 'item_price_calculator'

class PricingEngine
	
	def initialize()		
		@price_calculators = {}
	end

	def add_price_point prce_point 
		name = price_point[:name]
		quantity = price_point[:quantity]
		price = price_point[:price]
		price_calculators = @price_calculators[name] ||= ItemPriceCalulator.new

	end

	def total_for_cart cart
		cart.items
	end

	def price_for_item item 
		0
	end


end