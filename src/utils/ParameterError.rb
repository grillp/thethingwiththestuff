class ParameterError < RuntimeError
	def initialize args
		super args
	end
end