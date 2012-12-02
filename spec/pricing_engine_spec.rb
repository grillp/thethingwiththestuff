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

end