require './binary_string.rb'
require './hamming_checker.rb'

binary_string = BinaryString.new '100011001010'
LENGTH = 12


#validate binary string
if !binary_string.valid?
	abort "#{binary_string} contains digits other than 0 and 1"
elsif binary_string.source.length != LENGTH
	abort "#{binary_string} is not #{LENGTH} digits"
end



hammingCheckers = []
#calculate hamming codes
(0..Math.log(LENGTH, 2).floor).each do |i|
	hammingCheckers.push HammingChecker.new(i)
end

#print intro
puts "Hamming Solver"
puts "This solver will correct a #{LENGTH} bit binary Hamming encoded string"
puts "of an error of 1 bit\n\n"
#print results
puts 'Hamming codes results for:'
puts binary_string.pretty
puts "\n"
hammingCheckers.each do |checker|
	puts "#{checker.index} Code is #{checker.valid?(binary_string)}"
end


error_indexes_array = nil
valid_indexes_array = []

hammingCheckers.each do |checker|
	indexes = checker.indexes(binary_string.length)
	if !checker.valid? binary_string
		if error_indexes_array.nil?
			error_indexes_array = indexes
		else
			# intersection
			error_indexes_array = error_indexes_array & indexes
		end
	else
		# union
		valid_indexes_array = valid_indexes_array | indexes
	end
end

puts ""

if error_indexes_array.nil?
	puts "Hooray! No errors found"
	exit()
else
	#difference between errors and valid indexes show indexes that need to be corrected
	correction_indexes = error_indexes_array - valid_indexes_array
end

if correction_indexes.length > 1
	puts "Too many errors found (#{correction_indexes.length})"
else
	puts "Error found at index #{correction_indexes[0]}"
	puts "Original:\t#{binary_string.pretty}"
	puts "Corrected:\t#{binary_string.flipBitAt(correction_indexes[0]).pretty}"
end



