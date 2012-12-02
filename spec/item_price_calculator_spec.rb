require 'spec_helper'

describe ItemPriceCalculator do
	subject {ItemPriceCalculator.new}
	describe :price_for_quantity do
		context 'when only a single price point exists' do
			it "should return the quantity times the single unit price" do
				subject.add_price_point(12.00, 1)
				subject.price_for_quantity(10).should == 120.00
			end
		end
		context 'when price point exists for multiple quantities' do
			before :each do
				subject.add_price_point(80.00, 10)
				subject.add_price_point(45.00, 5)
				subject.add_price_point(10.00, 1)
			end


			it 'should use the multi-quantity price point only, if the quantity is an exact multiple of the price point quantity' do
				subject.price_for_quantity(5).should == 45.00
			end

			it 'should use best matching price points by quantity to fullfill quantity' do
				subject.price_for_quantity(17).should == 145
			end
		end

		context 'when price point quantities can not fullfil the requested quantity' do
			before :each do
				subject.add_price_point(80.00, 10)
				subject.add_price_point(45.00, 5)
			end
			it "should raise a runtime exception" do
				lambda {subject.price_for_quantity(16)}.should raise_error(RuntimeError, "Cannot fullfill pricing for quantity: 16")
			end
		end

	end
end