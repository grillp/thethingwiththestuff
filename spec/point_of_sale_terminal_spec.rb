
require 'spec_helper'

describe PointOfSaleTerminal do
	subject {PointOfSaleTerminal.new(pricing_engine, cart)}
	let (:pricing_engine) { stub(:pricing__engine)}
	let (:cart) { stub(:cart)}
	let (:has_price_for) {true}
	before :each do
		pricing_engine.stub!(:has_price_for?).with(anything()).and_return has_price_for
	end

	describe 'set_pricing' do
		it 'should add each price to the procing engine' do
			price_one = {name: 0};
			price_two = {name: 1};
			pricing = [price_one, price_two]
			pricing_engine.should_receive(:add_price_point).once.with(price_one)
			pricing_engine.should_receive(:add_price_point).once.with(price_two)

			subject.set_pricing(pricing)
		end
	end

	describe 'scan' do
		it 'should add the item name to the cart' do
			cart.should_receive('add_item').with(:item_name)
			subject.scan(:item_name)
		end

		it 'should ask pricing_engine if it has a price for the item' do
			cart.stub(:add_item)
			pricing_engine.should_receive('has_price_for?').with(:item_name).and_return true
			subject.scan(:item_name)
		end

		context 'for an item that does not exist' do
			let (:has_price_for) {false}
			it "should raise a runtime error" do
				lambda {subject.scan :does_not_exist}.should raise_error(RuntimeError)
			end
		end
	end

	describe 'total' do
		it 'should get all the items from the cart' do
			cart.should_receive(:items).and_return([])
			subject.total
		end

		it 'should get the price for each item from the pricing engine' do
			cart.stub!(:items).and_return([{name: :one, quantity: :quant_1}, {name: :two, quantity: :quant_2}])
			pricing_engine.should_receive(:price_for_item).once.with(:one, :quant_1).and_return 0
			pricing_engine.should_receive(:price_for_item).once.with(:two, :quant_2).and_return 0
			subject.total
		end

		it "should return the sum of all the prices returned from the pricing engine" do
			cart.stub!(:items).and_return([{name: :one}, {name: :two}])
			pricing_engine.stub!(:price_for_item).with(:one, anything()).and_return 12.0
			pricing_engine.stub!(:price_for_item).with(:two, anything()).and_return 20.0

			subject.total.should == 32
		end

	end
end