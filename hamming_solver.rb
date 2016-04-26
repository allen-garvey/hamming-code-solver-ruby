def isBinary(s)
	if s =~ /^[01]+$/
		true
	else
		false
	end
end

def checkHammingCode(binaryString, startPos, cycleLength, parity='even')
	numOnes = 0
	cycleNum = 0
	(startPos..binaryString.length - 1).each do |i|
		normalizedPosition = i - startPos
		if normalizedPosition > 0 && normalizedPosition % cycleLength == 0
			cycleNum += 1
		end
		if cycleNum % 2 == 0 and binaryString[i] == '1'
			numOnes += 1
		end
		# puts "cycleNum is #{cycleNum}"
		# puts "current char is #{binaryString[i]}"
	end
	if (numOnes.even? and parity == 'even') or (!numOnes.even? and parity == 'odd')
		true
	else
		false
	end
end

def binaryPrettyString(binaryString)
	prettyString = ''
	times = (binaryString.length / 4.0).ceil
	(0..times).each do |i|
		start = i * 4
		prettyString += binaryString.slice start, 4
		prettyString += ' '
	end

	prettyString
end

def numErrors(codeStatuses)
	codeStatuses.inject(0) do |total, status|  
		if status
			total + 1
		else
			total
		end
	end
end

def errorIndexes(codeStatuses)
	errors = []
	(0..codeStatuses.length - 1).each do |i|
		if !codeStatuses[i]
			errors.push i
		end
	end
	errors
end

def flipBit(binaryString, index)
	char = binaryString[index]
	if char == '1'
		flip = '0'
	else
		flip = '1'
	end
	binaryString[index] = flip
	binaryString
end


binary_string = '100011001010'

#validate binary string
if !isBinary(binary_string)
	abort "#{binary_string} contains digits other than 0 and 1"
elsif binary_string.length != 12
	abort "#{binary_string} is not 12 digits"
end




codePowers = (0..3)
codeStatuses = []

#calculate hamming codes
codePowers.each do |power|
	status = checkHammingCode(binary_string, 2**power - 1, 2**power)
	codeStatuses.push status
end

#print intro
puts "Hamming Solver"
puts "This solver will correct a 12 bit binary Hamming encoded string"
puts "of an error of 1 bit\n\n"
#print results
puts 'Hamming codes results for:'
puts binaryPrettyString(binary_string)
puts "\n"
codePowers.each do |i|
	if i == 0
		power = 0
	else
		power = 2 ** i
	end
	puts "#{power} Code is #{codeStatuses[i]}"
end


errorIndexesArray = errorIndexes(codeStatuses)
indexToFlip = nil

puts ""
case errorIndexesArray.length
	when 0
		puts 'Hooray! No errors found'
	when 1
		indexToFlip = 2 ** errorIndexesArray[0] - 1
	else
		puts 'Not handled yet'
end

unless indexToFlip.nil?
	puts 'Corrected string should be:'
	puts binaryPrettyString(flipBit(binary_string, indexToFlip))
end


