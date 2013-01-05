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

price_points = [
  { name: "A", quantity: 1,  price: 2.00 },
  { name: "A", quantity: 4,  price: 7.00 },
  { name: "B", quantity: 1,  price: 12.00 },
  { name: "C", quantity: 1,  price: 1.25 },
  { name: "C", quantity: 6,  price: 6.00 },
  { name: "D", quantity: 1,  price: 0.15 },
  { name: "F", quantity: 1,  price: 1.00 },
  { name: "F", quantity: 10, price: 0.90, threshold: true }
]

run_customer_session(price_points, "ABCDABAA")
run_customer_session(price_points, "CCCCCCC")
run_customer_session(price_points, "ABCD")
run_customer_session(price_points, "FFF")
run_customer_session(price_points, "FFFFFFFFFF")
run_customer_session(price_points, "FFFFFFFFFFFF")
