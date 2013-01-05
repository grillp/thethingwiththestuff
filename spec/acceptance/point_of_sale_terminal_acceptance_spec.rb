require 'spec_helper'

describe "Point of Sale Terminal" do
  subject { PointOfSaleTerminal.new }
  context "with pricing set" do
    # let (:pricing) {
    #   [
    #     { name: "A", quantity: 1, price: 2.00  },
    #     { name: "A", quantity: 4, price: 7.00  },
    #     { name: "B", quantity: 1, price: 12.00 },
    #     { name: "C", quantity: 1, price: 1.25  },
    #     { name: "C", quantity: 6, price: 6.00  },
    #     { name: "D", quantity: 1, price: 0.15  },
    #     { name: "F", quantity: 1, price: 1.00  },
    #     { name: "F", quantity: 10, price: 0.90, threshold: true },
    #   ]
    # }

    let (:pricing) {
      [
        { name: "A", type: :volume,    prices: [{ quantity: 1, quantity_price: 2.00  },
                                                { quantity: 4, quantity_price: 7.00  }]},
        { name: "B", type: :unit,      prices:  { unit_price: 12.00 } },
        { name: "C", type: :volume,    prices: [{ quantity: 1, quantity_price: 1.25  },
                                                { quantity: 6, quantity_price: 6.00  }]},
        { name: "D", type: :unit,      prices:  { unit_price: 0.15  } },
        { name: "F", type: :threshold, prices:  { unit_price: 1.00,
                                                  threshold_quantity: 10, threshold_price: 0.90 } }
      ]
    }


    {
      "ABCDABAA" => 32.40,
      "CCCCCCC" => 7.25,
      "ABCD" => 15.40,
      "F" => 1.00,
      "FFF" => 3.00,
      "FFFFFFFFFF" => 9.00,
      "FFFFFFFFFFFF" => 10.80
    }.each do |item_names, expected_total|
      it "Should calculate calculate total of #{expected_total} for items '#{item_names}'" do
        pending "Should not work yet"
        subject.set_pricing(pricing);
        item_names.each_char do |item_name|
          subject.scan(item_name)
        end
        subject.total.should be_within(0.001).of(expected_total)
      end
    end
  end

end
