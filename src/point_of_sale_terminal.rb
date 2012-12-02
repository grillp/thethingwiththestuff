require_relative 'pricing_engine'
require_relative 'cart'

class PointOfSaleTerminal
	def initialize(pricing_engine = PricingEngine.new, cart = Cart.new)
		@pricing_engine = pricing_engine
		@cart = cart
	end

	def set_pricing(pricing)
		pricing.each { |price_point| @pricing_engine.add_price_point price_point }
	end

	def scan(item)
		raise RuntimeError.new("There is no price for item '#{item}'") unless @pricing_engine.has_price_for? item
		@cart.add_item(item)
	end

	def total
		@cart.items.map{|item| @pricing_engine.price_for_item(item[:name], item[:quantity])}.reduce{|total, price| total += price}
	end

end