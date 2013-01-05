require_relative "../spec_helper"

describe PriceCalculatorFactory do
	class TestPriceCalculator
	end

	subject {PriceCalculatorFactory.new}
	describe :create_for_type do
	  it "should return a priceCalculator instance for :type, initialize with :pricws" do
	  	mock_test_class_instance = mock(:TestClass_instance)
	  	TestPriceCalculator.should_receive(:new).with(:prices).and_return(mock_test_class_instance)
	  	subject.create_for_type(:test, :prices).should == mock_test_class_instance
	  end
	end
  
end