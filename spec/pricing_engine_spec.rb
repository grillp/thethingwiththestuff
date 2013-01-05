require 'spec_helper'

describe PricingEngine do
	subject { PricingEngine.new }
	let (:cart) { stub(:cart) }

	describe :total_for_cart do
		it 'should get the all items from cart' do
			cart.should_receive(:items).and_return []
			subject.total_for_cart cart
		end

	end

	describe :add_price_point do
		let (:item_price_calculator) {stub(:ItemPriceCalc).as_null_object}
		it 'should create a new price point per uniquely named item' do
			ItemPriceCalculator.should_receive(:new).twice().and_return(item_price_calculator)
			subject.add_price_point(price_point_with(name: :fred))
			subject.add_price_point(price_point_with(name: :mary))
		end

		it 'should not create a new price on duplicate named items' do
			ItemPriceCalculator.should_receive(:new).once().and_return(item_price_calculator)
			subject.add_price_point(price_point_with(name: :fred))
			subject.add_price_point(price_point_with(name: :fred))
		end

		it 'should add a quantity and price to the price calculator' do
			ItemPriceCalculator.stub(:new).and_return(item_price_calculator)

			item_price_calculator.should_receive(:add_price_point).with(12.21, 4, nil)

			subject.add_price_point(price_point_with(name: :fred, price: 12.21, quantity: 4))

		end

		it 'should set type if the type is included in the price point' do
			ItemPriceCalculator.stub(:new).and_return(item_price_calculator)

			item_price_calculator.should_receive(:add_price_point).with(12.21, 4, true)

			subject.add_price_point(price_point_with(name: :fred, price: 12.21, quantity: 4, threshold: true ))
		end

		let (:price_point) { price_point_with }

		[:name, :quantity, :price].each do |attribute_to_remove|
			it "should throw a RuntimeError if a price point does not contain a ':#{attribute_to_remove}' attributes" do
				price_point.delete(attribute_to_remove);
				lambda { subject.add_price_point price_point }.should raise_error(RuntimeError)
			end
		end

	end

	describe :price_for_item do
		let (:item_price_calculator) {stub(:ItemPriceCalc).as_null_object}
		before :each do
			ItemPriceCalculator.stub(:new).and_return(item_price_calculator)
			subject.add_price_point(price_point_with(name: :mary))
		end

		it 'should call items price caluculate with the items quantity' do
			quantity = 123
			item_price_calculator.should_receive(:price_for_quantity).with(123)
			subject.price_for_item(:mary, 123)
		end

	end

	describe :has_price_for? do
		it 'should return true if it has a price point for an item' do
			subject.add_price_point price_point_with(name: :exists)
			subject.should have_price_for :exists
		end
		it 'should return false if it has a price point for an item' do
			subject.add_price_point price_point_with(name: :exists)
			subject.should_not have_price_for :does_not_exist
		end
	end

	def price_point_with(params = {})
		{name: 'something', price: 1, quantity: 1}.merge(params)
	end


end