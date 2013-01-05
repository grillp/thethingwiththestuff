require_relative '../price_point_helper'

class VolumePriceCalculator

  include PricePointHelper

  PRICE_POINT_KEYS = [:price, :quantity]

  def initialize price_points
    @price_points = {}
    initilize_price_points price_points
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
          raise RuntimeError.new("Cannot fullfill pricing for quantity: #{quantity}") unless price_point_quantity
        end
      end
      price
    end

    private

    def initilize_price_points price_points
      price_points.each do |pp|
        vaildate_price_point_definition pp
        add_price_point pp[:price], pp[:quantity]
      end
    end

    def vaildate_price_point_definition pp
      PRICE_POINT_KEYS.each { |expected_key| raise ParameterError.new("Invalid item price definition. Missing :#{expected_key}") unless pp.include? expected_key }
    end

  end
