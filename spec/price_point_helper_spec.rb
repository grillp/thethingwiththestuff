require 'spec_helper'

describe PricePointHelper do
	class DummyClass
	end

	before(:each) do
	  @dummy_class = DummyClass.new
	  @dummy_class.extend(PricePointHelper)
	end

	describe :find_highest_not_greater_than_target do
		it 'should reutrn nil if no number in the list is less than the target' do
			@dummy_class.find_highest_not_greater_than_target([4,3,9,5],1).should be_nil
		end

		it 'should return highest value in list if target is greater than all valus in list target' do
			@dummy_class.find_highest_not_greater_than_target([4,3,9,5],100).should == 9
		end

		it 'should return target match if numbers include target matches target' do
			@dummy_class.find_highest_not_greater_than_target([4,3,9,5],3).should == 3
		end

		it 'should return highest number not greater than target' do
			@dummy_class.find_highest_not_greater_than_target([4,3,9,5],7).should == 5
			@dummy_class.find_highest_not_greater_than_target([10,5,1],7).should == 5
		end
	end
end