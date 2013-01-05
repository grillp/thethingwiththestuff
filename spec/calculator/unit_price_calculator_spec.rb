require 'spec_helper'

describe UnitPriceCalculator do
  let (:price) { 12.0 }
  let (:price_point) { {unit_price: 12.0} }
  subject {UnitPriceCalculator.new price_point}

  describe :new do
    it "should raise and error if the price point definition is missing the :unit_price key" do
      price_point.delete :unit_price
      expect {UnitPriceCalculator.new price_point}.to raise_error(ParameterError)
    end
  end

  describe :price_for_quantity do
    it "should return the quantity times the single unit price" do
      subject.price_for_quantity(10).should == 10 * price
    end

    it "should return zero if no quantity" do
      subject.price_for_quantity(0).should == 0
  	end

    it "should return zero for -ve quantities" do
      subject.price_for_quantity(-10).should == 0 
  	end

  end
end
