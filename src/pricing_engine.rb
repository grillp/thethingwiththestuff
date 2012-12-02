require_relative 'item_price_calculator'

class PricingEngine
	
	def initialize()		
		@price_calculators = {}
	end

	def add_price_point price_point 
		name = price_point[:name]
		quantity = price_point[:quantity]
		price = price_point[:price]
		price_calculator = @price_calculators[name] ||= ItemPriceCalculator.new
		price_calculator.add_price_point(price, quantity)
	end

	def total_for_cart cart
		cart.items
	end

	def price_for_item name, quantity 
		@price_calculators[name].price_for_quantity quantity
	end


end