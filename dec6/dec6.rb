=begin

Input: 
-string of characters
-appears to be all lowercase

Output:
-number of the last character of the "marker" 
  (number of characters processed)
-marker is a set of 4 unique characters

Example:
-Characters in the string -> potentially broken into array
[m j q j p q m g b l j s p h d z t n v j f q w r c g s m l b]
[m j q j] no
[j q j p] no
[q j p q] no
[j p q m] yes -> index of last character will be 6 (add 1)

Data Structure:
break into an array 
slice the array into subarray as you progress

Algorithm:
-Input the string and break into characters
-Iterate from 0 up to the length (represent index)
  -slice the array from index to index + 3
  -compare the length of slice vs length of uniques slice
    -length is the same -> return the index + 3 (+ 1 for characters processed)

=end

def determine_marker(array)
  0.upto(array.length) do |index|
    marker = array[index..(index + 13)]
    return (index + 14) if marker.uniq.length == marker.length
  end
end

data = File.read('input.txt').chars

characters = determine_marker(data)
p characters


