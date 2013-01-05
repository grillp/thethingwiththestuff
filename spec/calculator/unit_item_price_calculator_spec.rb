require 'spec_helper'

describe UnitItemPriceCalculator do
  let (:price) { 12.0 }
  subject {UnitItemPriceCalculator.new(price: price)}
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
