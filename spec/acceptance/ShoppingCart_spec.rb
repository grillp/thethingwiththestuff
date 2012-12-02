require 'spec_helper' 

describe "Point of Sale Terminal" do
	subject { PointOfSaleTerminal.new } 
	before :each do
		subject.set_pricing(pricing);
	end

	context "with pricing set" do
		let (:pricing) {
			[
				{ name: "A", quantity: 1, price: 2.00  },
				{ name: "A", quantity: 4, price: 7.00  },
				{ name: "B", quantity: 1, price: 12.00 },
				{ name: "C", quantity: 1, price: 1.25  },
				{ name: "C", quantity: 6, price: 6.00  },
				{ name: "D", quantity: 1, price: 0.15  }
			]
		}

		{ 
			"ABCDABAA" => 32.40,
			"CCCCCCC" => 7.25,
			"ABCD" => 15.40
		}.each do |item_names, expected_total| 
			it "Should calculate calculate total of #{expected_total} for items '#{item_names}'" do
				item_names.each_char do |item_name| 
					subject.scan(item_name)
				end
				subject.total.should == expected_total
			end
		end
	end

end