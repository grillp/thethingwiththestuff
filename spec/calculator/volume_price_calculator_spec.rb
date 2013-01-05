require 'spec_helper'

describe VolumePriceCalculator do
  let (:price_points) {[]}
  subject {VolumePriceCalculator.new price_points}
  
  describe :new do
    valid_keys = [:price, :quantity]
    valid_keys.each do |key|   
      it "should raise and error if price point is missing #{key}" do
        price_point = {price: :price, quantity: :quantity}
        price_point.delete key
        expect { VolumePriceCalculator.new [price_point]}.to raise_error(ParameterError)
      end
    end
  end

  describe :price_for_quantity do
    context 'when only a single price point exists' do
      let (:price_points) do
        [
          {price: 12.00, quantity: 1}
        ]
      end
      it "should return the quantity times the single unit price" do
        subject.price_for_quantity(10).should == 120.00
      end
    end
    context 'when price point exists for multiple quantities' do
      let (:price_points) do
        [
          {price: 10.00, quantity: 1},
          {price: 45.00, quantity: 5},
          {price: 80.00, quantity: 10}
        ]
      end

      it 'should use the multi-quantity price point only, if the quantity is an exact multiple of the price point quantity' do
        subject.price_for_quantity(5).should == 45.00
      end

      it 'should use best matching price points by quantity to fullfill quantity' do
        subject.price_for_quantity(17).should == 145
      end
    end

    context 'when price point quantities can not fullfil the requested quantity' do
      let (:price_points) do
        [
          {price: 45.00, quantity: 5},
          {price: 80.00, quantity: 10}
        ]
      end

      it "should raise a runtime exception" do
        lambda {subject.price_for_quantity(16)}.should raise_error(RuntimeError, "Cannot fullfill pricing for quantity: 16")
      end
    end

  end
end
