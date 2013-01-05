require 'spec_helper'

describe ThresholdPriceCalculator do
  let (:price_point) { { unit_price: 1.00, threshold_quantity: 10, threshold_price: 0.9} }
  subject {ThresholdPriceCalculator.new(price_point)}
  describe :price_for_quantity do
    it "should return the quantity times the single unit price when quantity is below the threshold" do
      subject.price_for_quantity(5).should == 5 * 1.00
    end

    it "should return the quantity times the threshold unit price when quantity is at the threshold" do
      subject.price_for_quantity(10).should == 10 * 0.9
    end

    it "should return the quantity times the threshold unit price when quantity is above the threshold" do
      subject.price_for_quantity(11).should == 11 * 0.9
    end

    it "should return zero if no quantity" do
      subject.price_for_quantity(0).should == 0
  	end

    it "should return zero for -ve quantities" do
      subject.price_for_quantity(-10).should == 0 
  	end

  end
end
