class Cart

	CartItem = Struct.new(:name, :quantity)

	def initialize()
		@items = {}
	end

	def add_item item_name
		@items[item_name] ||= 0
		@items[item_name] += 1
	end

	def items
		@items.map{ |name, count| CartItem.new(name, count)}
	end


end