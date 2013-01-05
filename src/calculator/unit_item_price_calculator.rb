class UnitItemPriceCalculator

	def initialize params={}
		@unit_price = params[:price]
	end

	def price_for_quantity quantity
		return 0 if quantity <= 0
		@unit_price * quantity
	end

end