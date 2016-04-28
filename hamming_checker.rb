class HammingChecker
	attr_reader :index
	attr_accessor :parity
	def initialize(index)
		@index = index
		@parity = :even
	end

	def valid?(binaryString)
		num_ones = 0
		indexes_to_check = indexes(binaryString.length)
		indexes_to_check.each do |index|
			if binaryString.bit(index) == '1'
				num_ones += 1
			end
		end
		if (@parity == :even and num_ones.even?) or (@parity == :odd and !num_ones.even?)
			true
		else
			false
		end
	end

	# indexes this checker checks
	def indexes(length)
		indexes_array = []
		start = 2**@index - 1
		cycle_length = 2**@index
		current_cycle = 0
		skip = false
		(start..length-1).each do |i|
			if current_cycle >= cycle_length
				current_cycle = 0
				skip = !skip
			end
			if !skip
				indexes_array.push i
			end
			current_cycle += 1
			
		end

		indexes_array
	end
end