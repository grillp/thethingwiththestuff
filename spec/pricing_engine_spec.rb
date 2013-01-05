require 'spec_helper'

describe PricingEngine do
  let (:price_calculator_factory) {mock(:price_calculator_factory)}
  subject { PricingEngine.new price_calculator_factory }
  let (:cart) { stub(:cart) }
  let (:valid_item_prices) { [{name: :name1, type: :type1, prices: :prices1},
                              {name: :name2, type: :type2, prices: :prices2}] }

  describe :total_for_cart do
    it 'should get the all items from cart' do
      cart.should_receive(:items).and_return []
      subject.total_for_cart cart
    end
  end

  describe :set_item_prices do

    it "should get a price calculator for each price" do
      price_calculator_factory.should_receive(:create_for_type).once().with(:type1, :prices1)
      price_calculator_factory.should_receive(:create_for_type).once().with(:type2, :prices2)
      subject.set_item_prices valid_item_prices
    end

    valid_keys = [:name, :type, :prices]
    valid_keys.each do |key|
    	it "should raise an error if the key :#{key} is missing from the item price" do
				 item_prices = {name: :name1, type: :type1, prices: :prices1}
				 item_prices.delete key
				 expect { subject.set_item_prices [item_prices] }.to raise_error(ParameterError)			  	 	 
    	end
    end
  end

  context "with pricing set" do
    let (:calc1) {mock(:calc1)}
    let (:calc2) {mock(:calc2)}
    before do
      price_calculator_factory.stub(:create_for_type).with(:type1, :prices1).and_return(calc1)
      price_calculator_factory.stub(:create_for_type).with(:type2, :prices2).and_return(calc2)
      subject.set_item_prices valid_item_prices
    end

    describe :price_for_item do     
      it 'should call items price calculator' do
        calc1.should_receive(:price_for_quantity).with(123)
        subject.price_for_item(:name1, 123)
      end
    end

    describe :has_price_for? do
      it 'should return true if it has a price point for an item' do
        subject.should have_price_for :name1
      end
      it 'should return false if it has a price point for an item' do
        subject.should_not have_price_for :unknown
      end
    end

  end

end
