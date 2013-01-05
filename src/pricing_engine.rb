require_relative 'item_price_calculator'

class PricingEngine

	def initialize()
		@price_calculators = {}
	end

	def add_price_point price_point
		raise RuntimeError.new("price_point not complete: #{price_point}") unless price_point_complete(price_point)
		price_calculator = @price_calculators[price_point[:name]] ||= ItemPriceCalculator.new
		price_calculator.add_price_point(price_point[:price], price_point[:quantity], price_point[:threshold])
	end

	def total_for_cart cart
		cart.items
	end

	def price_for_item name, quantity
		@price_calculators[name].price_for_quantity quantity
	end

	def has_price_for? name
		@price_calculators.has_key? name
	end

	private

	def price_point_complete price_point
		[:name, :price, :quantity].each do |attr|
			return false unless price_point[attr]
		end
		true
	end

end