class BinaryString
	attr_reader :source
	def initialize(source)
		@source = source
	end
	def length()
		@source.length
	end
	def bit(index)
		if index < 0 or index >= @source.length
			raise IndexError.new
		end
		@source[index]
	end
	def pretty()
		prettyString = ''
		times = (@source.length / 4.0).ceil
		(0..times).each do |i|
			start = i * 4
			prettyString += @source.slice start, 4
			prettyString += ' '
		end
		prettyString
	end
	def valid?()
		if @source =~ /^[01]+$/
			true
		else
			false
		end
	end

	def flipBitAt(index)
		if index < 0 or index >= @source.length
			raise IndexError.new
		end
		flipped = @source.dup
		char = flipBit(flipped[index])
		flipped[index] = char
		BinaryString.new flipped
	end
	def to_s()
		@source
	end

	protected
	def flipBit(bit)
		if bit == '1'
			'0'
		else
			'1'
		end
	end
end