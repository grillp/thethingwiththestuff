require 'spec_helper'

describe Cart do
	subject {Cart.new}
	describe :items do
		it 'should be empty of no items have been added' do
			subject.items.should be_empty
		end

		it "should return array with elements contains item name added" do
			subject.add_item :item_one
			subject.add_item :item_two

			subject.items.size.should == 2
			subject.items.map{|item| item.name}.should include :item_one
			subject.items.map{|item| item.name}.should include :item_two
		end

		it "should not contain elements with duplicate names" do
			subject.add_item :item_one
			subject.add_item :item_one

			subject.items.size.should == 1
			subject.items.map{|item| item.name}.should include :item_one
		end

		it "should set the quantity for an item added once to 1" do
			subject.add_item :single_item

			subject.items.find{|item| item.name == :single_item}.quantity.should == 1
		end

		it "should aggregate the quantity of duplicate items added" do
			subject.add_item :triple_item
			subject.add_item :triple_item
			subject.add_item :triple_item

			subject.items.find{|item| item.name == :triple_item}.quantity.should == 3
		end

	end
end