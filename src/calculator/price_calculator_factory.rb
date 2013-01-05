require_relative "volume_price_calculator"
require_relative "unit_price_calculator"
require_relative "threshold_price_calculator"

class PriceCalculatorFactory
	def create_for_type type, prices
		class_for(type).new prices
	end

	private 

	def titlize string
		string.slice(0,1).capitalize + string.downcase.slice(1..-1)
	end

	def class_for type
		type = titlize type.to_s
		Object.const_get("#{type}PriceCalculator")
	end
end