class ThresholdPriceCalculator

	def initialize price_point
		validate_price_point price_point
		@unit_price = price_point[:unit_price]
		@threshold_price = price_point[:threshold_price]
		@threshold_quantity = price_point[:threshold_quantity]
	end

	def price_for_quantity quantity
		return 0 if quantity <= 0
		return @threshold_price * quantity if quantity >= @threshold_quantity
		@unit_price * quantity
	end

	private

	def validate_price_point price_point

	end

end