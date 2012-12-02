
require 'spec_helper'

describe PointOfSaleTerminal do
	subject {PointOfSaleTerminal.new(pricing_engine, cart)}
	
	let (:pricing_engine) { stub(:pricing__engine)}
	let (:cart) { stub(:cart)}
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
			item = stub(:an_item)
			cart.should_receive('add_item').with(item)
			subject.scan(item)
		end
	end

	describe 'total' do
		it 'should get all teh items from the cart' do
			cart.should_receive(:items).and_return([])
			subject.total
		end

		it 'should get the price for each item from the pricing engine' do
			cart.stub!(:items).and_return([{name: :one}, {name: :two}])
			pricing_engine.should_receive(:price_for_item).once.with(:one).and_return 0
			pricing_engine.should_receive(:price_for_item).once.with(:two).and_return 0
			subject.total
		end

		it "should return the sum of all the prices returned from the pricing engine" do
			cart.stub!(:items).and_return([{name: :one}, {name: :two}])
			pricing_engine.stub!(:price_for_item).with(:one).and_return 12.0
			pricing_engine.stub!(:price_for_item).with(:two).and_return 20.0

			subject.total.should == 32
		end

	end
end