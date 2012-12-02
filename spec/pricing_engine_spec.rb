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
			subject.add_price_point({name: :fred})
			subject.add_price_point({name: :mary})
		end

		it 'should not create a new price on duplicate named items' do
			ItemPriceCalculator.should_receive(:new).once().and_return(item_price_calculator)
			subject.add_price_point({name: :fred})
			subject.add_price_point({name: :fred})
		end

		it 'should add a quantity and price to the price calculator' do
			ItemPriceCalculator.stub(:new).and_return(item_price_calculator)

			item_price_calculator.should_receive(:add_price_point).with(12.21, 4)

			subject.add_price_point({name: :fred, price: 12.21, quantity: 4})

		end
	end

	describe :price_for_item do
		let (:item_price_calculator) {stub(:ItemPriceCalc).as_null_object}
		before :each do
			ItemPriceCalculator.stub(:new).and_return(item_price_calculator)
			subject.add_price_point({name: :mary})
		end

		it 'should call items price caluculate with the items quantity' do
			quantity = 123
			item_price_calculator.should_receive(:price_for_quantity).with(123)
			subject.price_for_item(:mary, 123)
		end

	end


end