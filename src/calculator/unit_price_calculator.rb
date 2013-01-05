class UnitPriceCalculator

  def initialize price_point
  	vaildate_price_point_definition price_point
    @unit_price = price_point[:unit_price]
  end

  def price_for_quantity quantity
    return 0 if quantity <= 0
    @unit_price * quantity
  end

  private

  def vaildate_price_point_definition price_point
    raise ParameterError.new("Invalid Price Point definition. Missing :unit_price key") unless (price_point[:unit_price])
  end


end
