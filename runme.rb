#!/usr/bin/env ruby

require_relative 'src/point_of_sale_terminal'

puts
puts 'Running Problem Examples'
puts '------------------------'
puts

def run_customer_session price_points, items_to_buy
  terminal = PointOfSaleTerminal.new()
  terminal.set_pricing price_points
  puts "--[new customer session]---------"
  puts "Purchaing items: '#{items_to_buy}'"
  items_to_buy.each_char{|c| terminal.scan c}
  puts "          Price: $#{'%.2f' % terminal.total}"

end

price_points =
      [
        { name: "A", type: :volume,    prices: [{ quantity: 1, price: 2.00  },
                                                { quantity: 4, price: 7.00  }]},
        { name: "B", type: :unit,      prices:  { unit_price: 12.00 } },
        { name: "C", type: :volume,    prices: [{ quantity: 1, price: 1.25  },
                                                { quantity: 6, price: 6.00  }]},
        { name: "D", type: :unit,      prices:  { unit_price: 0.15  } },
        { name: "F", type: :threshold, prices:  { unit_price: 1.00,
                                                  threshold_quantity: 10, threshold_price: 0.90 } }
      ]


run_customer_session(price_points, "ABCDABAA")
run_customer_session(price_points, "CCCCCCC")
run_customer_session(price_points, "ABCD")
run_customer_session(price_points, "FFF")
run_customer_session(price_points, "FFFFFFFFFF")
run_customer_session(price_points, "FFFFFFFFFFFF")
