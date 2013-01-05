class PricingEngine

	ITEM_PRICE_KEYS=[:name, :type, :prices]

  def initialize price_calculator_factory = nil
    @price_calculators = {}
    @price_calculator_factory = price_calculator_factory
  end

  def set_item_prices items_prices

    items_prices.each do |item_price|
    	validate_item_prices item_price
      @price_calculators[item_price[:name]] = @price_calculator_factory.create_calculator_for_type item_price[:type], item_price[:prices]
    end
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


  def validate_item_prices item_price
  	ITEM_PRICE_KEYS.each { |expected_key| raise ParameterError.new("Invalid item price definition. Missing :#{expected_key}") unless item_price.include? expected_key }
  end

end
